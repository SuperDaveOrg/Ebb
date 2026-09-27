import 'dart:math' as math;

import 'package:ebb/domain/dates.dart';
import 'package:ebb/models/cycle.dart';

/// How much the prediction should be trusted.
///
/// This is surfaced directly in the UI. A tracker that states a date with no
/// caveat when it has two data points is lying by omission, and cycles are
/// genuinely variable — illness, stress, travel, perimenopause. Ebb would
/// rather show a range and say how sure it is.
enum PredictionConfidence {
  /// Nothing logged yet.
  none,

  /// Fewer than three observed cycles, or falling back on a population average.
  low,

  /// Three to five observed cycles.
  moderate,

  /// Six or more observed cycles that agree closely with each other.
  good,
}

class CyclePrediction {
  const CyclePrediction({
    required this.observedCycles,
    required this.confidence,
    this.lastStart,
    this.unloggedCycles = 0,
    this.nextStart,
    this.earliest,
    this.latest,
    this.cycleLength,
    this.periodLength,
    this.variability,
    this.dayOfCycle,
    this.daysUntilNext,
    this.ovulation,
    this.fertileStart,
    this.fertileEnd,
  });

  /// A prediction with nothing behind it.
  static const empty = CyclePrediction(
    observedCycles: 0,
    confidence: PredictionConfidence.none,
  );

  /// Number of complete cycle-to-cycle intervals the estimate is built on.
  final int observedCycles;
  final PredictionConfidence confidence;

  /// Start of the most recent period she logged.
  final DateTime? lastStart;

  /// How many periods since [lastStart] the estimate assumes went unlogged.
  ///
  /// Zero normally. Once so long has passed that a *second* period would be
  /// due, the old date is no use to anyone, so the estimate moves on a cycle
  /// at a time and this says by how many. The UI must say so too: an
  /// estimate built on an assumption has to own up to it.
  final int unloggedCycles;

  /// Most likely first day of the next period.
  final DateTime? nextStart;

  /// Bounds of the likely window, roughly one standard deviation either side.
  final DateTime? earliest;
  final DateTime? latest;

  final int? cycleLength;
  final int? periodLength;

  /// Spread of observed cycle lengths, in days.
  final double? variability;

  /// 1-based day of the current cycle as of the prediction date.
  final int? dayOfCycle;
  final int? daysUntilNext;

  final DateTime? ovulation;
  final DateTime? fertileStart;
  final DateTime? fertileEnd;

  bool get hasPrediction => nextStart != null;

  /// True when cycles vary enough that a single date would be misleading.
  bool get isIrregular => (variability ?? 0) > 4;

  /// Width of the likely window in days.
  int? get windowWidth {
    final a = earliest, b = latest;
    if (a == null || b == null) return null;
    return daysBetween(a, b);
  }

  /// Whether a gap of [days] between two logged starts is long enough that a
  /// period in between probably wasn't logged. False without an estimate.
  bool spansUnloggedPeriod(int days) {
    final length = cycleLength, width = windowWidth;
    if (length == null || width == null) return false;
    return days >= Predictor.unloggedGap(length, width ~/ 2);
  }
}

/// Estimates the next period from recorded cycle history.
///
/// The model is deliberately simple arithmetic rather than anything learned:
/// it must be explainable to the person relying on it, and with a handful of
/// data points per year there is nothing for a larger model to find.
class Predictor {
  const Predictor({
    this.priorCycleLength = 28,
    this.priorPeriodLength = 5,
    this.priorVariability = 4.0,
    this.historyWindow = 6,
    this.shrinkageWeight = 2,
  });

  /// Population average, used to anchor estimates when history is thin.
  final int priorCycleLength;
  final int priorPeriodLength;
  final double priorVariability;

  /// How many recent cycles to consider. Older cycles are ignored so the
  /// estimate tracks the body's current rhythm rather than last year's.
  final int historyWindow;

  /// Strength of the pull toward [priorCycleLength], in pseudo-observations.
  final int shrinkageWeight;

  /// Lowest plausible cycle-to-cycle interval, in days. Anything shorter is
  /// treated as a mis-entry rather than a cycle.
  static const int minPlausibleCycle = 15;
  static const int maxPlausibleCycle = 90;

  /// Days from one logged start by which a second period would be due: two
  /// cycles, less the uncertainty [band]. Up to then, no new start is read as
  /// a late period; from then on, as one that wasn't logged.
  static int unloggedGap(int cycleLength, int band) => 2 * cycleLength - band;

