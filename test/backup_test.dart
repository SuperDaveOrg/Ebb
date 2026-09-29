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

void main() {
  final mar1 = DateTime(2026, 3, 1);

  group('file format', () {
    final sample = Backup(
      exportedOn: DateTime(2026, 9, 26),
      people: [
        BackupPerson(
          profile: const Profile(),
          cycles: [
            Cycle(start: mar1, end: DateTime(2026, 3, 5)),
            Cycle(start: DateTime(2026, 3, 29), excluded: true, notes: 'flu'),
          ],
          days: [
            DayLog(
              date: DateTime(2026, 3, 2),
              flow: Flow.heavy,
              symptoms: const ['cramps', 'tired, a bit'],
              notes: 'long day',
            ),
          ],
        ),
        const BackupPerson(profile: Profile(name: 'Sam')),
      ],
    );

    test('round-trips everything', () {
      final back = decodeBackup(encodeBackup(sample));
      expect(back.exportedOn, DateTime(2026, 9, 26));
      expect(back.people, hasLength(2));
      expect(back.people[1].profile.name, 'Sam');

      final me = back.people[0];
      expect(me.cycles.map((c) => (c.start, c.end, c.excluded, c.notes)), [
        (mar1, DateTime(2026, 3, 5), false, null),
        (DateTime(2026, 3, 29), null, true, 'flu'),
      ]);
      final day = me.days.single;
      expect(day.flow, Flow.heavy);
      expect(day.symptoms, ['cramps', 'tired, a bit']);
      expect(day.notes, 'long day');
    });

    test('is readable, documented JSON', () {
      final json = jsonDecode(encodeBackup(sample)) as Map<String, Object?>;
      expect(json['ebbBackup'], 1);
      final cycle = ((json['people'] as List)[0] as Map)['cycles'][0] as Map;
      expect(cycle, {'start': '2026-03-01', 'end': '2026-03-05'});
    });

    String file(Object? people, {Object? version = 1}) => jsonEncode({
      'ebbBackup': version,
      'exportedOn': '2026-09-26',
      'people': people,
    });

    String withCycles(List<Map<String, Object?>> cycles) => file([
      {'name': null, 'cycles': cycles},
    ]);

    void rejects(String text, Matcher message) => expect(
      () => decodeBackup(text),
      throwsA(
        isA<BackupFormatException>().having(
          (e) => e.message,
          'message',
          message,
        ),
      ),
    );

    test('rejects files that are not Ebb backups', () {
      rejects('not json', contains("isn't an Ebb backup"));
      rejects('{"hello": 1}', contains("isn't an Ebb backup"));
      rejects('[1, 2]', contains("isn't an Ebb backup"));
    });

    test('refuses a newer format rather than half-reading it', () {
      rejects(file([], version: 2), contains('newer version'));
    });

    test('rejects impossible and malformed dates', () {
      rejects(
        withCycles([
          {'start': '2026-02-30'},
        ]),
        contains('damaged'),
      );
      rejects(
        withCycles([
          {'start': '2026-3-1'},
        ]),
        contains('damaged'),
      );
      rejects(
        withCycles([
          {'start': 20260301},
        ]),
        contains('damaged'),
      );
    });

    test('rejects contradictory periods', () {
      rejects(
        withCycles([
          {'start': '2026-03-05', 'end': '2026-03-01'},
        ]),
        contains('ends before it begins'),
      );
      rejects(
        withCycles([
          {'start': '2026-03-01'},
          {'start': '2026-03-01'},
        ]),
        contains('Two periods start'),
      );
    });

    test('rejects an unknown flow rather than silently dropping it', () {
      rejects(
        file([
          {
            'name': null,
            'cycles': [],
            'days': [
              {'date': '2026-03-01', 'flow': 'torrential'},
            ],
          },
        ]),
        contains('flow'),
      );
    });

    test('a file written by an earlier build still restores', () {
      // Fixed fixture, not regenerated: if this breaks, the format changed in
      // a way that strands existing backups and QR captures.
      final fixture = File('test/fixtures/qr_transfer/sample-backup.json');
      final backup = decodeBackup(fixture.readAsStringSync());
      expect(backup.cycleCount, 32);
      expect(backup.people.map((p) => p.profile.name), [null, 'Sam']);
      expect(backup.people.first.cycles.where((c) => c.excluded), hasLength(2));
    });

    test('rejects a backup with nobody in it', () {
      rejects(file([]), contains('no one'));
    });

    test('rejects overlapping periods', () {
      rejects(
        withCycles([
          {'start': '2026-03-01', 'end': '2026-03-05'},
          {'start': '2026-03-05'},
        ]),
        contains('overlaps'),
      );
    });

    test('rejects anything dated after the backup was made', () {
      rejects(
        withCycles([
          {'start': '2026-09-27'},
        ]),
        contains('after the day'),
      );
      rejects(
        withCycles([
          {'start': '2026-09-20', 'end': '2026-09-27'},
        ]),
        contains('after the day'),
      );
      rejects(
        file([
          {
            'name': null,
            'cycles': [],
            'days': [
              {'date': '2026-09-27'},
            ],
          },
        ]),
        contains('after the day'),
      );
    });

    test('rejects names Ebb could not have written', () {
      Map<String, Object?> named(Object? name) => {'name': name, 'cycles': []};
      for (final bad in ['', '   ', ' Sam', 'x' * 31, 7]) {
        rejects(file([named(null), named(bad)]), contains('a name'));
      }
      rejects(
        file([named(null), named('Sam'), named('sam')]),
        contains('both called'),
      );
    });
  });

  group('restore', () {
    sqfliteFfiInit();
    late Directory dir;
    late EbbDatabase db;

    setUp(() async {
      dir = await Directory.systemTemp.createTemp('ebb_test');
      db = EbbDatabase(path: '${dir.path}/ebb.db', factory: databaseFactoryFfi);
    });

    tearDown(() async {
      await db.close();
      await dir.delete(recursive: true);
    });

    test(
      'backing up and restoring onto an empty phone loses nothing',
      () async {
        final sam = await ProfileRepository(db: db)
            .add(const Profile(name: 'Sam'));
        final mine = CycleRepository(db: db);
        await mine.addCycle(Cycle(start: mar1, end: DateTime(2026, 3, 5)));
        await mine.addCycle(
          Cycle(start: DateTime(2026, 3, 29), excluded: true),
        );
        await mine.saveLog(
          DayLog(
            date: DateTime(2026, 3, 2),
            flow: Flow.light,
            symptoms: const ['a'],
          ),
        );
        await CycleRepository(db: db, profileId: sam).startPeriod(mar1);

        final text = encodeBackup(await BackupService(db: db).snapshot());
        await db.deleteAllData();
        await BackupService(db: db).restore(decodeBackup(text));

        expect(encodeBackup(await BackupService(db: db).snapshot()), text);
        final profiles = await ProfileRepository(db: db).all();
        expect(profiles.map((p) => (p.id, p.name)), [
          (EbbDatabase.primaryProfileId, null),
          (2, 'Sam'),
        ]);
      },
    );

    test('anyone unnamed after the owner gets a placeholder name', () {
      Backup people(List<String?> names) => Backup(
        exportedOn: mar1,
        people: [
          for (final n in names) BackupPerson(profile: Profile(name: n)),
        ],
      );
      expect(BackupService.restoredNames(people([null, null, null])), [
        null,
        'Person 2',
        'Person 3',
      ]);
      // Placeholders never collide with a real name, whatever its case.
      expect(BackupService.restoredNames(people([null, null, 'person 2'])), [
        null,
        'Person 3',
        'person 2',
      ]);
    });

    test('a restored person without a name is given one', () async {
      await BackupService(db: db).restore(
        Backup(
          exportedOn: mar1,
          people: [
            BackupPerson(
              profile: const Profile(),
              cycles: [Cycle(start: mar1)],
            ),
            const BackupPerson(profile: Profile()),
          ],
        ),
      );
      final profiles = await ProfileRepository(db: db).all();
      expect(profiles.map((p) => p.name), [null, 'Person 2']);
    });

    test('backs up every day log, however far off its date', () async {
      final mine = CycleRepository(db: db);
      await mine.saveLog(DayLog(date: DateTime(1850, 1, 1), notes: 'old'));
      await mine.saveLog(DayLog(date: DateTime(2250, 1, 1), notes: 'new'));
      final days = (await BackupService(db: db).snapshot()).people.single.days;
      expect(days.map((d) => d.notes), ['old', 'new']);
    });

    test('restore replaces what was there', () async {
      await CycleRepository(db: db).startPeriod(DateTime(2025, 1, 1));
      await BackupService(db: db).restore(
        Backup(
          exportedOn: mar1,
          people: [
            BackupPerson(
              profile: const Profile(),
              cycles: [Cycle(start: mar1)],
            ),
          ],
        ),
      );
      final cycles = await CycleRepository(db: db).allCycles();
      expect(cycles.map((c) => c.start), [mar1]);
    });

    test('a restore that fails part-way changes nothing', () async {
      await CycleRepository(db: db).startPeriod(DateTime(2025, 1, 1));
      // Built by hand to get past the decoder: a duplicate start trips the
      // database's UNIQUE constraint after the old data has been cleared.
      final broken = Backup(
        exportedOn: mar1,
        people: [
          BackupPerson(
            profile: const Profile(),
            cycles: [
              Cycle(start: mar1),
              Cycle(start: mar1),
            ],
          ),
        ],
      );

      await expectLater(
        BackupService(db: db).restore(broken),
        throwsA(anything),
      );
      final cycles = await CycleRepository(db: db).allCycles();
      expect(cycles.map((c) => c.start), [DateTime(2025, 1, 1)]);
    });
  });

  group('handing someone over', () {
    sqfliteFfiInit();
    late Directory dir;

    setUp(() async => dir = await Directory.systemTemp.createTemp('ebb_test'));
    tearDown(() async => dir.delete(recursive: true));

    EbbDatabase phone(String name) =>
        EbbDatabase(path: '${dir.path}/$name.db', factory: databaseFactoryFfi);

    test(
      'one person travels alone and becomes the owner of their own phone',
      () async {
        final parents = phone('parent');
        final sam = await ProfileRepository(db: parents)
            .add(const Profile(name: 'Sam'));
        await CycleRepository(db: parents).startPeriod(DateTime(2026, 1, 1));
        await CycleRepository(
          db: parents,
          profileId: sam,
        ).addCycle(Cycle(start: mar1, end: DateTime(2026, 3, 4)));

        final sent = await BackupService(db: parents)
            .snapshot(onlyProfileId: sam);
        expect(sent.people.single.profile.name, 'Sam');
        expect(sent.cycleCount, 1);

        final samsPhone = phone('sam');
        expect(await BackupService(db: samsPhone).isEmpty(), isTrue);
        await BackupService(db: samsPhone)
            .restore(decodeBackup(encodeBackup(sent, pretty: false)));

        // On Sam's phone, Sam is the owner.
        final owner = await ProfileRepository(db: samsPhone).primary();
        expect(owner.name, 'Sam');
        expect(
          (await CycleRepository(db: samsPhone).allCycles()).single.start,
          mar1,
        );
        expect(await ProfileRepository(db: samsPhone).all(), hasLength(1));

        await parents.close();
        await samsPhone.close();
      },
    );

    test('adding someone received leaves everyone here untouched', () async {
      final db = phone('shared');
      await CycleRepository(db: db).startPeriod(DateTime(2026, 1, 1));

      final id = await BackupService(db: db).addPerson(
        BackupPerson(
          profile: const Profile(),
          cycles: [Cycle(start: mar1)],
          days: [DayLog(date: mar1, flow: Flow.light)],
        ),
        name: 'Robin',
      );

      final people = await ProfileRepository(db: db).all();
      expect(people.map((p) => p.name), [null, 'Robin']);
      expect(
        (await CycleRepository(db: db).allCycles()).single.start,
        DateTime(2026, 1, 1),
      );
      final robin = CycleRepository(db: db, profileId: id);
      expect((await robin.allCycles()).single.start, mar1);
      expect((await robin.logFor(mar1))!.flow, Flow.light);
      expect(await BackupService(db: db).isEmpty(), isFalse);
      await db.close();
    });
  });
}
