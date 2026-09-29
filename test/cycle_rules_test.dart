import 'package:ebb/domain/cycle_rules.dart';
import 'package:ebb/models/cycle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final asOf = DateTime(2026, 6, 1);

  // Two recorded periods: Mar 1–5 and Mar 29–Apr 2.
  final march = Cycle(
    id: 1,
    start: DateTime(2026, 3, 1),
    end: DateTime(2026, 3, 5),
  );
  final april = Cycle(
    id: 2,
    start: DateTime(2026, 3, 29),
    end: DateTime(2026, 4, 2),
  );
  final existing = [april, march]; // deliberately out of order

  CycleProblem? check(Cycle c) => checkCycle(c, existing, asOf: asOf);

  test('a clean new period is accepted', () {
    expect(check(Cycle(start: DateTime(2026, 4, 26))), isNull);
  });

  test('a period filled in between two others is accepted', () {
    final c = Cycle(start: DateTime(2026, 2, 1), end: DateTime(2026, 2, 5));
    expect(check(c), isNull);
  });

  test('dates in the future are rejected', () {
    expect(
      check(Cycle(start: DateTime(2026, 6, 2))),
      CycleProblem.startInFuture,
    );
    expect(
      check(Cycle(start: DateTime(2026, 5, 30), end: DateTime(2026, 6, 2))),
      CycleProblem.endInFuture,
    );
  });

  test('today is not the future', () {
    expect(check(Cycle(start: asOf)), isNull);
  });

  test('an end before the start is rejected', () {
    final c = Cycle(start: DateTime(2026, 5, 10), end: DateTime(2026, 5, 9));
    expect(check(c), CycleProblem.endBeforeStart);
  });

  test('a one-day period is fine', () {
    final d = DateTime(2026, 5, 10);
    expect(check(Cycle(start: d, end: d)), isNull);
  });

  test('a second period on the same start day is rejected', () {
    expect(
      check(Cycle(start: DateTime(2026, 3, 1))),
      CycleProblem.duplicateStart,
    );
  });

  test('starting inside the previous period is rejected', () {
    expect(
      check(Cycle(start: DateTime(2026, 3, 5))),
      CycleProblem.overlapsPrevious,
    );
    expect(check(Cycle(start: DateTime(2026, 3, 6))), isNull);
  });

  test('running into the next period is rejected', () {
    final c = Cycle(start: DateTime(2026, 3, 20), end: DateTime(2026, 3, 29));
    expect(check(c), CycleProblem.overlapsNext);
  });

  test('an older period with no end recorded does not block the next', () {
    final c = Cycle(start: DateTime(2026, 2, 1));
    expect(check(c), isNull);
  });

  group('editing an existing cycle', () {
    test('does not collide with its own saved version', () {
      expect(check(march.copyWith(excluded: true)), isNull);
    });

    test('can move its end within bounds', () {
      expect(check(march.copyWith(end: DateTime(2026, 3, 7))), isNull);
    });

    test('still cannot overlap its neighbour', () {
      expect(
        check(march.copyWith(end: DateTime(2026, 3, 30))),
        CycleProblem.overlapsNext,
      );
    });
  });

  group('the days just before a period', () {
    test('find the period starting soon after', () {
      // The day before April's period.
      expect(periodStartingSoonAfter(DateTime(2026, 3, 28), existing), april);
      // A fortnight before: the longest a period can run.
      expect(periodStartingSoonAfter(DateTime(2026, 3, 15), existing), april);
      // Further back is an ordinary day.
      expect(periodStartingSoonAfter(DateTime(2026, 3, 14), existing), isNull);
      // After the last period there is nothing soon after.
      expect(periodStartingSoonAfter(DateTime(2026, 5, 1), existing), isNull);
    });

    test('can take the start moved back to them', () {
      expect(
        canMoveStartTo(april, DateTime(2026, 3, 28), existing, asOf: asOf),
        isTrue,
      );
    });

    test('but not onto the previous period, nor into one too long', () {
      // March's period ends on the 5th.
      expect(
        canMoveStartTo(april, DateTime(2026, 3, 5), existing, asOf: asOf),
        isFalse,
      );
      // Mar 18 to Apr 2 would be a 16-day period.
      expect(
        canMoveStartTo(april, DateTime(2026, 3, 18), existing, asOf: asOf),
        isFalse,
      );
    });
  });
}
