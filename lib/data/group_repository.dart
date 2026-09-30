import 'package:sqflite/sqflite.dart';

import 'package:ebb/data/database.dart';
import 'package:ebb/models/person_group.dart';

/// The groups on this phone and who is in each. Phone-wide, like people:
/// not scoped to one profile.
class GroupRepository {
  GroupRepository({EbbDatabase? db}) : _db = db ?? EbbDatabase.instance;

  final EbbDatabase _db;

  /// Every group, by name, each with its members.
  Future<List<PersonGroup>> all() async {
    final db = await _db.database;
    final groups = await db.query('person_groups', orderBy: 'name ASC');
    final members = await db.query('group_members', orderBy: 'profile_id ASC');
    return [
      for (final g in groups)
        PersonGroup(
          id: g['id'] as int,
          name: g['name'] as String,
          memberIds: [
            for (final m in members)
              if (m['group_id'] == g['id']) m['profile_id'] as int,
          ],
        ),
    ];
  }

  Future<int> add(String name) async {
    final db = await _db.database;
    return db.insert('person_groups', {'name': name});
  }

  Future<void> rename(int id, String name) async {
    final db = await _db.database;
    await db.update(
      'person_groups',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Removes the group and its memberships. Its people stay on the phone.
  Future<void> delete(int id) async {
    final db = await _db.database;
    await db.delete('person_groups', where: 'id = ?', whereArgs: [id]);
  }

  /// Puts one more person in the group, if she isn't already.
  Future<void> addMember(int id, int profileId) async {
    final db = await _db.database;
    await db.insert('group_members', {
      'group_id': id,
      'profile_id': profileId,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  /// Makes exactly [profileIds] the group's members.
  Future<void> setMembers(int id, Iterable<int> profileIds) async {
    final db = await _db.database;
    await db.transaction((txn) async {
      await txn.delete('group_members', where: 'group_id = ?', whereArgs: [id]);
      for (final p in profileIds.toSet()) {
        await txn.insert('group_members', {'group_id': id, 'profile_id': p});
      }
    });
  }
}
