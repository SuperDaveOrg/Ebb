/// Writes an entirely fictional history as an Ebb backup file, for testing
/// restore and QR transfer without real data ever appearing on a screen.
///
///     dart run tool/sample_history.dart [--gaps] [out.json] [YYYY-MM-DD]
///
/// Deterministic: the same seed and end date always produce the same file,
/// so screen captures made from it stay reproducible. The end date defaults
/// to the one the test fixture was made with; pass a recent one to get
/// screenshots where "today" falls mid-cycle.
///
/// --gaps leaves periods out of the owner's history, as if they were never
/// logged: one about a year back, and nothing for the last two months. With
/// today as the end date, that shows the estimate rolling forward and
/// History pointing out both gaps.
library;

import 'dart:io';
import 'dart:math';

import 'package:ebb/data/backup.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';
import 'package:ebb/models/profile.dart';

void main(List<String> args) {
  final gaps = args.contains('--gaps');
  final rest = args.where((a) => a != '--gaps').toList();
  final out = rest.isEmpty ? 'sample-backup.json' : rest.first;
  final until = rest.length > 1 ? parseIsoDate(rest[1]) : null;
  File(out)
      .writeAsStringSync(encodeBackup(sampleHistory(until: until, gaps: gaps)));
  stdout.writeln('Wrote $out');
}

/// Two people: the phone's owner with two years of fairly steady cycles and
/// daily notes, and a second person with eight months of irregular ones.
/// With [gaps], some of the owner's periods are left unlogged.
Backup sampleHistory({DateTime? until, bool gaps = false}) {
  final end = dateOnly(until ?? DateTime(2026, 9, 20));
  final random = Random(42);
  final owner = _person(
    const Profile(),
    random,
    until: end,
    months: 24,
    meanLength: 29,
    spread: 2,
    detailed: true,
  );
  return Backup(
    exportedOn: end,
    people: [
      gaps ? _unlogged(owner, until: end) : owner,
      _person(
        const Profile(name: 'Sam'),
        random,
        until: end,
        months: 8,
        meanLength: 32,
        spread: 6,
        detailed: false,
      ),
    ],
  );
}

const _symptoms = [
  'cramps',
  'headache',
  'tired',
  'bloating',
  'back ache',
  'tender breasts',
  'low mood',
  'cravings',
];

const _notes = [
  'Slept badly.',
  'Long run, felt fine.',
  'Took ibuprofen in the morning.',
  'Busy week at work.',
  'Better than last month.',
];

/// [person] as if one period about a year before [until] and everything in
/// the last two months had never been logged.
BackupPerson _unlogged(BackupPerson person, {required DateTime until}) {
  final cutoff = addDays(until, -60);
  final kept = person.cycles.where((c) => c.start.isBefore(cutoff)).toList();
  final yearAgo = addDays(until, -365);
  final missing = kept.firstWhere(
    (c) => !c.excluded && c.start.isAfter(yearAgo),
    orElse: () => kept[kept.length ~/ 2],
  );
  kept.remove(missing);

  // Each period's day notes go with it.
  bool logged(DateTime d) =>
      d.isBefore(cutoff) &&
      (d.isBefore(missing.start) || d.isAfter(missing.end ?? missing.start));
  return BackupPerson(
    profile: person.profile,
    cycles: kept,
    days: person.days.where((d) => logged(d.date)).toList(),
  );
}

BackupPerson _person(
  Profile profile,
  Random random, {
  required DateTime until,
  required int months,
  required int meanLength,
  required int spread,
  required bool detailed,
}) {
  final cycles = <Cycle>[];
  final days = <DayLog>[];
  // Generators of their own, so adding these didn't reshuffle the rest.
  final ratings = Random(7);
  final feelings = Random(11);
  var start = addDays(until, -months * 30);

  while (!start.isAfter(until)) {
    final periodDays = 4 + random.nextInt(3);
    final periodEnd = addDays(start, periodDays - 1);
    // One cycle a year thrown off by illness, marked as not counted.
    final ill = detailed && cycles.length % 12 == 7;

    cycles.add(
      Cycle(
        start: start,
        // Only a period still under way on the last day is left open.
        end: periodEnd.isAfter(until) ? null : periodEnd,
        excluded: ill,
        notes: ill ? 'Had flu, cycle ran long.' : null,
      ),
    );

    for (var d = 0; d < periodDays && detailed; d++) {
      final date = addDays(start, d);
      if (date.isAfter(until)) break;
      days.add(
        DayLog(
          date: date,
          flow: const [
            Flow.heavy,
            Flow.heavy,
            Flow.medium,
            Flow.light,
            Flow.light,
            Flow.spotting,
          ][d],
          symptoms: [
            for (final s in _symptoms)
              if (random.nextInt(5) == 0) s,
          ],
          notes: random.nextInt(4) == 0
              ? _notes[random.nextInt(_notes.length)]
              : null,
          // Most days rated, lower early on.
          rating: ratings.nextInt(4) == 0
              ? null
              : (d < 2 ? 1 : 2) + ratings.nextInt(3),
          feeling: _feeling(feelings),
        ),
      );
    }

    final length = ill
        ? meanLength + 16
        : meanLength + random.nextInt(spread * 2 + 1) - spread;
    start = addDays(start, length);
  }

  // Ordinary days too, the way someone checking in most evenings would:
  // a rating and a feeling on most days of the last fifteen months, so the
  // calendar and charts have something to show outside periods. A rating
  // drifts from the day before rather than jumping at random, as real ones
  // do.
  if (detailed) {
    final everyday = Random(13);
    final logged = {for (final d in days) isoDate(d.date)};
    // Never past today, even when [until] is: Ebb can't log a future day.
    final last = until.isAfter(today()) ? today() : until;
    var rating = 3;
    for (var d = addDays(last, -456); !d.isAfter(last); d = addDays(d, 1)) {
      rating = (rating + const [-1, 0, 0, 1][everyday.nextInt(4)]).clamp(1, 5);
      if (logged.contains(isoDate(d)) || everyday.nextInt(10) < 3) continue;
      days.add(
        DayLog(
          date: d,
          rating: rating,
          feeling: _feeling(everyday) ?? DayFeeling.named(Feeling.calm),
        ),
      );
    }
    days.sort((a, b) => a.date.compareTo(b.date));
  }

  return BackupPerson(profile: profile, cycles: cycles, days: days);
}

/// Mostly a named feeling, now and then one of the extra faces.
DayFeeling? _feeling(Random random) => switch (random.nextInt(6)) {
  0 || 1 => null,
  2 => DayFeeling.face(const ['😹', '👽', '🌧️', '🍫'][random.nextInt(4)]),
  _ => DayFeeling.named(Feeling.values[random.nextInt(Feeling.values.length)]),
};