  CyclePrediction predict(List<Cycle> cycles, {DateTime? asOf}) {
    if (cycles.isEmpty) return CyclePrediction.empty;

    final now = dateOnly(asOf ?? DateTime.now());
    final sorted = [...cycles]..sort((a, b) => a.start.compareTo(b.start));
    final lastStart = sorted.last.start;

    final intervals = _intervals(sorted);
    final recent = intervals.length > historyWindow
        ? intervals.sublist(intervals.length - historyWindow)
        : intervals;

    final cycleLength = _estimateCycleLength(recent);
    final variability = _estimateVariability(recent);
    final periodLength = _estimatePeriodLength(sorted);

    final band = variability.round().clamp(1, 14);

    // Late, the estimate stays put and says how late. Once a second period
    // would be due, assume the first went unlogged, then move on a cycle
    // each time a likely window passes with nothing logged.
    var nextStart = addDays(lastStart, cycleLength);
    var unlogged = 0;
    if (daysBetween(lastStart, now) >= unloggedGap(cycleLength, band)) {
      do {
        nextStart = addDays(nextStart, cycleLength);
        unlogged++;
      } while (daysBetween(nextStart, now) > band);
    }
    final ovulation = addDays(nextStart, -14);

    return CyclePrediction(
      observedCycles: recent.length,
      confidence: _confidence(recent.length, variability),
      lastStart: lastStart,
      unloggedCycles: unlogged,
      nextStart: nextStart,
      earliest: addDays(nextStart, -band),
      latest: addDays(nextStart, band),
      cycleLength: cycleLength,
      periodLength: periodLength,
      variability: variability,
      dayOfCycle: now.isBefore(lastStart) ? null : daysBetween(lastStart, now) + 1,
      daysUntilNext: daysBetween(now, nextStart),
      ovulation: ovulation,
      fertileStart: addDays(ovulation, -5),
      fertileEnd: addDays(ovulation, 1),
    );
  }

  /// Cycle-to-cycle intervals, with implausible values discarded.
  ///
  /// A cycle she has excluded drops out, but its start still bounds the cycle
  /// before it — skipping it must not stitch two neighbours into one long gap.
  List<int> _intervals(List<Cycle> sorted) {
    final out = <int>[];
    for (var i = 1; i < sorted.length; i++) {
      if (sorted[i - 1].excluded) continue;
      final gap = daysBetween(sorted[i - 1].start, sorted[i].start);
      if (gap >= minPlausibleCycle && gap <= maxPlausibleCycle) out.add(gap);
    }
    return out;
  }

  /// Median of observations, pulled toward the population prior in proportion
  /// to how little history there is. With one cycle logged the estimate sits
  /// close to 28 days; by six it is almost entirely her own data.
  int _estimateCycleLength(List<int> intervals) {
    if (intervals.isEmpty) return priorCycleLength;
    final n = intervals.length;
    final m = _median(intervals);
    return ((n * m + shrinkageWeight * priorCycleLength) / (n + shrinkageWeight))
        .round();
  }

  double _estimateVariability(List<int> intervals) {
    if (intervals.length < 3) return priorVariability;
    final mean = intervals.reduce((a, b) => a + b) / intervals.length;
    final variance = intervals
            .map((v) => math.pow(v - mean, 2).toDouble())
            .reduce((a, b) => a + b) /
        (intervals.length - 1);
    return math.max(math.sqrt(variance), 1.0);
  }

  int _estimatePeriodLength(List<Cycle> sorted) {
    final lengths = sorted
        .where((c) => !c.excluded)
        .map((c) => c.periodLength)
        .whereType<int>()
        .where((l) => l >= 1 && l <= Cycle.maxPeriodDays)
        .toList();
    if (lengths.isEmpty) return priorPeriodLength;
    return _median(lengths).round();
  }

  PredictionConfidence _confidence(int n, double variability) {
    if (n >= historyWindow && variability <= 4) return PredictionConfidence.good;
    if (n >= 3) return PredictionConfidence.moderate;
    return PredictionConfidence.low;
  }

  double _median(List<int> values) {
    final s = [...values]..sort();
    final mid = s.length ~/ 2;
    if (s.length.isOdd) return s[mid].toDouble();
    return (s[mid - 1] + s[mid]) / 2.0;
  }
}
