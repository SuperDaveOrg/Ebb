import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/milestones.dart';
import 'package:ebb/models/cycle.dart';
import 'package:flutter_test/flutter_test.dart';

/// Periods starting [first] and every [gap] days after, [count] in all.
List<Cycle> periods(DateTime first, int count, {int gap = 28}) => [
  for (var i = 0; i < count; i++) Cycle(start: addDays(first, i * gap)),
];

void main() {
  final jan1 = DateTime(2026, 1, 1);

  List<Milestone> names(List<ReachedMilestone> r) =>
      [for (final m in r) m.milestone];

  test('nothing logged reaches nothing', () {
    expect(milestonesReached([]), isEmpty);
  });

  test('the first period is reached on its start', () {
    final r = milestonesReached(periods(jan1, 1));
    expect(names(r), [Milestone.firstPeriod]);
    expect(r.single.on, jan1);
  });

  test('cycles are counted start to start', () {
    expect(names(milestonesReached(periods(jan1, 2))), [
      Milestone.firstPeriod,
      Milestone.firstCycle,
    ]);
    expect(
      names(milestonesReached(periods(jan1, 3))),
      isNot(contains(Milestone.threeCycles)),
    );
    final four = milestonesReached(periods(jan1, 4));
    expect(names(four).last, Milestone.threeCycles);
    expect(four.last.on, addDays(jan1, 3 * 28));
    expect(
      names(milestonesReached(periods(jan1, 7))),
      contains(Milestone.sixCycles),
    );
  });

  test('the order periods are given in does not matter', () {
    final r = milestonesReached(periods(jan1, 2).reversed.toList());
    expect(r.last.on, addDays(jan1, 28));
  });

  test('a year is reached by the first period on or after the anniversary', () {
    final r = milestonesReached(periods(jan1, 15));
    final year = r.firstWhere((m) => m.milestone == Milestone.oneYear);
    // 13 × 28 = 364 days falls short; the 14th gap lands on day 392.
    expect(year.on, addDays(jan1, 14 * 28));
    expect(names(r), isNot(contains(Milestone.twoYears)));
  });

  test('one entry long ago never claims a year', () {
    final r = milestonesReached(periods(DateTime(2020, 3, 1), 1));
    expect(names(r), [Milestone.firstPeriod]);
  });

  test('a backup is placed among the rest by its date', () {
    final r = milestonesReached(
      periods(jan1, 2),
      firstBackup: DateTime(2026, 1, 10, 18, 30),
    );
    expect(names(r), [
      Milestone.firstPeriod,
      Milestone.firstBackup,
      Milestone.firstCycle,
    ]);
    expect(r[1].on, DateTime(2026, 1, 10));
  });
}
