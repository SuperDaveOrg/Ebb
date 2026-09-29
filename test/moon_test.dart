import 'package:flutter_test/flutter_test.dart';

import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/moon.dart';

/// The [phase] nearest [expected], which must be within two minutes of it.
void expectPhase(MoonPhase phase, DateTime expected) {
  final found = moonPhasesBetween(
    expected.subtract(const Duration(days: 2)),
    expected.add(const Duration(days: 2)),
  ).where((e) => e.phase == phase).toList();
  expect(found, hasLength(1), reason: '$phase near $expected');
  final off = found.single.at.difference(expected).inSeconds.abs();
  expect(
    off,
    lessThan(120),
    reason: '$phase expected $expected, got ${found.single.at}',
  );
}

void main() {
  group('moonPhasesBetween', () {
    test("matches Meeus' worked examples", () {
      // Example 49.a: 1977 Feb 18, 3:37:42 TD, less ΔT of about 48 s.
      expectPhase(MoonPhase.newMoon, DateTime.utc(1977, 2, 18, 3, 36, 54));
      // Example 49.b: 2044 Jan 21, 23:48:17 TD.
      expectPhase(MoonPhase.lastQuarter, DateTime.utc(2044, 1, 21, 23, 47, 0));
    });

    test('matches the new and full moons of recent eclipses', () {
      expectPhase(MoonPhase.newMoon, DateTime.utc(2017, 8, 21, 18, 30));
      expectPhase(MoonPhase.newMoon, DateTime.utc(2024, 4, 8, 18, 21));
      expectPhase(MoonPhase.full, DateTime.utc(2024, 9, 18, 2, 34));
      expectPhase(MoonPhase.full, DateTime.utc(2025, 3, 14, 6, 55));
    });

    test('comes in order, a quarter of a lunation apart', () {
      final events = moonPhasesBetween(DateTime.utc(2020), DateTime.utc(2030));
      // About 12.37 lunations a year, four phases each.
      expect(events.length, inInclusiveRange(490, 496));
      for (var i = 1; i < events.length; i++) {
        final prev = events[i - 1], e = events[i];
        expect(e.phase.index, (prev.phase.index + 1) % 4);
        final gap = e.at.difference(prev.at).inHours / 24;
        expect(gap, inInclusiveRange(5.9, 8.6), reason: '${prev.at} → ${e.at}');
      }
    });

    test('includes a phase at the start of the range and not at its end', () {
      final full = moonPhasesBetween(
        DateTime.utc(2024, 9, 17),
        DateTime.utc(2024, 9, 19),
      ).single;
      expect(
        moonPhasesBetween(full.at, full.at.add(const Duration(days: 1))),
        hasLength(1),
      );
      expect(
        moonPhasesBetween(full.at.subtract(const Duration(days: 1)), full.at),
        isEmpty,
      );
    });
  });

  group('moonPhasesByDay', () {
    test('puts each phase on the local day it happens', () {
      final byDay = moonPhasesByDay(
        DateTime(2024, 9, 1),
        DateTime(2024, 9, 30),
      );
      final full = DateTime.utc(2024, 9, 18, 2, 34).toLocal();
      expect(byDay[isoDate(full)]?.phase, MoonPhase.full);
      expect(byDay.length, inInclusiveRange(3, 5));
    });

    test('covers the last day of the range', () {
      final full = moonPhasesBetween(
        DateTime.utc(2025, 3, 13),
        DateTime.utc(2025, 3, 15),
      ).single;
      final day = full.day;
      final byDay = moonPhasesByDay(day, day);
      expect(byDay.keys, [isoDate(day)]);
      expect(byDay.values.single.phase, MoonPhase.full);
    });
  });
}
