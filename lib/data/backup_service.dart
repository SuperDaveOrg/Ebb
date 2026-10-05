import 'package:ebb/data/backup.dart';
import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/data/database.dart';
import 'package:ebb/data/group_repository.dart';
import 'package:ebb/data/profile_repository.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/models/profile.dart';
import 'package:sqflite/sqflite.dart';

/// Moves the whole database to and from a [Backup].
class BackupService {
  BackupService({EbbDatabase? db}) : _db = db ?? EbbDatabase.instance;

  final EbbDatabase _db;

  /// Everything on the phone, every person and group — or only the person
  /// with [onlyProfileId], for handing one person's history to their own
  /// phone. That never carries the groups she's in here: they're this
  /// phone's arrangement, not part of her history.
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
    final groups = <BackupGroup>[];
    if (onlyProfileId == null) {
      final place = {for (final (i, p) in profiles.indexed) p.id!: i};
      for (final g in await GroupRepository(db: _db).all()) {
        groups.add(
          BackupGroup(
            name: g.name,
            members: [for (final id in g.memberIds) place[id]!],
          ),
        );
      }
    }
    return Backup(exportedOn: today(), people: people, groups: groups);
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
        // Ids travel with people, so a restored phone still recognises
        // them when they're sent again. The owner is never a shared copy.
        final row = Profile(
          id: profileId,
          name: names[i],
          uid: person.profile.uid,
          sharedOn: i == 0 ? null : person.profile.sharedOn,
        ).toRow();
        if (profileId == EbbDatabase.primaryProfileId) {
          await txn.update(
            'profiles',
            row,
            where: 'id = ?',
            whereArgs: [profileId],
          );
        } else {
          await txn.insert('profiles', row);
        }
        await _insertHistory(txn, profileId, person);
      }
      for (final g in backup.groups) {
        final groupId = await txn.insert('person_groups', {'name': g.name});
        for (final m in g.members) {
          await txn.insert('group_members', {
            'group_id': groupId,
            'profile_id': EbbDatabase.primaryProfileId + m,
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
  ///
  /// With [sharedOn], she's added as a read-only copy of her history from her
  /// own phone, as it was that day. She keeps the id she came with, so she's
  /// recognised when she sends it again — unless someone here already has
  /// it, when she gets a new one rather than two people sharing it.
  Future<int> addPerson(
    BackupPerson person, {
    required String name,
    DateTime? sharedOn,
  }) async {
    final db = await _db.database;
    return db.transaction((txn) async {
      var uid = person.profile.uid;
      if (uid != null) {
        final taken = await txn.query(
          'profiles',
          where: 'uid = ?',
          whereArgs: [uid],
        );
        if (taken.isNotEmpty) uid = null;
      }
      final profileId = await txn.insert(
        'profiles',
        Profile(name: name, uid: uid, sharedOn: sharedOn).toRow(),
      );
      await _insertHistory(txn, profileId, person);
      return profileId;
    });
  }

  /// The person here with [uid], if any: the one someone arriving with that
  /// id would be.
  Future<Profile?> personWithUid(String? uid) async {
    if (uid == null) return null;
    final db = await _db.database;
    final rows = await db.query('profiles', where: 'uid = ?', whereArgs: [uid]);
    return rows.isEmpty ? null : Profile.fromRow(rows.single);
  }

  /// Replaces the history of the person with [profileId] with [person]'s,
  /// keeping her name, groups and settings here. A shared copy is marked
  /// with the new day she sent it. All or nothing, like [restore].
  Future<void> updatePerson(
    int profileId,
    BackupPerson person, {
    required DateTime sentOn,
  }) async {
    final db = await _db.database;
    await db.transaction((txn) async {
      await txn.delete(
        'day_logs',
        where: 'profile_id = ?',
        whereArgs: [profileId],
      );
      await txn.delete(
        'cycles',
        where: 'profile_id = ?',
        whereArgs: [profileId],
      );
      await _insertHistory(txn, profileId, person);
      await txn.rawUpdate(
        'UPDATE profiles SET shared_on = ? '
        'WHERE id = ? AND shared_on IS NOT NULL',
        [isoDate(sentOn), profileId],
      );
    });
  }

  static Future<void> _insertHistory(
    Transaction txn,
    int profileId,
    BackupPerson person,
  ) async {
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

  /// True when nothing has been logged yet — a phone just set up. Receiving
  /// one person here makes them the phone's owner rather than a guest.
  Future<bool> isEmpty() async {
    final b = await snapshot();
    return b.people.length == 1 && b.cycleCount == 0 && b.dayCount == 0;
  }
}
