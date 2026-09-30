import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import 'package:ebb/models/profile.dart';

/// The on-device SQLite database.
///
/// This file is the whole of Ebb's storage. There is no server, no account,
/// and no sync — see docs/privacy.md for why that is a design commitment
/// rather than an unfinished feature.
class EbbDatabase {
  /// [path] and [factory] exist for tests, which run against an in-memory
  /// database on the host; the app always uses [instance].
  EbbDatabase({this._path, this._factory});

  static final EbbDatabase instance = EbbDatabase();

  static const _fileName = 'ebb.db';
  static const version = 7;

  /// The profile every install starts with. It always exists, which lets the
  /// UI stay single-person until it needs to be otherwise.
  static const primaryProfileId = 1;

  final String? _path;
  final DatabaseFactory? _factory;
  Database? _db;

  Future<Database> get database async => _db ??= await _open();

  Future<Database> _open() async {
    final factory = _factory ?? databaseFactory;
    final path = _path ?? p.join(await factory.getDatabasesPath(), _fileName);
    return factory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: version,
        onConfigure: (db) => db.execute('PRAGMA foreign_keys = ON'),
        onCreate: _create,
        onUpgrade: _upgrade,
      ),
    );
  }

  /// A fresh install builds the version-1 schema and then replays every
  /// migration, so new and upgraded phones cannot drift apart.
  Future<void> _create(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cycles (
        id         INTEGER PRIMARY KEY AUTOINCREMENT,
        start_date TEXT NOT NULL UNIQUE,
        end_date   TEXT,
        notes      TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE day_logs (
        id       INTEGER PRIMARY KEY AUTOINCREMENT,
        log_date TEXT NOT NULL UNIQUE,
        flow     TEXT NOT NULL DEFAULT 'none',
        symptoms TEXT NOT NULL DEFAULT '',
        notes    TEXT
      )
    ''');
    await db.execute('CREATE INDEX idx_cycles_start ON cycles(start_date)');
    await db.execute('CREATE INDEX idx_logs_date ON day_logs(log_date)');
    await _upgrade(db, 1, version);
  }

  /// Each step brings a database from the previous version to the next, so a
  /// phone that skipped several releases replays them in order.
  Future<void> _upgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE cycles ADD COLUMN excluded INTEGER NOT NULL DEFAULT 0',
      );
    }
    if (oldVersion < 3) await _addProfiles(db);
    // Version 4: how the day went, 1 to 5. Null when not rated.
    if (oldVersion < 4) {
      await db.execute('ALTER TABLE day_logs ADD COLUMN rating INTEGER');
    }
    // Version 5: how she felt, as a Feeling name. Null when not picked.
    if (oldVersion < 5) {
      await db.execute('ALTER TABLE day_logs ADD COLUMN feeling TEXT');
    }
    // Version 6: named groups of people, for the advanced groups option.
    if (oldVersion < 6) await _addGroups(db);
    if (oldVersion < 7) await _addPersonIds(db);
  }

  /// Version 3: every cycle and day log belongs to a profile, so one phone
  /// can hold more than one person's history — a parent helping children
  /// learn their cycles, say. Existing data moves to the primary profile.
  ///
  /// SQLite can't alter a UNIQUE constraint, and dates are now unique per
  /// person rather than per phone, so both tables are rebuilt.
  Future<void> _addProfiles(Database db) async {
    await db.execute('''
      CREATE TABLE profiles (
        id   INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');
    await db.insert('profiles', {'id': primaryProfileId, 'name': null});

    await db.execute('''
      CREATE TABLE cycles_v3 (
        id         INTEGER PRIMARY KEY AUTOINCREMENT,
        profile_id INTEGER NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
        start_date TEXT NOT NULL,
        end_date   TEXT,
        notes      TEXT,
        excluded   INTEGER NOT NULL DEFAULT 0,
        UNIQUE (profile_id, start_date)
      )
    ''');
    await db.execute('''
      INSERT INTO cycles_v3 (id, profile_id, start_date, end_date, notes, excluded)
      SELECT id, $primaryProfileId, start_date, end_date, notes, excluded FROM cycles
    ''');
    await db.execute('DROP TABLE cycles');
    await db.execute('ALTER TABLE cycles_v3 RENAME TO cycles');

    await db.execute('''
      CREATE TABLE day_logs_v3 (
        id         INTEGER PRIMARY KEY AUTOINCREMENT,
        profile_id INTEGER NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
        log_date   TEXT NOT NULL,
        flow       TEXT NOT NULL DEFAULT 'none',
        symptoms   TEXT NOT NULL DEFAULT '',
        notes      TEXT,
        UNIQUE (profile_id, log_date)
      )
    ''');
    await db.execute('''
      INSERT INTO day_logs_v3 (id, profile_id, log_date, flow, symptoms, notes)
      SELECT id, $primaryProfileId, log_date, flow, symptoms, notes FROM day_logs
    ''');
    await db.execute('DROP TABLE day_logs');
    await db.execute('ALTER TABLE day_logs_v3 RENAME TO day_logs');

    // The UNIQUE constraints above create the (profile, date) indexes the
    // queries need; the old single-column indexes went with their tables.
  }

  /// Version 6: groups, and who is in each. Membership goes with the person
  /// or the group, whichever is deleted first; people never go with a group.
  Future<void> _addGroups(Database db) async {
    await db.execute('''
      CREATE TABLE person_groups (
        id   INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE COLLATE NOCASE
      )
    ''');
    await db.execute('''
      CREATE TABLE group_members (
        group_id   INTEGER NOT NULL REFERENCES person_groups(id) ON DELETE CASCADE,
        profile_id INTEGER NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
        PRIMARY KEY (group_id, profile_id)
      )
    ''');
  }

  /// Version 7: a lasting id for each person, so the same person sent again
  /// is recognised; and, for read-only copies from someone else's phone, the
  /// day she sent it.
  Future<void> _addPersonIds(Database db) async {
    await db.execute('ALTER TABLE profiles ADD COLUMN uid TEXT');
    await db.execute('ALTER TABLE profiles ADD COLUMN shared_on TEXT');
    for (final row in await db.query('profiles', columns: ['id'])) {
      await db.update(
        'profiles',
        {'uid': Profile.newUid()},
        where: 'id = ?',
        whereArgs: [row['id']],
      );
    }
    await db.execute('CREATE UNIQUE INDEX idx_profiles_uid ON profiles(uid)');
  }

  /// Used by the "delete everything" action in Settings. Her data, her call.
  ///
  /// Profiles go too — a name is personal data — and the primary profile is
  /// recreated empty so the app has someone to show.
  Future<void> deleteAllData() async {
    final db = await database;
    await db.transaction(resetAll);
  }

  /// Empties every table and leaves only a blank primary profile. Shared with
  /// restore, which rebuilds from a backup inside the same transaction.
  static Future<void> resetAll(Transaction txn) async {
    await txn.delete('group_members');
    await txn.delete('person_groups');
    await txn.delete('day_logs');
    await txn.delete('cycles');
    await txn.delete('profiles');
    await txn.insert('profiles', const Profile(id: primaryProfileId).toRow());
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
