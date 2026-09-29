import 'package:ebb/data/database.dart';
import 'package:ebb/models/profile.dart';

/// The people tracked on this phone. There is always at least one.
class ProfileRepository {
  ProfileRepository({EbbDatabase? db}) : _db = db ?? EbbDatabase.instance;

  final EbbDatabase _db;

  Future<List<Profile>> all() async {
    final db = await _db.database;
    final rows = await db.query('profiles', orderBy: 'id ASC');
    return rows.map(Profile.fromRow).toList();
  }

  Future<Profile> primary() async {
    final db = await _db.database;
    final rows = await db.query(
      'profiles',
      where: 'id = ?',
      whereArgs: [EbbDatabase.primaryProfileId],
    );
    return Profile.fromRow(rows.single);
  }

  Future<int> add(Profile profile) async {
    final db = await _db.database;
    return db.insert('profiles', profile.toRow()..remove('id'));
  }

  Future<void> rename(int id, String? name) async {
    final db = await _db.database;
    await db.update(
      'profiles',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Removes the profile and, by cascade, every cycle and day log in it. The
  /// primary profile can't be removed; clear it with "Delete all data".
  Future<void> remove(int id) async {
    if (id == EbbDatabase.primaryProfileId) {
      throw ArgumentError('The primary profile cannot be removed.');
    }
    final db = await _db.database;
    await db.delete('profiles', where: 'id = ?', whereArgs: [id]);
  }
}
