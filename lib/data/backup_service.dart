import 'package:ebb/data/backup.dart';
import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/domain/dates.dart';

/// Moves the whole database to and from a [Backup].
class BackupService {
  BackupService({EbbDatabase? db}) : _db = db ?? EbbDatabase.instance;

  final EbbDatabase _db;

  /// Everything on the phone, every person — or only the person with
  /// [onlyProfileId], for handing one person's history to their own phone.
  Future<Backup> snapshot({int? onlyProfileId}) async {
    final profiles = (await ProfileRepository(db: _db).all())
        .where((p) => onlyProfileId == null || p.id == onlyProfileId)
        .toList();
    final people = <BackupPerson>[];
    for (final profile in profiles) {
      final repo = CycleRepository(db: _db, profileId: profile.id!);
      people.add(
        BackupPerson(
          profile: profile,
          cycles: await repo.allCycles(),
          days: await repo.allLogs(),
        ),
      );
    }
    return Backup(exportedOn: today(), people: people);
  }

  /// Replaces everything on the phone with [backup], in one transaction: if
  /// any row fails, the database is left exactly as it was.
  ///
  /// Profiles are renumbered from the primary ID, so the first person in the
  /// file becomes the one the app shows. Anyone else without a name gets a
  /// placeholder (see [restoredNames]).
  Future<void> restore(Backup backup) async {
    final names = restoredNames(backup);
    final db = await _db.database;
    await db.transaction((txn) async {
      await EbbDatabase.resetAll(txn);
      for (var i = 0; i < backup.people.length; i++) {
        final person = backup.people[i];
        final profileId = EbbDatabase.primaryProfileId + i;
        // resetAll left a blank primary profile; the rest are new.
        if (profileId == EbbDatabase.primaryProfileId) {
          await txn.update(
            'profiles',
            {'name': names[i]},
            where: 'id = ?',
            whereArgs: [profileId],
          );
        } else {
          await txn.insert('profiles', {'id': profileId, 'name': names[i]});
        }
        for (final c in person.cycles) {
          await txn.insert('cycles', {
            ...c.toRow()..remove('id'),
            'profile_id': profileId,
          });
        }
        for (final d in person.days) {
          await txn.insert('day_logs', {
            ...d.toRow()..remove('id'),
            'profile_id': profileId,
          });
        }
      }
    });
  }

  /// The name each person in [backup] will have once restored.
  ///
  /// The first person is the owner and may stay unnamed. Anyone else is
  /// always called by name, so an unnamed one — possible in the format,
  /// though Ebb never writes it — becomes "Person 2", "Person 3" and so on,
  /// skipping any already taken. It can be renamed in their settings.
  static List<String?> restoredNames(Backup backup) {
    final taken = {
      for (final p in backup.people)
        if (p.profile.name != null) p.profile.name!.toLowerCase(),
    };
    final names = <String?>[];
    var n = 1;
    for (final (i, person) in backup.people.indexed) {
      var name = person.profile.name;
      if (i > 0 && name == null) {
        do {
          name = 'Person ${++n}';
        } while (!taken.add(name.toLowerCase()));
      }
      names.add(name);
    }
    return names;
  }

  /// Adds [person] to the phone as someone new, called [name], leaving
  /// everyone already here untouched. All or nothing, like [restore].
  Future<int> addPerson(BackupPerson person, {required String name}) async {
    final db = await _db.database;
    return db.transaction((txn) async {
      final profileId = await txn.insert('profiles', {'name': name});
      for (final c in person.cycles) {
        await txn.insert('cycles', {
          ...c.toRow()..remove('id'),
          'profile_id': profileId,
        });
      }
      for (final d in person.days) {
        await txn.insert('day_logs', {
          ...d.toRow()..remove('id'),
          'profile_id': profileId,
        });
      }
      return profileId;
    });
  }

  /// True when nothing has been logged yet — a phone just set up. Receiving
  /// one person here makes them the phone's owner rather than a guest.
  Future<bool> isEmpty() async {
    final b = await snapshot();
    return b.people.length == 1 && b.cycleCount == 0 && b.dayCount == 0;
  }
}
