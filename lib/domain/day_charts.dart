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

/// One day on the temperature chart: the reading and cervical mucus as
/// logged, and whether it was a logged period day.
class TemperatureDay {
  const TemperatureDay(
    this.date, {
    this.temperature,
    this.disturbed = false,
    this.mucusFeel,
    this.mucusLook,
    this.period = false,
  });

  final DateTime date;
  final double? temperature;
  final bool disturbed;
  final MucusFeel? mucusFeel;
  final MucusLook? mucusLook;
  final bool period;
}

/// Every day from [from] to [to], with what was logged of temperature and
/// cervical mucus. Nothing is smoothed, filled in or marked as a shift: the
/// chart draws the readings and she reads them.
List<TemperatureDay> temperatureTimeline(
  CalendarMarks marks,
  List<DayLog> logs, {
  required DateTime from,
  required DateTime to,
}) {
  final byDay = {
    for (final l in logs)
      if (l.hasTemperatureOrMucus) isoDate(l.date): l,
  };
  return [
    for (var d = dateOnly(from); !d.isAfter(to); d = addDays(d, 1))
      if (byDay[isoDate(d)] case final l?)
        TemperatureDay(
          d,
          temperature: l.temperature,
          disturbed: l.temperatureDisturbed,
          mucusFeel: l.mucusFeel,
          mucusLook: l.mucusLook,
          period: marks.on(d).mark == DayMark.period,
        )
      else
        TemperatureDay(d, period: marks.on(d).mark == DayMark.period),
  ];
}

/// A run of period days within a range, for the group view's lanes.
class PeriodRun {
  const PeriodRun(this.start, this.end, {this.estimated = false});

  final DateTime start;
  final DateTime end;

  /// Drawn from the usual length because no end was logged, as the calendar
  /// shows it: an estimate, never passed off as a record.
  final bool estimated;
}

/// The runs of period days between [from] and [to], cut at the range's
/// edges. Logged and estimated days make separate runs.
List<PeriodRun> periodRuns(
  CalendarMarks marks, {
  required DateTime from,
  required DateTime to,
}) {
  final runs = <PeriodRun>[];
  DateTime? start;
  bool? estimated;
  DateTime? last;
  void close() {
    if (start != null) {
      runs.add(PeriodRun(start!, last!, estimated: estimated!));
    }
    start = null;
  }

  for (var d = dateOnly(from); !d.isAfter(to); d = addDays(d, 1)) {
    final mark = marks.on(d).mark;
    final isEstimate = mark == DayMark.periodUnrecorded;
    if (mark != DayMark.period && !isEstimate) {
      close();
      continue;
    }
    if (start != null && estimated != isEstimate) close();
    start ??= d;
    estimated = isEstimate;
    last = d;
  }
  close();
  return runs;
}

/// Which days a [FeelingGroup] covers. The screen puts them into words.
enum FeelingDays {
  duringPeriod,
  beforePeriod,
  restOfCycle,
  nearFullMoon,
  nearNewMoon,
  restOfMonth,
}

/// One group of days, and how often each feeling was picked on them.
class FeelingGroup {
  const FeelingGroup(this.kind, this.span, this.days, this.counts);

  final FeelingDays kind;

  /// How many days the group covers, where that's part of saying which:
  /// the usual period length (null when unknown), the days before a
  /// period, or the days either side of a moon phase. Null otherwise.
  final int? span;

  /// Days in the group with a feeling picked.
  final int days;

  /// Most-picked first.
  final List<(DayFeeling, int)> counts;
}

/// Counts, never averages: feelings aren't a scale. [groupOf] names the
/// group a day belongs to, or returns null to leave it out; groups come
/// back in [groups] order.
List<FeelingGroup> _groupFeelings(
  List<DayLog> logs,
  List<(FeelingDays, int?)> groups,
  FeelingDays? Function(DateTime day) groupOf,
) {
  final kinds = [for (final (k, _) in groups) k];
  final tallies = {for (final k in kinds) k: <DayFeeling, int>{}};
  final days = {for (final k in kinds) k: 0};
  for (final l in logs) {
    final feeling = l.feeling;
    if (feeling == null) continue;
    final group = groupOf(dateOnly(l.date));
    if (group == null) continue;
    tallies[group]![feeling] = (tallies[group]![feeling] ?? 0) + 1;
    days[group] = days[group]! + 1;
  }
  return [
    for (final (k, span) in groups)
      FeelingGroup(
        k,
        span,
        days[k]!,
        tallies[k]!.entries.map((e) => (e.key, e.value)).toList()
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
  const period = FeelingDays.duringPeriod, other = FeelingDays.restOfCycle;
  const beforeTitle = FeelingDays.beforePeriod;
  final starts = cycles.map((c) => c.start).toList()..sort();
  final groups = [
    (period, usualPeriodLength),
    (beforeTitle, before),
    (other, null),
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
  const full = FeelingDays.nearFullMoon, fresh = FeelingDays.nearNewMoon;
  const other = FeelingDays.restOfMonth;
  final groups = [
    (full, around),
    (fresh, around),
    (other, null),
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
  final near = <String, FeelingDays>{};
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
