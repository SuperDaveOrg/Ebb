import 'package:ebb/domain/calendar.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/moon.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';

/// What the Charts screen shows, worked out away from any widget.
///
/// These describe what she logged and nothing more. No trend lines, no
/// predictions, no sentences drawing conclusions: whether a pattern means
/// anything is hers to judge, and some of what a chart could "find" would
/// shade into medical claims.

/// One day on the timeline.
class TimelineDay {
  const TimelineDay(this.date, {this.rating, this.period = false});

  final DateTime date;
  final int? rating;

  /// A logged period day. Estimated ones aren't shaded: the timeline shows
  /// records only.
  final bool period;
}

/// Every day from [from] to [to], with its rating and whether it was a
/// logged period day.
List<TimelineDay> ratingTimeline(
  CalendarMarks marks,
  List<DayLog> logs, {
  required DateTime from,
  required DateTime to,
}) {
  final ratings = {
    for (final l in logs)
      if (l.rating != null) isoDate(l.date): l.rating!,
  };
  return [
    for (var d = dateOnly(from); !d.isAfter(to); d = addDays(d, 1))
      TimelineDay(
        d,
        rating: ratings[isoDate(d)],
        period: marks.on(d).mark == DayMark.period,
      ),
  ];
}

/// One group of days, and how often each feeling was picked on them.
class FeelingGroup {
  const FeelingGroup(this.title, this.detail, this.days, this.counts);

  final String title;

  /// Which days the group covers, briefly: "the 5 days before".
  final String detail;

  /// Days in the group with a feeling picked.
  final int days;

  /// Most-picked first.
  final List<(DayFeeling, int)> counts;
}

/// Counts, never averages: feelings aren't a scale. [groupOf] names the
/// group a day belongs to, or returns null to leave it out; groups come
/// back in [titles] order.
List<FeelingGroup> _groupFeelings(
  List<DayLog> logs,
  List<(String, String)> groups,
  String? Function(DateTime day) groupOf,
) {
  final titles = [for (final (t, _) in groups) t];
  final tallies = {for (final t in titles) t: <DayFeeling, int>{}};
  final days = {for (final t in titles) t: 0};
  for (final l in logs) {
    final feeling = l.feeling;
    if (feeling == null) continue;
    final group = groupOf(dateOnly(l.date));
    if (group == null) continue;
    tallies[group]![feeling] = (tallies[group]![feeling] ?? 0) + 1;
    days[group] = days[group]! + 1;
  }
  return [
    for (final (t, detail) in groups)
      FeelingGroup(
        t,
        detail,
        days[t]!,
        tallies[t]!.entries.map((e) => (e.key, e.value)).toList()
          ..sort((a, b) => b.$2.compareTo(a.$2)),
      ),
  ];
}

/// Feelings picked during periods, in the [before] days before one, and on
/// other days. [usualPeriodLength], when known, is given as a sense of how
/// many days "during" covers.
///
/// A day after the latest period started isn't counted: until the next one
/// starts, there's no telling whether it was one of the days before it.
/// Nor is a day only estimated to be part of a period.
List<FeelingGroup> feelingsAroundPeriods(
  List<Cycle> cycles,
  List<DayLog> logs,
  CalendarMarks marks, {
  int before = 5,
  int? usualPeriodLength,
}) {
  const period = 'During a period', other = 'Other days';
  const beforeTitle = 'Just before a period';
  final starts = cycles.map((c) => c.start).toList()..sort();
  final groups = [
    (
      period,
      usualPeriodLength == null
          ? 'logged period days'
          : 'usually $usualPeriodLength days',
    ),
    (beforeTitle, 'the $before days before'),
    (other, 'the rest of the cycle'),
  ];
  return _groupFeelings(logs, groups, (d) {
    final mark = marks.on(d).mark;
    if (mark == DayMark.period) return period;
    if (mark == DayMark.periodUnrecorded) return null;
    final next = starts.where((s) => s.isAfter(d)).firstOrNull;
    if (next == null) return null;
    return daysBetween(d, next) <= before ? beforeTitle : other;
  });
}

/// Feelings picked around full moons, around new moons, and on other days.
/// "Around" is the day of the phase and [around] days either side.
List<FeelingGroup> feelingsAroundMoon(List<DayLog> logs, {int around = 1}) {
  const full = 'Around a full moon', fresh = 'Around a new moon';
  const other = 'Other days';
  final span = around == 0
      ? 'the day itself'
      : 'the day, ±$around day${around == 1 ? '' : 's'}';
  final groups = [
    (full, span),
    (fresh, span),
    (other, 'the rest of the month'),
  ];
  final felt = [
    for (final l in logs)
      if (l.feeling != null) dateOnly(l.date),
  ]..sort();
  if (felt.isEmpty) {
    return _groupFeelings(const [], groups, (_) => null);
  }

  final phases = moonPhasesBetween(
    addDays(felt.first, -around - 1).toUtc(),
    addDays(felt.last, around + 2).toUtc(),
  );
  final near = <String, String>{};
  for (final e in phases) {
    final title = switch (e.phase) {
      MoonPhase.full => full,
      MoonPhase.newMoon => fresh,
      _ => null,
    };
    if (title == null) continue;
    for (var i = -around; i <= around; i++) {
      near[isoDate(addDays(e.day, i))] = title;
    }
  }
  return _groupFeelings(logs, groups, (d) => near[isoDate(d)] ?? other);
}
