import 'package:ebb/data/database.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';
import 'package:sqflite/sqflite.dart';

/// Reads and writes one person's cycles and day logs.
///
/// Every query is scoped to [profileId], so nothing above this layer needs to
/// know that a phone can hold more than one person's history.
class CycleRepository {
  CycleRepository({
    EbbDatabase? db,
    this.profileId = EbbDatabase.primaryProfileId,
  }) : _db = db ?? EbbDatabase.instance;

  final EbbDatabase _db;
  final int profileId;

  static const _mine = 'profile_id = ?';

  Map<String, Object?> _owned(Map<String, Object?> row) => {
    ...row,
    'profile_id': profileId,
  };

  Future<List<Cycle>> allCycles() async {
    final db = await _db.database;
    final rows = await db.query(
      'cycles',
      where: _mine,
      whereArgs: [profileId],
      orderBy: 'start_date ASC',
    );
    return rows.map(Cycle.fromRow).toList();
  }

  Future<Cycle?> latestCycle() async {
    final db = await _db.database;
    final rows = await db.query(
      'cycles',
      where: _mine,
      whereArgs: [profileId],
      orderBy: 'start_date DESC',
      limit: 1,
    );
    return rows.isEmpty ? null : Cycle.fromRow(rows.first);
  }

  /// Records a period beginning on [start].
  ///
  /// Re-entering a start date that already exists returns that row untouched
  /// rather than creating a duplicate, so tapping "period started" twice is
  /// harmless. (A REPLACE here would delete the row and lose its end date.)
  Future<int> startPeriod(DateTime start) async {
    final db = await _db.database;
    final id = await db.insert(
      'cycles',
      _owned(Cycle(start: dateOnly(start)).toRow()),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    if (id > 0) return id; // an ignored insert reports 0 or -1
    final rows = await db.query(
      'cycles',
      columns: ['id'],
      where: '$_mine AND start_date = ?',
      whereArgs: [profileId, isoDate(dateOnly(start))],
    );
    return rows.first['id'] as int;
  }

  /// Inserts a complete cycle, typically one logged after the fact. Callers
  /// should check it with `checkCycle` first; a duplicate start will throw.
  Future<int> addCycle(Cycle cycle) async {
    final db = await _db.database;
    return db.insert('cycles', _owned(cycle.toRow()..remove('id')));
  }

  Future<void> endPeriod(int cycleId, DateTime end) async {
    final db = await _db.database;
    await db.update(
      'cycles',
      {'end_date': isoDate(dateOnly(end))},
      where: 'id = ? AND $_mine',
      whereArgs: [cycleId, profileId],
    );
  }

  Future<void> updateCycle(Cycle cycle) async {
    final db = await _db.database;
    await db.update(
      'cycles',
      _owned(cycle.toRow()),
      where: 'id = ? AND $_mine',
      whereArgs: [cycle.id, profileId],
    );
  }

  Future<void> deleteCycle(int id) async {
    final db = await _db.database;
    await db.delete(
      'cycles',
      where: 'id = ? AND $_mine',
      whereArgs: [id, profileId],
    );
  }

  Future<DayLog?> logFor(DateTime date) async {
    final db = await _db.database;
    final rows = await db.query(
      'day_logs',
      where: '$_mine AND log_date = ?',
      whereArgs: [profileId, isoDate(dateOnly(date))],
      limit: 1,
    );
    return rows.isEmpty ? null : DayLog.fromRow(rows.first);
  }

  Future<List<DayLog>> logsBetween(DateTime from, DateTime to) async {
    final db = await _db.database;
    final rows = await db.query(
      'day_logs',
      where: '$_mine AND log_date BETWEEN ? AND ?',
      whereArgs: [profileId, isoDate(dateOnly(from)), isoDate(dateOnly(to))],
      orderBy: 'log_date ASC',
    );
    return rows.map(DayLog.fromRow).toList();
  }

  Future<List<DayLog>> allLogs() async {
    final db = await _db.database;
    final rows = await db.query(
      'day_logs',
      where: _mine,
      whereArgs: [profileId],
      orderBy: 'log_date ASC',
    );
    return rows.map(DayLog.fromRow).toList();
  }

  /// Saves a day's entry, removing the row entirely if it has been cleared.
  Future<void> saveLog(DayLog log) async {
    final db = await _db.database;
    final key = isoDate(dateOnly(log.date));
    if (log.isEmpty) {
      await db.delete(
        'day_logs',
        where: '$_mine AND log_date = ?',
        whereArgs: [profileId, key],
      );
      return;
    }
    await db.insert(
      'day_logs',
      _owned(log.toRow()),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
