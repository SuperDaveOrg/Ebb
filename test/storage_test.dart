import 'dart:io';

import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';
import 'package:ebb/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Runs the real schema and migrations against SQLite on the host.
void main() {
  sqfliteFfiInit();
  final factory = databaseFactoryFfi;

  late Directory dir;
  late String path;
  late EbbDatabase db;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('ebb_test');
    path = '${dir.path}/ebb.db';
    db = EbbDatabase(path: path, factory: factory);
  });

  tearDown(() async {
    await db.close();
    await dir.delete(recursive: true);
  });

  final mar1 = DateTime(2026, 3, 1);

  group('migrations', () {
    /// The schema exactly as version 1 shipped it.
    Future<void> createVersion1() async {
      final v1 = await factory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (d, _) async {
            await d.execute(
              'CREATE TABLE cycles (id INTEGER PRIMARY KEY '
              'AUTOINCREMENT, start_date TEXT NOT NULL UNIQUE, end_date '
              'TEXT, notes TEXT)',
            );
            await d.execute(
              "CREATE TABLE day_logs (id INTEGER PRIMARY KEY "
              "AUTOINCREMENT, log_date TEXT NOT NULL UNIQUE, flow TEXT NOT "
              "NULL DEFAULT 'none', symptoms TEXT NOT NULL DEFAULT '', "
              "notes TEXT)",
            );
          },
        ),
      );
      await v1.insert('cycles', {
        'start_date': '2026-03-01',
        'end_date': '2026-03-05',
        'notes': 'x',
      });
      await v1.insert('day_logs', {
        'log_date': '2026-03-02',
        'flow': 'heavy',
        'symptoms': 'cramps',
      });
      await v1.close();
    }

    test('version 1 data survives into the primary profile', () async {
      await createVersion1();
      final repo = CycleRepository(db: db);

      final cycles = await repo.allCycles();
      expect(cycles, hasLength(1));
      expect(cycles.single.start, mar1);
      expect(cycles.single.end, DateTime(2026, 3, 5));
      expect(cycles.single.notes, 'x');
      expect(cycles.single.excluded, isFalse);

      final log = await repo.logFor(DateTime(2026, 3, 2));
      expect(log!.flow, Flow.heavy);
      expect(log.symptoms, ['cramps']);

      expect((await ProfileRepository(db: db).primary()).name, isNull);
    });

    test('a fresh install and an upgraded one end up identical', () async {
      Future<Map<String, List<String>>> shape(EbbDatabase d) async {
        final raw = await d.database;
        return {
          for (final t in ['profiles', 'cycles', 'day_logs'])
            t: (await raw.rawQuery('PRAGMA table_info($t)'))
                .map(
                  (c) =>
                      '${c['name']} ${c['type']} ${c['notnull']} '
                      '${c['dflt_value']}',
                )
                .toList(),
        };
      }

      final fresh = await shape(db);
      await db.close();
      await File(path).delete();

      await createVersion1();
      final upgraded = await shape(
        db = EbbDatabase(path: path, factory: factory),
      );
      expect(upgraded, fresh);
    });
  });

  group('profiles', () {
    test('each person has their own history', () async {
      final second = await ProfileRepository(db: db)
          .add(const Profile(name: 'A'));
      final mine = CycleRepository(db: db);
      final theirs = CycleRepository(db: db, profileId: second);

      await mine.startPeriod(mar1);
      await theirs.startPeriod(mar1); // same day, different person: fine
      await theirs.startPeriod(DateTime(2026, 3, 29));

      expect(await mine.allCycles(), hasLength(1));
      expect(await theirs.allCycles(), hasLength(2));
    });

    test('a repository cannot touch another person\'s cycles', () async {
      final second = await ProfileRepository(db: db).add(const Profile());
      final mine = CycleRepository(db: db);
      final theirs = CycleRepository(db: db, profileId: second);

      final id = await theirs.startPeriod(mar1);
      await mine.deleteCycle(id);
      await mine.endPeriod(id, DateTime(2026, 3, 4));

      final kept = await theirs.allCycles();
      expect(kept, hasLength(1));
      expect(kept.single.end, isNull);
    });

    test('removing a profile removes its data and nothing else', () async {
      final profiles = ProfileRepository(db: db);
      final second = await profiles.add(const Profile(name: 'A'));
      await CycleRepository(db: db).startPeriod(mar1);
      await CycleRepository(db: db, profileId: second).startPeriod(mar1);

      await profiles.remove(second);

      final raw = await db.database;
      expect(await raw.query('cycles'), hasLength(1));
      expect(
        () => profiles.remove(EbbDatabase.primaryProfileId),
        throwsArgumentError,
      );
    });

    test('delete all data leaves one blank primary profile', () async {
      final profiles = ProfileRepository(db: db);
      await profiles.rename(EbbDatabase.primaryProfileId, 'Me');
      await profiles.add(const Profile(name: 'A'));
      await CycleRepository(db: db).startPeriod(mar1);

      await db.deleteAllData();

      final left = await profiles.all();
      expect(left, hasLength(1));
      expect(left.single.id, EbbDatabase.primaryProfileId);
      expect(left.single.name, isNull);
      expect(await CycleRepository(db: db).allCycles(), isEmpty);
    });
  });

  test('logging the same start twice keeps the end date', () async {
    final repo = CycleRepository(db: db);
    final id = await repo.startPeriod(mar1);
    await repo.endPeriod(id, DateTime(2026, 3, 5));

    expect(await repo.startPeriod(mar1), id);
    expect((await repo.allCycles()).single.end, DateTime(2026, 3, 5));
  });

  test('excluded survives a round trip through storage', () async {
    final repo = CycleRepository(db: db);
    await repo.addCycle(Cycle(start: mar1, excluded: true));
    expect((await repo.allCycles()).single.excluded, isTrue);
  });
}
