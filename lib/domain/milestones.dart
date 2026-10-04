import 'package:ebb/domain/dates.dart';
import 'package:ebb/models/cycle.dart';

/// Points worth marking in someone's history with Ebb.
///
/// Every one is about the record she has built, never about her body: there
/// is no milestone for a regular cycle, an on-time period or a streak. They
/// are worked out from the history each time, so nothing extra is stored or
/// backed up, and editing the history moves them with it.
///
/// Declared in the order they are usually reached.
enum Milestone {
  firstPeriod,

  /// A second start: the first full cycle, measured start to start.
  firstCycle,
  threeCycles,

  /// As many cycles as the predictor's history window looks at.
  sixCycles,
  oneYear,
  twoYears,
  fiveYears,

  /// The phone's first backup file. Phone-wide, so only the owner has it.
  firstBackup,
}

/// A [milestone] and the day it was reached.
class ReachedMilestone {
  const ReachedMilestone(this.milestone, this.on);

  final Milestone milestone;
  final DateTime on;
}

/// Full cycles needed for each count milestone. A cycle is start to start,
/// so n cycles take n + 1 logged periods.
const _cycleCounts = {
  Milestone.firstCycle: 1,
  Milestone.threeCycles: 3,
  Milestone.sixCycles: 6,
};

const _years = {
  Milestone.oneYear: 1,
  Milestone.twoYears: 2,
  Milestone.fiveYears: 5,
};

/// The milestones reached in [cycles], oldest first.
///
/// A year of history is reached by the first period logged on or after the
/// anniversary of the first one, so a history that stopped after one entry
/// never claims a year. Excluded cycles still count: they're still periods
/// she logged.
List<ReachedMilestone> milestonesReached(
  List<Cycle> cycles, {
  DateTime? firstBackup,
}) {
  final starts = [for (final c in cycles) dateOnly(c.start)]..sort();
  final reached = <ReachedMilestone>[
    if (starts.isNotEmpty) ReachedMilestone(Milestone.firstPeriod, starts[0]),
    for (final MapEntry(key: m, value: n) in _cycleCounts.entries)
      if (starts.length > n) ReachedMilestone(m, starts[n]),
  ];
  if (starts.isNotEmpty) {
    final first = starts.first;
    for (final MapEntry(key: m, value: n) in _years.entries) {
      final anniversary = dateOnly(
        DateTime(first.year + n, first.month, first.day),
      );
      final on = starts.where((s) => !s.isBefore(anniversary)).firstOrNull;
      if (on != null) reached.add(ReachedMilestone(m, on));
    }
  }
  if (firstBackup != null) {
    reached.add(ReachedMilestone(Milestone.firstBackup, dateOnly(firstBackup)));
  }
  return reached..sort((a, b) {
    final byDay = a.on.compareTo(b.on);
    return byDay != 0 ? byDay : a.milestone.index.compareTo(b.milestone.index);
  });
}
