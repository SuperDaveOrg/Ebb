import 'dart:convert';

import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/temperature.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';
import 'package:ebb/models/person_group.dart';
import 'package:ebb/models/profile.dart';
import 'package:ebb/ui/wording.dart';

/// The backup file format. See docs/backup-format.md, which is the contract;
/// this file is one implementation of it.
///
/// Plain, documented JSON on purpose: a backup should be readable in a text
/// editor and importable by some other app one day, so nobody is locked in.
///
/// Version 2 added a day's `rating` and `feeling`, and groups of people. It's
/// a new version, not just new fields, so an older Ebb refuses the file
/// instead of quietly dropping them.
///
/// Version 3 added a day's temperature and cervical mucus, for the same
/// reason.
const backupFormatVersion = 3;

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

/// How much of one person's history to send.
enum SendSpan {
  everything(null),
  year(365),
  months6(182),
  months3(91),
  latest(null);

  const SendSpan(this.days);
  final int? days;
}

extension TrimForSending on BackupPerson {
  /// This person with only the history chosen to send: periods from [span]
  /// and, unless [periodsOnly], the day entries from the same stretch.
  /// Periods only also leaves out the notes on periods: what's left says
  /// when, and nothing else.
  ///
  /// For sending one person to another phone. Nothing here is removed from
  /// this phone.
  BackupPerson trimmed({
    required SendSpan span,
    required bool periodsOnly,
    DateTime? asOf,
  }) {
    final sorted = [...cycles]..sort((a, b) => a.start.compareTo(b.start));
    final DateTime? from = switch (span) {
      SendSpan.everything => null,
      SendSpan.latest => sorted.isEmpty ? null : sorted.last.start,
      _ => addDays(dateOnly(asOf ?? DateTime.now()), -(span.days! - 1)),
    };
    bool kept(DateTime d) => from == null || !dateOnly(d).isBefore(from);
    return BackupPerson(
      profile: profile,
      cycles: [
        for (final c in sorted)
          if (kept(c.start)) periodsOnly ? c.copyWith(clearNotes: true) : c,
      ],
      days: periodsOnly
          ? const []
          : [
              for (final d in days)
                if (kept(d.date)) d,
            ],
    );
  }
}

/// A group within a backup, naming its members by their place in
/// [Backup.people].
class BackupGroup {
  const BackupGroup({required this.name, this.members = const []});

  final String name;
  final List<int> members;
}

class Backup {
  const Backup({
    required this.exportedOn,
    required this.people,
    this.groups = const [],
  });

  final DateTime exportedOn;

  /// In profile order; the first person becomes the primary profile on
  /// restore.
  final List<BackupPerson> people;

  /// Only in a backup of the whole phone: sending one person never carries
  /// the groups she's in on this phone.
  final List<BackupGroup> groups;

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
          if (person.profile.uid != null) 'id': person.profile.uid,
          if (person.profile.sharedOn != null)
            'sharedOn': isoDate(person.profile.sharedOn!),
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
                if (d.temperature != null) 'temperature': d.temperature,
                if (d.temperature != null && d.temperatureDisturbed)
                  'temperatureDisturbed': true,
                if (d.mucusFeel != null) 'mucusFeel': d.mucusFeel!.name,
                if (d.mucusLook != null) 'mucusLook': d.mucusLook!.name,
              },
          ],
        },
    ],
    if (backup.groups.isNotEmpty)
      'groups': [
        for (final g in backup.groups) {'name': g.name, 'members': g.members},
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
    throw BackupFormatException(strings.backupNotEbb);
  }
  if (root is! Map<String, Object?> || !root.containsKey('ebbBackup')) {
    throw BackupFormatException(strings.backupNotEbb);
  }

  final version = root['ebbBackup'];
  if (version is! int || version < 1) {
    throw BackupFormatException(strings.backupNotEbb);
  }
  if (version > backupFormatVersion) {
    throw BackupFormatException(strings.backupNewer);
  }

  final exportedOn = _date(root['exportedOn'], strings.backupDamagedExportDate);
  final entries = _list(root, 'people', strings.backupDamaged);
  if (entries.isEmpty) {
    throw BackupFormatException(strings.backupNoOne);
  }

  final people = [for (final p in entries) _person(p, exportedOn)];
  final uids = <String>{};
  for (final p in people) {
    final uid = p.profile.uid;
    if (uid != null && !uids.add(uid)) {
      throw BackupFormatException(strings.backupSameId);
    }
    final shared = p.profile.sharedOn;
    if (shared != null && shared.isAfter(exportedOn)) {
      throw BackupFormatException(strings.backupAfterExport(isoDate(shared)));
    }
  }
  final names = <String>{};
  for (final name in people.map((p) => p.profile.name).nonNulls) {
    if (!names.add(name.toLowerCase())) {
      throw BackupFormatException(strings.backupSameName(name));
    }
  }
  final groups = [
    for (final g in _list(
      root,
      'groups',
      strings.backupDamaged,
      required: false,
    ))
      _group(g, people.length),
  ];
  final groupNames = <String>{};
  for (final g in groups) {
    if (!groupNames.add(g.name.toLowerCase())) {
      throw BackupFormatException(strings.backupSameGroupName(g.name));
    }
  }
  return Backup(exportedOn: exportedOn, people: people, groups: groups);
}

