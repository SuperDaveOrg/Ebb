import 'dart:convert';

import 'package:ebb/domain/dates.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';
import 'package:ebb/models/profile.dart';

/// The backup file format. See docs/backup-format.md, which is the contract;
/// this file is one implementation of it.
///
/// Plain, documented JSON on purpose: a backup should be readable in a text
/// editor and importable by some other app one day, so nobody is locked in.
///
/// Version 2 added a day's `rating` and `feeling`. It's a new version, not
/// just new fields, so an older Ebb refuses the file instead of quietly
/// dropping them.
const backupFormatVersion = 2;

/// One person's history within a backup.
class BackupPerson {
  const BackupPerson({
    required this.profile,
    this.cycles = const [],
    this.days = const [],
  });

  final Profile profile;
  final List<Cycle> cycles;
  final List<DayLog> days;
}

class Backup {
  const Backup({required this.exportedOn, required this.people});

  final DateTime exportedOn;

  /// In profile order; the first person becomes the primary profile on
  /// restore.
  final List<BackupPerson> people;

  int get cycleCount => people.fold(0, (n, p) => n + p.cycles.length);
  int get dayCount => people.fold(0, (n, p) => n + p.days.length);
}

/// A file that can't be restored, with a reason fit to show her.
class BackupFormatException implements Exception {
  const BackupFormatException(this.message);

  final String message;

  @override
  String toString() => 'BackupFormatException: $message';
}

/// [pretty] is for files people might open in an editor; QR transfers use
/// the compact form, where every byte costs screen space.
String encodeBackup(Backup backup, {bool pretty = true}) {
  final json = {
    'ebbBackup': backupFormatVersion,
    'exportedOn': isoDate(backup.exportedOn),
    'people': [
      for (final person in backup.people)
        {
          'name': person.profile.name,
          'cycles': [
            for (final c in person.cycles)
              {
                'start': isoDate(c.start),
                if (c.end != null) 'end': isoDate(c.end!),
                if (c.excluded) 'excluded': true,
                if (c.notes != null) 'notes': c.notes,
              },
          ],
          'days': [
            for (final d in person.days)
              {
                'date': isoDate(d.date),
                if (d.flow != Flow.none) 'flow': d.flow.name,
                if (d.symptoms.isNotEmpty) 'symptoms': d.symptoms,
                if (d.notes != null) 'notes': d.notes,
                if (d.rating != null) 'rating': d.rating,
                if (d.feeling != null) 'feeling': d.feeling!.value,
              },
          ],
        },
    ],
  };
  if (!pretty) return jsonEncode(json);
  return '${const JsonEncoder.withIndent('  ').convert(json)}\n';
}

/// Parses and fully validates a backup. Throws [BackupFormatException] rather
/// than returning anything partial: a restore replaces everything, so it must
/// never start on a file it can't finish.
Backup decodeBackup(String text) {
  final Object? root;
  try {
    root = jsonDecode(text);
  } on FormatException {
    throw const BackupFormatException("This file isn't an Ebb backup.");
  }
  if (root is! Map<String, Object?> || !root.containsKey('ebbBackup')) {
    throw const BackupFormatException("This file isn't an Ebb backup.");
  }

  final version = root['ebbBackup'];
  if (version is! int || version < 1) {
    throw const BackupFormatException("This file isn't an Ebb backup.");
  }
  if (version > backupFormatVersion) {
    throw const BackupFormatException(
      'This backup was made by a newer version of Ebb. Update Ebb, then try '
      'again.',
    );
  }

  final exportedOn = _date(root['exportedOn'], 'the export date');
  final entries = _list(root, 'people', 'the backup');
  if (entries.isEmpty) {
    throw const BackupFormatException('This backup has no one in it.');
  }

  final people = [for (final p in entries) _person(p, exportedOn)];
  final names = <String>{};
  for (final name in people.map((p) => p.profile.name).nonNulls) {
    if (!names.add(name.toLowerCase())) {
      throw BackupFormatException(
        'Two people in this backup are both called $name.',
      );
    }
  }
  return Backup(exportedOn: exportedOn, people: people);
}

