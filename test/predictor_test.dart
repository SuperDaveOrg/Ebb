import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/predictor.dart';
import 'package:ebb/models/cycle.dart';
import 'package:flutter_test/flutter_test.dart';

/// Builds a cycle history from a start date and a list of gaps between
/// successive period starts.
List<Cycle> history(DateTime first, List<int> gaps, {int periodLength = 5}) {
  final cycles = <Cycle>[];
  var start = first;
  for (var i = 0; i <= gaps.length; i++) {
    cycles.add(Cycle(start: start, end: addDays(start, periodLength - 1)));
    if (i < gaps.length) start = addDays(start, gaps[i]);
  }
  return cycles;
}

void main() {
  const predictor = Predictor();
  final jan1 = DateTime(2026, 1, 1);

  group('cold start', () {
    test('no cycles yields no prediction', () {
      final p = predictor.predict([]);
      expect(p.hasPrediction, isFalse);
      expect(p.confidence, PredictionConfidence.none);
      expect(p.observedCycles, 0);
    });

    test('a single cycle falls back on the population average', () {
      final p = predictor.predict([Cycle(start: jan1)], asOf: jan1);
      expect(p.confidence, PredictionConfidence.low);
      expect(p.observedCycles, 0);
      expect(p.cycleLength, 28);
      expect(p.nextStart, DateTime(2026, 1, 29));
    });
  });

  group('shrinkage toward the prior', () {
    test('one observation is pulled most of the way back to 28', () {
      // A single 34-day cycle should not convince us her cycle is 34 days.
      final p = predictor.predict(history(jan1, [34]), asOf: jan1);
      expect(p.observedCycles, 1);
      expect(p.cycleLength, 30); // (1*34 + 2*28) / 3 = 30
    });

    test('six consistent observations nearly override the prior', () {
      final p = predictor.predict(history(jan1, [34, 34, 34, 34, 34, 34]));
      expect(p.observedCycles, 6);
      expect(p.cycleLength, 33); // (6*34 + 2*28) / 8 = 32.5 -> 33
    });

    test('estimate tracks her own rhythm, not the average', () {
      final short = predictor.predict(history(jan1, [24, 24, 24, 24, 24, 24]));
      expect(short.cycleLength, lessThan(28));
    });
  });

  group('confidence', () {
    test('three cycles is moderate', () {
      final p = predictor.predict(history(jan1, [28, 28, 28]));
      expect(p.confidence, PredictionConfidence.moderate);
    });

    test('six consistent cycles is good', () {
      final p = predictor.predict(history(jan1, [28, 29, 28, 27, 28, 28]));
      expect(p.confidence, PredictionConfidence.good);
    });

    test('six erratic cycles stays moderate and flags irregularity', () {
      final p = predictor.predict(history(jan1, [21, 40, 26, 45, 23, 38]));
      expect(p.confidence, PredictionConfidence.moderate);
      expect(p.isIrregular, isTrue);
    });
  });

  group('uncertainty window', () {
    test('steady cycles produce a narrow window', () {
      final p = predictor.predict(history(jan1, [28, 28, 28, 28, 28, 28]));
      expect(p.windowWidth, 2); // +/- 1 day
    });

    test('erratic cycles produce a wide window', () {
      final p = predictor.predict(history(jan1, [21, 40, 26, 45, 23, 38]));
      expect(p.windowWidth!, greaterThan(10));
    });

    test('window always brackets the predicted date', () {
      final p = predictor.predict(history(jan1, [26, 31, 28, 30, 27, 29]));
      expect(p.earliest!.isAfter(p.nextStart!), isFalse);
      expect(p.latest!.isBefore(p.nextStart!), isFalse);
    });
  });

  group('robustness', () {
    test('implausible gaps are discarded rather than skewing the estimate', () {
      // A duplicate entry three days later must not register as a 3-day cycle.
      final cycles = [
        Cycle(start: DateTime(2026, 1, 1)),
        Cycle(start: DateTime(2026, 1, 4)),
        Cycle(start: DateTime(2026, 2, 1)),
        Cycle(start: DateTime(2026, 3, 1)),
      ];
      final p = predictor.predict(cycles);
      expect(p.observedCycles, 2); // Jan 4 -> Feb 1 and Feb 1 -> Mar 1
      expect(p.cycleLength, inInclusiveRange(27, 29));
    });

    test('only the recent window counts', () {
      // Long-ago 21-day cycles should not drag down a settled 30-day rhythm.
      final p = predictor.predict(
        history(jan1, [21, 21, 21, 30, 30, 30, 30, 30, 30]),
      );
      expect(p.observedCycles, 6);
      expect(p.cycleLength, inInclusiveRange(29, 30));
    });

    test('cycles given out of order are still read correctly', () {
      final shuffled = history(jan1, [28, 28, 28]).reversed.toList();
      final p = predictor.predict(shuffled);
      expect(p.observedCycles, 3);
      expect(p.cycleLength, 28);
    });
  });

  group('current cycle', () {
    test('day of cycle is 1-based on the first day of bleeding', () {
      final p = predictor.predict(history(jan1, [28, 28]), asOf: DateTime(2026, 2, 26));
      expect(p.dayOfCycle, 1);
    });

    test('day of cycle counts forward from the last start', () {
      final p = predictor.predict(history(jan1, [28, 28]), asOf: DateTime(2026, 3, 5));
      expect(p.dayOfCycle, 8);
    });

    test('days until next can go negative when a period is late', () {
      final p = predictor.predict(history(jan1, [28, 28]), asOf: DateTime(2026, 4, 1));
      expect(p.daysUntilNext!, lessThan(0));
    });
  });

  group('a period with no end logged', () {
    final start = DateTime(2026, 3, 1);

    test('is in progress for up to two weeks', () {
      final c = Cycle(start: start);
      expect(c.inProgressOn(start), isTrue);
      expect(c.inProgressOn(addDays(start, 13)), isTrue);
      expect(c.inProgressOn(addDays(start, 14)), isFalse);
    });

    test('an ended one never is', () {
      final c = Cycle(start: start, end: addDays(start, 4));
      expect(c.inProgressOn(addDays(start, 2)), isFalse);
    });
  });

  group('periods that went unlogged', () {
    // Six identical cycles: a 28-day estimate with a one-day band, so an
    // unlogged period is assumed from day 55 after the last start.
    final raw = history(jan1, [28, 28, 28, 28, 28, 28]);
    final last = raw.last.start;
    CyclePrediction at(int daysAfterLast) =>
        predictor.predict(raw, asOf: addDays(last, daysAfterLast));

    test('a late period stays late, and says how late', () {
      final p = at(54);
      expect(p.unloggedCycles, 0);
      expect(p.nextStart, addDays(last, 28));
      expect(p.daysUntilNext, -26);
    });

    test('once a second period would be due, the estimate moves on', () {
      final p = at(55);
      expect(p.unloggedCycles, 1);
      expect(p.lastStart, last);
      expect(p.nextStart, addDays(last, 56));
      expect(p.daysUntilNext, 1);
      expect(p.earliest!.isBefore(p.nextStart!), isTrue);
      expect(p.latest!.isAfter(p.nextStart!), isTrue);
    });

    test('and keeps moving a cycle at a time as windows pass', () {
      expect(at(57).nextStart, addDays(last, 56)); // still in the window
      final p = at(58);
      expect(p.unloggedCycles, 2);
      expect(p.nextStart, addDays(last, 84));
      expect(p.daysUntilNext, greaterThan(0));
    });

    test('day of cycle still counts from the last logged start', () {
      expect(at(60).dayOfCycle, 61);
    });

    test('history flags a gap only once it looks like a missed log', () {
      final p = at(0);
      expect(p.spansUnloggedPeriod(54), isFalse);
      expect(p.spansUnloggedPeriod(55), isTrue);
      expect(CyclePrediction.empty.spansUnloggedPeriod(200), isFalse);
    });
  });

  group('period length', () {
    test('is taken from recorded bleeding days', () {
      final p = predictor.predict(history(jan1, [28, 28], periodLength: 6));
      expect(p.periodLength, 6);
    });

    test('falls back to the prior when no period has been closed out', () {
      final p = predictor.predict([Cycle(start: jan1)]);
      expect(p.periodLength, 5);
    });
  });

  group('fertile window', () {
    test('is anchored 14 days before the predicted period', () {
      final p = predictor.predict(history(jan1, [28, 28, 28]));
      expect(daysBetween(p.ovulation!, p.nextStart!), 14);
      expect(p.fertileStart!.isBefore(p.ovulation!), isTrue);
      expect(p.fertileEnd!.isAfter(p.ovulation!), isTrue);
    });
  });

  group('excluded cycles', () {
    /// Marks the cycle at [index] as excluded.
    List<Cycle> exclude(List<Cycle> cycles, int index) => [
          for (var i = 0; i < cycles.length; i++)
            i == index ? cycles[i].copyWith(excluded: true) : cycles[i],
        ];

    test('an excluded cycle does not drag the estimate', () {
      // One 60-day cycle after illness, among otherwise steady 28s.
      final raw = history(jan1, [28, 28, 60, 28, 28, 28]);
      final withOutlier = predictor.predict(raw);
      final excluded = predictor.predict(exclude(raw, 2));

      expect(excluded.observedCycles, withOutlier.observedCycles - 1);
      expect(excluded.variability!, lessThan(withOutlier.variability!));
      expect(excluded.cycleLength, 28);
    });

    test('its start still bounds the cycle before it', () {
      // Excluding the middle cycle must not produce a 28+60 = 88-day gap.
      final raw = history(jan1, [28, 60, 28]);
      final p = predictor.predict(exclude(raw, 1));
      expect(p.observedCycles, 2);
      expect(p.cycleLength, 28);
    });

    test('an excluded current cycle still anchors the next prediction', () {
      final raw = history(jan1, [28, 28, 28]);
      final p = predictor.predict(exclude(raw, 3), asOf: raw.last.start);
      expect(p.nextStart, addDays(raw.last.start, p.cycleLength!));
    });

    test('its period length is ignored', () {
      final raw = [
        ...history(jan1, [28, 28], periodLength: 5),
        Cycle(start: DateTime(2026, 2, 26), end: DateTime(2026, 3, 9)),
      ];
      final p = predictor.predict(exclude(raw, 2));
      expect(p.periodLength, 5);
    });
  });
}
