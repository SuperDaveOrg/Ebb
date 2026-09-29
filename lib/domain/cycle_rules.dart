import 'package:ebb/domain/dates.dart';
import 'package:ebb/models/cycle.dart';

/// Why a cycle can't be saved as entered.
///
/// Kept separate from wording so the rules stay testable without a widget
/// tree; the UI decides how to say each one.
enum CycleProblem {
  startInFuture,
  endInFuture,
  endBeforeStart,
  duplicateStart,

  /// Starts on or before the previous period's last day.
  overlapsPrevious,

  /// Ends on or after the next period's first day.
  overlapsNext,
}

/// Checks [candidate] against every other recorded cycle.
///
/// [existing] may include the candidate's own saved version (matched by id);
/// it is ignored so that editing a cycle doesn't collide with itself.
CycleProblem? checkCycle(
  Cycle candidate,
  List<Cycle> existing, {
  DateTime? asOf,
}) {
  final now = dateOnly(asOf ?? DateTime.now());
  final start = dateOnly(candidate.start);
  final end = candidate.end == null ? null : dateOnly(candidate.end!);

  if (start.isAfter(now)) return CycleProblem.startInFuture;
  if (end != null && end.isAfter(now)) return CycleProblem.endInFuture;
  if (end != null && end.isBefore(start)) return CycleProblem.endBeforeStart;

  final others =
      existing
          .where((c) => candidate.id == null || c.id != candidate.id)
          .toList()
        ..sort((a, b) => a.start.compareTo(b.start));

  Cycle? previous;
  Cycle? next;
  for (final c in others) {
    final gap = daysBetween(start, c.start);
    if (gap == 0) return CycleProblem.duplicateStart;
    if (gap < 0) previous = c;
    if (gap > 0) {
      next = c;
      break;
    }
  }

  final prevEnd = previous?.end;
  if (prevEnd != null && daysBetween(prevEnd, start) <= 0) {
    return CycleProblem.overlapsPrevious;
  }
  if (next != null && end != null && daysBetween(end, next.start) <= 0) {
    return CycleProblem.overlapsNext;
  }
  return null;
}

/// The logged period starting soon after [day] whose start could move back
/// to [day], or null.
///
/// Tapping a day just before a period usually means "it started a day
/// earlier than I logged", not "another period started here": a second
/// start that close would make a cycle only days long. So within
/// [Cycle.maxPeriodDays] before a logged start, moving that start is
/// offered instead of a new period, whenever [canMoveStartTo] allows it.
Cycle? periodStartingSoonAfter(DateTime day, List<Cycle> cycles) {
  final d = dateOnly(day);
  final next = ([...cycles]..sort((a, b) => a.start.compareTo(b.start)))
      .where((c) => c.start.isAfter(d))
      .firstOrNull;
  if (next == null || daysBetween(d, next.start) > Cycle.maxPeriodDays) {
    return null;
  }
  return next;
}

/// Whether [cycle]'s start can move back to [day]: see
/// [periodStartingSoonAfter].
bool canMoveStartTo(
  Cycle cycle,
  DateTime day,
  List<Cycle> cycles, {
  DateTime? asOf,
}) {
  final moved = cycle.copyWith(start: dateOnly(day));
  final end = moved.end;
  if (end != null && daysBetween(moved.start, end) >= Cycle.maxPeriodDays) {
    return false;
  }
  return checkCycle(moved, cycles, asOf: asOf) == null;
}