BackupGroup _group(Object? raw, int peopleCount) {
  if (raw is! Map<String, Object?>) throw _damaged(strings.backupDamagedGroup);
  final name = raw['name'];
  if (name is! String ||
      name.trim().isEmpty ||
      name.trim() != name ||
      name.length > PersonGroup.maxNameLength) {
    throw _damaged(strings.backupDamagedGroupName);
  }
  final members = <int>[];
  for (final m in _list(raw, 'members', strings.backupDamagedGroup)) {
    if (m is! int || m < 0 || m >= peopleCount || members.contains(m)) {
      throw _damaged(strings.backupDamagedGroupPeople(name));
    }
    members.add(m);
  }
  return BackupGroup(name: name, members: members);
}

BackupPerson _person(Object? raw, DateTime exportedOn) {
  if (raw is! Map<String, Object?>) throw _damaged(strings.backupDamagedPerson);
  final name = raw['name'];
  if (name != null &&
      (name is! String ||
          name.trim().isEmpty ||
          name.trim() != name ||
          name.length > Profile.maxNameLength)) {
    throw _damaged(strings.backupDamagedName);
  }
  final uid = _optional<String>(raw, 'id', strings.backupDamagedPerson);
  if (uid != null && !Profile.uidPattern.hasMatch(uid)) {
    throw _damaged(strings.backupDamagedPersonId);
  }
  final sharedOn = raw['sharedOn'] == null
      ? null
      : _date(raw['sharedOn'], strings.backupDamagedSharedOn);

  // Nothing can have happened after the backup was made. Ebb never records a
  // future day, so a file that does was written by something else.
  void notAfterExport(DateTime d) {
    if (d.isAfter(exportedOn)) {
      throw BackupFormatException(strings.backupAfterExport(isoDate(d)));
    }
  }

  final cycles = <Cycle>[];
  final starts = <String>{};
  for (final c in _list(raw, 'cycles', strings.backupDamagedPerson)) {
    if (c is! Map<String, Object?>) throw _damaged(strings.backupDamagedPeriod);
    final start = _date(c['start'], strings.backupDamagedPeriodStart);
    final end = c['end'] == null
        ? null
        : _date(c['end'], strings.backupDamagedPeriodEnd);
    if (end != null && end.isBefore(start)) {
      throw BackupFormatException(strings.backupEndsBefore(isoDate(start)));
    }
    notAfterExport(end ?? start);
    if (!starts.add(isoDate(start))) {
      throw BackupFormatException(strings.backupTwoStarts(isoDate(start)));
    }
    cycles.add(
      Cycle(
        start: start,
        end: end,
        excluded:
            _optional<bool>(c, 'excluded', strings.backupDamagedPeriod) ??
            false,
        notes: _optional<String>(c, 'notes', strings.backupDamagedPeriod),
      ),
    );
  }

  final days = <DayLog>[];
  final dates = <String>{};
  final dayDamaged = strings.backupDamagedDay;
  for (final d in _list(
    raw,
    'days',
    strings.backupDamagedPerson,
    required: false,
  )) {
    if (d is! Map<String, Object?>) throw _damaged(dayDamaged);
    final date = _date(d['date'], dayDamaged);
    notAfterExport(date);
    if (!dates.add(isoDate(date))) {
      throw BackupFormatException(strings.backupDayTwice(isoDate(date)));
    }
    final flowName = _optional<String>(d, 'flow', dayDamaged);
    final flow = flowName == null
        ? Flow.none
        : Flow.values.where((f) => f.name == flowName).firstOrNull;
    if (flow == null) throw _damaged(strings.backupDamagedFlow(isoDate(date)));

    final symptoms = <String>[];
    for (final s in _list(d, 'symptoms', dayDamaged, required: false)) {
      // Tabs separate symptoms in storage, so one can't appear inside one.
      if (s is! String || s.trim().isEmpty || s.contains('\t')) {
        throw _damaged(strings.backupDamagedSymptom(isoDate(date)));
      }
      symptoms.add(s);
    }

    final rating = _optional<int>(d, 'rating', dayDamaged);
    if (rating != null && !DayLog.isRating(rating)) {
      throw _damaged(strings.backupDamagedRating(isoDate(date)));
    }
    final feelingName = _optional<String>(d, 'feeling', dayDamaged);
    final feeling = DayFeeling.parse(feelingName);
    if (feelingName != null && feeling == null) {
      throw _damaged(strings.backupDamagedFeeling(isoDate(date)));
    }

    final rawTemperature = _optional<num>(d, 'temperature', dayDamaged);
    final temperature = rawTemperature == null
        ? null
        : roundTemperature(rawTemperature.toDouble());
    if (rawTemperature != null && !isTemperature(temperature)) {
      throw _damaged(strings.backupDamagedTemperature(isoDate(date)));
    }
    final disturbed =
        _optional<bool>(d, 'temperatureDisturbed', dayDamaged) ?? false;
    if (disturbed && temperature == null) {
      throw _damaged(strings.backupDamagedTemperature(isoDate(date)));
    }
    final feelName = _optional<String>(d, 'mucusFeel', dayDamaged);
    final mucusFeel = MucusFeel.fromName(feelName);
    if (feelName != null && mucusFeel == null) {
      throw _damaged(strings.backupDamagedMucus(isoDate(date)));
    }
    final lookName = _optional<String>(d, 'mucusLook', dayDamaged);
    final mucusLook = MucusLook.fromName(lookName);
    if (lookName != null && mucusLook == null) {
      throw _damaged(strings.backupDamagedMucus(isoDate(date)));
    }

    days.add(
      DayLog(
        date: date,
        flow: flow,
        symptoms: symptoms,
        notes: _optional<String>(d, 'notes', dayDamaged),
        rating: rating,
        feeling: feeling,
        temperature: temperature,
        temperatureDisturbed: disturbed,
        mucusFeel: mucusFeel,
        mucusLook: mucusLook,
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
        strings.backupOverlaps(isoDate(cycles[i].start)),
      );
    }
  }
  days.sort((a, b) => a.date.compareTo(b.date));
  return BackupPerson(
    profile: Profile(name: name as String?, uid: uid, sharedOn: sharedOn),
    cycles: cycles,
    days: days,
  );
}

/// [message] says which part couldn't be read, as a whole sentence.
BackupFormatException _damaged(String message) =>
    BackupFormatException(message);

List<Object?> _list(
  Map<String, Object?> map,
  String key,
  String damaged, {
  bool required = true,
}) {
  final value = map[key];
  if (value == null && !required) return const [];
  if (value is! List) throw _damaged(damaged);
  return value;
}

T? _optional<T>(Map<String, Object?> map, String key, String damaged) {
  final value = map[key];
  if (value == null) return null;
  if (value is T) return value as T;
  throw _damaged(damaged);
}

final _isoPattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

/// Strict `YYYY-MM-DD`. Rejects impossible dates like 2026-02-30 rather than
/// letting DateTime roll them over into March.
DateTime _date(Object? raw, String damaged) {
  if (raw is String && _isoPattern.hasMatch(raw)) {
    final d = parseIsoDate(raw);
    if (isoDate(d) == raw) return d;
  }
  throw _damaged(damaged);
}
