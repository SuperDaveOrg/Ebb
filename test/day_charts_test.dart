import 'package:ebb/domain/calendar.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/day_charts.dart';
import 'package:ebb/domain/moon.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/models/day_log.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final asOf = DateTime(2026, 5, 10);

  // Three 28-day cycles, then one begun on April 26.
  final cycles = [
    Cycle(id: 1, start: DateTime(2026, 2, 1), end: DateTime(2026, 2, 5)),
    Cycle(id: 2, start: DateTime(2026, 3, 1), end: DateTime(2026, 3, 5)),
    Cycle(id: 3, start: DateTime(2026, 3, 29), end: DateTime(2026, 4, 2)),
    Cycle(id: 4, start: DateTime(2026, 4, 26), end: DateTime(2026, 4, 30)),
  ];
  final marks = CalendarMarks(
    cycles,
    const Predictor().predict(cycles, asOf: asOf),
    asOf: asOf,
  );

  DayLog rated(int month, int day, int r) =>
      DayLog(date: DateTime(2026, month, day), rating: r);
  DayLog felt(int month, int day, Feeling f) =>
      DayLog(date: DateTime(2026, month, day), feeling: DayFeeling.named(f));

  test('ratingTimeline has every day, shading logged period days', () {
    final days = ratingTimeline(
      marks,
      [rated(3, 2, 2)],
      from: DateTime(2026, 2, 27),
      to: DateTime(2026, 3, 6),
    );
    expect(days, hasLength(8));
    expect(days.map((d) => d.period), [
      false, false, true, true, true, true, true, false, //
    ]);
    expect(days.map((d) => d.rating).nonNulls, [2]);
  });

  group('feelingsAroundPeriods', () {
    final logs = [
      felt(3, 2, Feeling.tired), // during cycle 2's period
      felt(3, 24, Feeling.sad), // 5 days before cycle 3
      felt(3, 23, Feeling.sad), // 6 days before: other
      felt(3, 28, Feeling.sad), // the day before cycle 3
      felt(3, 27, Feeling.irritable), // 2 days before
      felt(5, 5, Feeling.calm), // current cycle: can't tell yet
    ];
    final groups = feelingsAroundPeriods(cycles, logs, marks);

    test('sorts each day by where it falls', () {
      expect(groups.map((g) => g.title), [
        'During a period',
        'Just before a period',
        'Other days',
      ]);
      expect(groups.map((g) => g.detail), [
        'logged period days',
        'the 5 days before',
        'the rest of the cycle',
      ]);
      expect(
        feelingsAroundPeriods(
          cycles,
          logs,
          marks,
          usualPeriodLength: 5,
        ).first.detail,
        'usually 5 days',
      );
      expect(groups[0].counts, [(DayFeeling.named(Feeling.tired), 1)]);
      expect(groups[1].counts, [
        (DayFeeling.named(Feeling.sad), 2),
        (DayFeeling.named(Feeling.irritable), 1),
      ]);
      expect(groups[2].counts, [(DayFeeling.named(Feeling.sad), 1)]);
    });

    test('leaves out days since the latest period started', () {
      expect(groups.fold(0, (n, g) => n + g.days), 5);
    });
  });

  group('by moon', () {
    // Taken from the phase calculation, so the local day is right in any
    // time zone.
    final phases = moonPhasesBetween(
      DateTime.utc(2026, 9, 1),
      DateTime.utc(2026, 10, 1),
    );
    final newMoon = phases.firstWhere((e) => e.phase == MoonPhase.newMoon).day;
    final fullMoon = phases.firstWhere((e) => e.phase == MoonPhase.full).day;
    DayLog on(DateTime d, {int? rating, Feeling? feeling}) => DayLog(
      date: d,
      rating: rating,
      feeling: feeling == null ? null : DayFeeling.named(feeling),
    );

    test('feelingsAroundMoon groups the day of a phase and a day either '
        'side', () {
      final groups = feelingsAroundMoon([
        on(fullMoon, feeling: Feeling.energetic),
        on(addDays(fullMoon, 1), feeling: Feeling.energetic),
        on(addDays(fullMoon, 3), feeling: Feeling.calm),
        on(addDays(newMoon, -1), feeling: Feeling.tired),
      ]);
      expect(groups.map((g) => (g.title, g.days)), [
        ('Around a full moon', 2),
        ('Around a new moon', 1),
        ('Other days', 1),
      ]);
      expect(groups[0].counts, [(DayFeeling.named(Feeling.energetic), 2)]);
      expect(groups[0].detail, 'the day, ±1 day');
    });
  });
}
