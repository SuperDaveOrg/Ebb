import 'dart:convert';
import 'dart:io';

import 'package:ebb/data/backup.dart';
import 'package:ebb/data/backup_service.dart';
import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';
import 'package:ebb/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Sharing one person between phones: lasting ids, updating someone sent
/// again, and read-only shared copies. All fictional.
void main() {
  sqfliteFfiInit();
  final factory = databaseFactoryFfi;

  late Directory dir;
  late EbbDatabase db;
  late BackupService backups;
  late ProfileRepository people;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('ebb_sharing_test');
    db = EbbDatabase(path: '${dir.path}/ebb.db', factory: factory);
    backups = BackupService(db: db);
    people = ProfileRepository(db: db);
  });

  tearDown(() async {
    await db.close();
    await dir.delete(recursive: true);
  });

  BackupPerson ana({String uid = 'ana-1', int periods = 2}) => BackupPerson(
    profile: Profile(uid: uid),
    cycles: [
      for (var i = 0; i < periods; i++)
        Cycle(start: DateTime(2026, 3 + i, 1), end: DateTime(2026, 3 + i, 4)),
    ],
  );

  Future<int> periodsOf(int profileId) async =>
      (await CycleRepository(db: db, profileId: profileId).allCycles()).length;

  test(
    'everyone has an id, the owner included, and after delete all',
    () async {
      final owner = await people.primary();
      expect(owner.uid, matches(Profile.uidPattern));
      final other = await people.add(const Profile(name: 'Bea'));
      final all = await people.all();
      expect(all.map((p) => p.uid).toSet(), hasLength(2));
      expect(all.last.id, other);

      await db.deleteAllData();
      final fresh = await people.primary();
      expect(fresh.uid, matches(Profile.uidPattern));
      expect(fresh.uid, isNot(owner.uid));
    },
  );

  test('a shared copy keeps her id and the day she sent it', () async {
    final id = await backups.addPerson(
      ana(),
      name: 'Ana',
      sharedOn: DateTime(2026, 9, 1),
    );
    final copy = (await people.all()).firstWhere((p) => p.id == id);
    expect(copy.uid, 'ana-1');
    expect(copy.isSharedCopy, isTrue);
    expect(copy.sharedOn, DateTime(2026, 9, 1));
    expect((await backups.personWithUid('ana-1'))?.id, id);
    expect(await backups.personWithUid('nobody'), isNull);
  });

  test('someone added as new is not a copy', () async {
    final id = await backups.addPerson(ana(), name: 'Ana');
    final p = (await people.all()).firstWhere((p) => p.id == id);
    expect(p.isSharedCopy, isFalse);
  });

  test('an id already here is not reused', () async {
    final owner = await people.primary();
    final id = await backups.addPerson(ana(uid: owner.uid!), name: 'Ana');
    final p = (await people.all()).firstWhere((p) => p.id == id);
    expect(p.uid, isNot(owner.uid));
  });

  test('updating replaces her history and moves the copy date on', () async {
    final id = await backups.addPerson(
      ana(),
      name: 'Ana here',
      sharedOn: DateTime(2026, 9, 1),
    );
    await backups.updatePerson(
      id,
      ana(periods: 5),
      sentOn: DateTime(2026, 9, 28),
    );
    expect(await periodsOf(id), 5);
    final copy = (await people.all()).firstWhere((p) => p.id == id);
    expect(copy.name, 'Ana here');
    expect(copy.sharedOn, DateTime(2026, 9, 28));
  });

  test('updating someone who is not a copy leaves her editable', () async {
    final id = await backups.addPerson(ana(), name: 'Ana');
    await backups.updatePerson(
      id,
      ana(periods: 3),
      sentOn: DateTime(2026, 9, 28),
    );
    final p = (await people.all()).firstWhere((p) => p.id == id);
    expect(p.isSharedCopy, isFalse);
    expect(await periodsOf(id), 3);
  });

  test('a whole-phone backup keeps ids and copies through restore', () async {
    await backups.addPerson(ana(), name: 'Ana', sharedOn: DateTime(2026, 9, 1));
    final ownerUid = (await people.primary()).uid;
    final text = encodeBackup(await backups.snapshot());
    await db.deleteAllData();

    await backups.restore(decodeBackup(text));
    final all = await people.all();
    expect(all.first.uid, ownerUid);
    expect(all.first.isSharedCopy, isFalse);
    expect(all.last.uid, 'ana-1');
    expect(all.last.sharedOn, DateTime(2026, 9, 1));
  });

  group('file format', () {
    String file(List<Map<String, Object?>> people) => jsonEncode({
      'ebbBackup': 2,
      'exportedOn': '2026-09-26',
      'people': people,
    });

    void rejects(List<Map<String, Object?>> people) => expect(
      () => decodeBackup(file(people)),
      throwsA(isA<BackupFormatException>()),
    );

    test('reads ids and shared dates, and older files without them', () {
      final b = decodeBackup(
        file([
          {'name': null, 'cycles': [], 'id': 'me'},
          {
            'name': 'Ana',
            'cycles': [],
            'id': 'ana-1',
            'sharedOn': '2026-09-01',
          },
          {'name': 'Bea', 'cycles': []},
        ]),
      );
      expect(b.people.map((p) => p.profile.uid), ['me', 'ana-1', null]);
      expect(b.people[1].profile.sharedOn, DateTime(2026, 9, 1));
    });

    test('refuses a bad or repeated id, or a copy dated after the file', () {
      rejects([
        {'name': null, 'cycles': [], 'id': 'has space'},
      ]);
      rejects([
        {'name': null, 'cycles': [], 'id': ''},
      ]);
      rejects([
        {'name': null, 'cycles': [], 'id': 'x'},
        {'name': 'Ana', 'cycles': [], 'id': 'x'},
      ]);
      rejects([
        {'name': null, 'cycles': []},
        {'name': 'Ana', 'cycles': [], 'sharedOn': '2026-09-27'},
      ]);
    });
  });

  group('sending less', () {
    final asOf = DateTime(2026, 9, 29);
    final person = BackupPerson(
      profile: const Profile(uid: 'me'),
      cycles: [
        Cycle(start: DateTime(2025, 12, 1), end: DateTime(2025, 12, 5)),
        Cycle(
          start: DateTime(2026, 7, 10),
          end: DateTime(2026, 7, 14),
          notes: 'private',
        ),
        Cycle(start: DateTime(2026, 9, 5), end: DateTime(2026, 9, 9)),
      ],
      days: [
        DayLog(date: DateTime(2025, 12, 2), rating: 2),
        DayLog(date: DateTime(2026, 7, 11), notes: 'long day'),
        DayLog(date: DateTime(2026, 9, 20), rating: 4),
      ],
    );

    List<DateTime> starts(BackupPerson p) => [
      for (final c in p.cycles) c.start,
    ];

    test('everything keeps everything', () {
      final all = person.trimmed(
        span: SendSpan.everything,
        periodsOnly: false,
        asOf: asOf,
      );
      expect(all.cycles, hasLength(3));
      expect(all.days, hasLength(3));
      expect(all.cycles[1].notes, 'private');
      expect(all.profile.uid, 'me');
    });

    test('a span keeps periods and days that fall inside it', () {
      final three = person.trimmed(
        span: SendSpan.months3,
        periodsOnly: false,
        asOf: asOf,
      );
      // 91 days back from Sep 29 is Jul 1.
      expect(starts(three), [DateTime(2026, 7, 10), DateTime(2026, 9, 5)]);
      expect(three.days.map((d) => d.date), [
        DateTime(2026, 7, 11),
        DateTime(2026, 9, 20),
      ]);
    });

    test('the latest period is that one and the days since', () {
      final latest = person.trimmed(
        span: SendSpan.latest,
        periodsOnly: false,
        asOf: asOf,
      );
      expect(starts(latest), [DateTime(2026, 9, 5)]);
      expect(latest.days.single.date, DateTime(2026, 9, 20));
    });

    test('periods only leaves out day entries and notes on periods', () {
      final bare = person.trimmed(
        span: SendSpan.everything,
        periodsOnly: true,
        asOf: asOf,
      );
      expect(bare.cycles, hasLength(3));
      expect(bare.cycles.every((c) => c.notes == null), isTrue);
      expect(bare.days, isEmpty);
    });
  });
}
