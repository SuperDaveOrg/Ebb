import 'package:ebb/domain/calendar.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/models/cycle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final asOf = DateTime(2026, 5, 10);

  // Four 28-day cycles, the last still without an end.
  final cycles = [
    Cycle(id: 1, start: DateTime(2026, 2, 1), end: DateTime(2026, 2, 5)),
    Cycle(id: 2, start: DateTime(2026, 3, 1), end: DateTime(2026, 3, 5)),
    Cycle(id: 3, start: DateTime(2026, 3, 29), end: DateTime(2026, 4, 2)),
    Cycle(id: 4, start: DateTime(2026, 4, 26)),
  ];
  final prediction = const Predictor().predict(cycles, asOf: asOf);

  CalendarMarks marks({List<Cycle>? of, bool fertile = false}) =>
      CalendarMarks(of ?? cycles, prediction, showFertile: fertile, asOf: asOf);

  DayMark mark(DateTime d, {bool fertile = false}) =>
      marks(fertile: fertile).on(d).mark;

  test('logged period days are marked from start to end', () {
    expect(mark(DateTime(2026, 3, 1)), DayMark.period);
    expect(mark(DateTime(2026, 3, 5)), DayMark.period);
    expect(mark(DateTime(2026, 3, 6)), DayMark.none);
    expect(mark(DateTime(2026, 2, 28)), DayMark.none);
  });

  test('a period with no end logged is only estimated after its first day',
      () {
    expect(mark(DateTime(2026, 4, 26)), DayMark.period);
    expect(mark(DateTime(2026, 4, 27)), DayMark.periodUnrecorded);
    expect(mark(DateTime(2026, 4, 30)), DayMark.periodUnrecorded);
    // The usual five days, not the fortnight since.
    expect(mark(DateTime(2026, 5, 1)), DayMark.none);
    expect(marks().hasUnrecorded, isTrue);
  });

  test('an estimated tail stops before the next period', () {
    final tight = [
      Cycle(id: 1, start: DateTime(2026, 4, 1)),
      Cycle(id: 2, start: DateTime(2026, 4, 3), end: DateTime(2026, 4, 5)),
    ];
    final m = marks(of: tight);
    expect(m.on(DateTime(2026, 4, 2)).mark, DayMark.periodUnrecorded);
    expect(m.on(DateTime(2026, 4, 3)).mark, DayMark.period);
    expect(m.on(DateTime(2026, 4, 3)).cycle?.id, 2);
  });

  test('a period still going is logged up to today and no further', () {
    final going = [...cycles, Cycle(id: 5, start: DateTime(2026, 5, 8))];
    final m = marks(of: going);
    expect(m.on(DateTime(2026, 5, 10)).mark, DayMark.period);
    expect(m.on(DateTime(2026, 5, 11)).mark, DayMark.none);
  });

  test('only the next likely window is shown', () {
    expect(mark(prediction.nextStart!), DayMark.likelyStart);
    expect(mark(prediction.earliest!), DayMark.likelyStart);
    expect(mark(prediction.latest!), DayMark.likelyStart);
    final after = DateTime(prediction.nextStart!.year,
        prediction.nextStart!.month, prediction.nextStart!.day + 28);
    expect(mark(after), DayMark.none);
  });

  test('the fertile window appears only when turned on', () {
    final day = prediction.fertileStart!;
    expect(mark(day), DayMark.none);
    expect(mark(day, fertile: true), DayMark.fertile);
  });

  test('days count within their cycle, up to today', () {
    final m = marks();
    expect(m.on(DateTime(2026, 3, 10)).cycleDay, 10);
    expect(m.on(DateTime(2026, 3, 10)).cycle?.id, 2);
    expect(m.on(DateTime(2026, 5, 10)).cycleDay, 15);
    expect(m.on(DateTime(2026, 5, 11)).cycleDay, isNull);
    expect(m.on(DateTime(2026, 1, 15)).cycle, isNull);
  });
}