BackupPerson _person(Object? raw, DateTime exportedOn) {
  if (raw is! Map<String, Object?>) throw _damaged('a person entry');
  final name = raw['name'];
  if (name != null &&
      (name is! String ||
          name.trim().isEmpty ||
          name.trim() != name ||
          name.length > Profile.maxNameLength)) {
    throw _damaged('a name');
  }

  // Nothing can have happened after the backup was made. Ebb never records a
  // future day, so a file that does was written by something else.
  void notAfterExport(DateTime d) {
    if (d.isAfter(exportedOn)) {
      throw BackupFormatException(
        '${isoDate(d)} is after the day this backup was made.',
      );
    }
  }

  final cycles = <Cycle>[];
  final starts = <String>{};
  for (final c in _list(raw, 'cycles', 'a person entry')) {
    if (c is! Map<String, Object?>) throw _damaged('a period entry');
    final start = _date(c['start'], 'a period start');
    final end = c['end'] == null ? null : _date(c['end'], 'a period end');
    if (end != null && end.isBefore(start)) {
      throw BackupFormatException(
        'The period starting ${isoDate(start)} ends before it begins.',
      );
    }
    notAfterExport(end ?? start);
    if (!starts.add(isoDate(start))) {
      throw BackupFormatException(
        'Two periods start on ${isoDate(start)} for the same person.',
      );
    }
    cycles.add(
      Cycle(
        start: start,
        end: end,
        excluded: _optional<bool>(c, 'excluded', 'a period entry') ?? false,
        notes: _optional<String>(c, 'notes', 'a period entry'),
      ),
    );
  }

  final days = <DayLog>[];
  final dates = <String>{};
  for (final d in _list(raw, 'days', 'a person entry', required: false)) {
    if (d is! Map<String, Object?>) throw _damaged('a day entry');
    final date = _date(d['date'], 'a day entry');
    notAfterExport(date);
    if (!dates.add(isoDate(date))) {
      throw BackupFormatException(
        '${isoDate(date)} appears twice for the same person.',
      );
    }
    final flowName = _optional<String>(d, 'flow', 'a day entry');
    final flow = flowName == null
        ? Flow.none
        : Flow.values.where((f) => f.name == flowName).firstOrNull;
    if (flow == null) throw _damaged('the flow on ${isoDate(date)}');

    final symptoms = <String>[];
    for (final s in _list(d, 'symptoms', 'a day entry', required: false)) {
      // Tabs separate symptoms in storage, so one can't appear inside one.
      if (s is! String || s.trim().isEmpty || s.contains('\t')) {
        throw _damaged('a symptom on ${isoDate(date)}');
      }
      symptoms.add(s);
    }

    final rating = _optional<int>(d, 'rating', 'a day entry');
    if (rating != null && !DayLog.isRating(rating)) {
      throw _damaged('the rating on ${isoDate(date)}');
    }
    final feelingName = _optional<String>(d, 'feeling', 'a day entry');
    final feeling = DayFeeling.parse(feelingName);
    if (feelingName != null && feeling == null) {
      throw _damaged('the feeling on ${isoDate(date)}');
    }

    days.add(
      DayLog(
        date: date,
        flow: flow,
        symptoms: symptoms,
        notes: _optional<String>(d, 'notes', 'a day entry'),
        rating: rating,
        feeling: feeling,
      ),
    );
  }

  cycles.sort((a, b) => a.start.compareTo(b.start));
  // The same rule the editor applies: a period can't begin before the one
  // before it has ended.
  for (var i = 1; i < cycles.length; i++) {
    final prevEnd = cycles[i - 1].end;
    if (prevEnd != null && !prevEnd.isBefore(cycles[i].start)) {
      throw BackupFormatException(
        'The period starting ${isoDate(cycles[i].start)} overlaps the one '
        'before it.',
      );
    }
  }
  days.sort((a, b) => a.date.compareTo(b.date));
  return BackupPerson(
    profile: Profile(name: name as String?),
    cycles: cycles,
    days: days,
  );
}

BackupFormatException _damaged(String what) => BackupFormatException(
  'This backup looks damaged: $what could not be read.',
);

List<Object?> _list(
  Map<String, Object?> map,
  String key,
  String where, {
  bool required = true,
}) {
  final value = map[key];
  if (value == null && !required) return const [];
  if (value is! List) throw _damaged(where);
  return value;
}

T? _optional<T>(Map<String, Object?> map, String key, String where) {
  final value = map[key];
  if (value == null) return null;
  if (value is T) return value as T;
  throw _damaged(where);
}

final _isoPattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

/// Strict `YYYY-MM-DD`. Rejects impossible dates like 2026-02-30 rather than
/// letting DateTime roll them over into March.
DateTime _date(Object? raw, String what) {
  if (raw is String && _isoPattern.hasMatch(raw)) {
    final d = parseIsoDate(raw);
    if (isoDate(d) == raw) return d;
  }
  throw _damaged(what);
}
