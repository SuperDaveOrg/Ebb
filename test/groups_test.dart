import 'dart:convert';
import 'dart:io';

import 'package:ebb/data/backup.dart';
import 'package:ebb/data/backup_service.dart';
import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/group_repository.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Groups: the advanced option for circles and clubs. All fictional.
void main() {
  sqfliteFfiInit();
  final factory = databaseFactoryFfi;

  late Directory dir;
  late EbbDatabase db;
  late GroupRepository groups;
  late ProfileRepository people;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('ebb_groups_test');
    db = EbbDatabase(path: '${dir.path}/ebb.db', factory: factory);
    groups = GroupRepository(db: db);
    people = ProfileRepository(db: db);
  });

  tearDown(() async {
    await db.close();
    await dir.delete(recursive: true);
  });

  group('repository', () {
    test('groups are made, named and filled', () async {
      final ana = await people.add(const Profile(name: 'Ana'));
      final bea = await people.add(const Profile(name: 'Bea'));
      final circle = await groups.add('Moon circle');
      await groups.add('Book club');
      await groups.setMembers(circle, [bea, EbbDatabase.primaryProfileId]);

      final all = await groups.all();
      expect(all.map((g) => g.name), ['Book club', 'Moon circle']);
      expect(all[1].memberIds, [EbbDatabase.primaryProfileId, bea]);
      expect(all[0].memberIds, isEmpty);

      await groups.setMembers(circle, [ana]);
      expect((await groups.all())[1].memberIds, [ana]);
    });

    test('names are unique, ignoring case', () async {
      await groups.add('Moon circle');
      expect(() => groups.add('moon CIRCLE'), throwsA(anything));
    });

    test('deleting a group leaves its people and their history', () async {
      final ana = await people.add(const Profile(name: 'Ana'));
      await CycleRepository(
        db: db,
        profileId: ana,
      ).addCycle(Cycle(start: DateTime(2026, 3, 1)));
      final circle = await groups.add('Moon circle');
      await groups.setMembers(circle, [ana]);

      await groups.delete(circle);
      expect(await groups.all(), isEmpty);
      expect((await people.all()).map((p) => p.name), [null, 'Ana']);
      expect(
        await CycleRepository(db: db, profileId: ana).allCycles(),
        hasLength(1),
      );
    });

    test('removing a person takes her out of every group', () async {
      final ana = await people.add(const Profile(name: 'Ana'));
      final a = await groups.add('A');
      final b = await groups.add('B');
      await groups.setMembers(a, [ana]);
      await groups.setMembers(b, [ana, EbbDatabase.primaryProfileId]);

      await people.remove(ana);
      final all = await groups.all();
      expect(all.map((g) => g.memberIds), [
        <int>[],
        [EbbDatabase.primaryProfileId],
      ]);
    });

    test('delete all data takes the groups too', () async {
      await groups.add('Moon circle');
      await db.deleteAllData();
      expect(await groups.all(), isEmpty);
    });
  });

  group('backup', () {
    Future<void> circleOfThree() async {
      final ana = await people.add(const Profile(name: 'Ana'));
      final bea = await people.add(const Profile(name: 'Bea'));
      final circle = await groups.add('Moon circle');
      await groups.setMembers(circle, [EbbDatabase.primaryProfileId, bea]);
      await groups.setMembers(await groups.add('Family'), [ana]);
    }

    test('a whole-phone backup carries groups, by place in the file', () async {
      await circleOfThree();
      final backup = await BackupService(db: db).snapshot();
      expect(backup.groups.map((g) => g.name), ['Family', 'Moon circle']);
      expect(backup.groups.map((g) => g.members), [
        [1],
        [0, 2],
      ]);
    });

    test('sending one person carries none', () async {
      await circleOfThree();
      final one = await BackupService(db: db)
          .snapshot(onlyProfileId: EbbDatabase.primaryProfileId);
      expect(one.groups, isEmpty);
      expect(encodeBackup(one), isNot(contains('"groups"')));
    });

    test('restore brings the groups back with the right people', () async {
      await circleOfThree();
      final text = encodeBackup(await BackupService(db: db).snapshot());
      await db.deleteAllData();

      await BackupService(db: db).restore(decodeBackup(text));
      final names = {
        for (final p in await people.all()) p.id: p.name ?? 'owner',
      };
      final restored = await groups.all();
      expect(restored.map((g) => g.name), ['Family', 'Moon circle']);
      expect(restored.map((g) => [for (final id in g.memberIds) names[id]]), [
        ['Ana'],
        ['owner', 'Bea'],
      ]);
    });

    String withGroups(Object? groups) => encodeBackupJson({
      'ebbBackup': 2,
      'exportedOn': '2026-09-26',
      'people': [
        {'name': null, 'cycles': []},
        {'name': 'Ana', 'cycles': []},
      ],
      'groups': groups,
    });

    void rejects(Object? groups) => expect(
      () => decodeBackup(withGroups(groups)),
      throwsA(isA<BackupFormatException>()),
    );

    test('a file with bad groups is refused whole', () {
      rejects('not a list');
      rejects([
        {'name': '', 'members': []},
      ]);
      rejects([
        {'name': ' Circle', 'members': []},
      ]);
      rejects([
        {
          'name': 'Circle',
          'members': [2],
        },
      ]);
      rejects([
        {
          'name': 'Circle',
          'members': [1, 1],
        },
      ]);
      rejects([
        {'name': 'Circle', 'members': []},
        {'name': 'circle', 'members': []},
      ]);
      expect(
        decodeBackup(
          withGroups([
            {
              'name': 'Circle',
              'members': [0, 1],
            },
          ]),
        ).groups.single.members,
        [0, 1],
      );
    });
  });
}

String encodeBackupJson(Map<String, Object?> json) => jsonEncode(json);
