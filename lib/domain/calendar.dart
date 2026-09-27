import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/models/cycle.dart';

/// What the calendar shows on one day.
///
/// Worked out here, away from any widget, so the line between what was
/// logged and what is only estimated can be tested. The calendar must never
/// make an estimate look like a record.
enum DayMark {
  none,

  /// A logged period day: start to end, or start to today while it's going.
  period,

  /// After a start whose end was never logged: the usual period length,
  /// drawn as an estimate so a forgotten "ended" tap doesn't paint weeks of
  /// period.
  periodUnrecorded,

  /// Where the next period is likely to start. Only the next one: an
  /// estimate built on an estimate isn't worth showing.
  likelyStart,

  /// The estimated fertile window, only when it has been turned on.
  fertile,
}

class CalendarDay {
  const CalendarDay(this.mark, {this.cycle, this.cycleDay});

  final DayMark mark;

  /// The logged cycle this day belongs to: the latest one starting on or
  /// before it. Null before the first period.
  final Cycle? cycle;

  /// 1-based day of [cycle], up to today. Null for days still to come.
  final int? cycleDay;
}

/// Marks for every day, from one person's cycles and the current estimate.
class CalendarMarks {
  CalendarMarks(
    List<Cycle> cycles,
    CyclePrediction prediction, {
    this.showFertile = false,
    DateTime? asOf,
  })  : _now = dateOnly(asOf ?? DateTime.now()),
        _cycles = [...cycles]..sort((a, b) => a.start.compareTo(b.start)),
        _prediction = prediction {
    final usual = prediction.periodLength ?? 5;
    for (var i = 0; i < _cycles.length; i++) {
      final c = _cycles[i];
      final next = i + 1 < _cycles.length ? _cycles[i + 1].start : null;
      final end = c.end;
      if (end != null) {
        _fill(c.start, end, DayMark.period);
      } else if (c.inProgressOn(_now)) {
        _fill(c.start, _now, DayMark.period);
      } else {
        // Only the start is known. Estimate the rest, stopping short of the
        // next period and of today.
        _periods[isoDate(c.start)] = DayMark.period;
        var last = addDays(c.start, usual - 1);
        if (next != null && !last.isBefore(next)) last = addDays(next, -1);
        if (last.isAfter(_now)) last = _now;
        _fill(addDays(c.start, 1), last, DayMark.periodUnrecorded);
      }
    }
  }

  final DateTime _now;
  final List<Cycle> _cycles;
  final CyclePrediction _prediction;

  /// Whether to mark the estimated fertile window. Off unless turned on.
  final bool showFertile;
  final _periods = <String, DayMark>{};

  void _fill(DateTime from, DateTime to, DayMark mark) {
    for (var d = from; !d.isAfter(to); d = addDays(d, 1)) {
      _periods[isoDate(d)] = mark;
    }
  }

  static bool _within(DateTime d, DateTime? from, DateTime? to) =>
      from != null && to != null && !d.isBefore(from) && !d.isAfter(to);

  /// Whether any day is drawn as an estimated period, so the key can leave
  /// that entry out when there's nothing to explain.
  bool get hasUnrecorded => _periods.containsValue(DayMark.periodUnrecorded);

  CalendarDay on(DateTime day) {
    final d = dateOnly(day);
    final p = _prediction;

    var mark = _periods[isoDate(d)] ?? DayMark.none;
    if (mark == DayMark.none) {
      if (_within(d, p.earliest, p.latest)) {
        mark = DayMark.likelyStart;
      } else if (showFertile && _within(d, p.fertileStart, p.fertileEnd)) {
        mark = DayMark.fertile;
      }
    }

    Cycle? cycle;
    for (final c in _cycles) {
      if (c.start.isAfter(d)) break;
      cycle = c;
    }
    final cycleDay = cycle == null || d.isAfter(_now)
        ? null
        : daysBetween(cycle.start, d) + 1;
    return CalendarDay(mark, cycle: cycle, cycleDay: cycleDay);
  }
}
