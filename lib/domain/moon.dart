import 'dart:math' as math;

import 'package:ebb/domain/dates.dart';

/// The four principal phases of the moon.
///
/// Shown on the calendar for interest only. Ebb makes no claim that they
/// have anything to do with a cycle, and nothing here feeds the predictor.
enum MoonPhase {
  newMoon('New moon'),
  firstQuarter('First quarter'),
  full('Full moon'),
  lastQuarter('Last quarter');

  const MoonPhase(this.label);
  final String label;
}

/// One principal phase and the instant it happens, in UTC.
class MoonEvent {
  const MoonEvent(this.phase, this.at);

  final MoonPhase phase;
  final DateTime at;

  /// The local calendar day it falls on. A phase is one instant everywhere,
  /// so only the day it lands on depends on the time zone.
  DateTime get day => dateOnly(at.toLocal());
}

/// Every principal phase from [from] up to, but not including, [to].
///
/// Jean Meeus, *Astronomical Algorithms* (2nd ed.), chapter 49. Accurate to
/// well under a minute for centuries either side of now, so a phase near
/// midnight still lands on the right day.
List<MoonEvent> moonPhasesBetween(DateTime from, DateTime to) {
  // Lunations since the new moon of 2000 January 6, starting one early so
  // a phase just after [from] isn't missed.
  var k = ((_julian(from) - _epoch) / _synodic).floorToDouble() - 1;
  final events = <MoonEvent>[];
  while (true) {
    for (final phase in MoonPhase.values) {
      final at = _instant(k + phase.index / 4, phase);
      if (!at.isBefore(to)) return events;
      if (!at.isBefore(from)) events.add(MoonEvent(phase, at));
    }
    k += 1;
  }
}

/// The phase falling on each local day from [first] to [last] inclusive,
/// keyed by [isoDate]. Most days have none, and none has two.
Map<String, MoonEvent> moonPhasesByDay(DateTime first, DateTime last) => {
  for (final e in moonPhasesBetween(
    dateOnly(first).toUtc(),
    addDays(last, 1).toUtc(),
  ))
    isoDate(e.day): e,
};

const _epoch = 2451550.09766;
const _synodic = 29.530588861;

/// Julian Day of a moment.
double _julian(DateTime t) =>
    t.toUtc().millisecondsSinceEpoch / Duration.millisecondsPerDay + 2440587.5;

double _sin(double degrees) => math.sin(degrees * math.pi / 180);
double _cos(double degrees) => math.cos(degrees * math.pi / 180);

/// The instant of [phase] in lunation [k] (whole for a new moon, then
/// .25, .5 and .75).
DateTime _instant(double k, MoonPhase phase) {
  final t = k / 1236.85;
  final t2 = t * t, t3 = t2 * t, t4 = t3 * t;

  var jde =
      _epoch +
      _synodic * k +
      0.00015437 * t2 -
      0.000000150 * t3 +
      0.00000000073 * t4;

  final e = 1 - 0.002516 * t - 0.0000074 * t2;
  // Sun's and moon's mean anomalies, the moon's argument of latitude and
  // the longitude of its ascending node, in degrees.
  final m = 2.5534 + 29.10535670 * k - 0.0000014 * t2 - 0.00000011 * t3;
  final mp =
      201.5643 +
      385.81693528 * k +
      0.0107582 * t2 +
      0.00001238 * t3 -
      0.000000058 * t4;
  final f =
      160.7108 +
      390.67050284 * k -
      0.0016118 * t2 -
      0.00000227 * t3 +
      0.000000011 * t4;
  final om = 124.7746 - 1.56375588 * k + 0.0020672 * t2 + 0.00000215 * t3;

  switch (phase) {
    case MoonPhase.newMoon || MoonPhase.full:
      final isNew = phase == MoonPhase.newMoon;
      jde +=
          (isNew ? -0.40720 : -0.40614) * _sin(mp) +
          (isNew ? 0.17241 : 0.17302) * e * _sin(m) +
          (isNew ? 0.01608 : 0.01614) * _sin(2 * mp) +
          (isNew ? 0.01039 : 0.01043) * _sin(2 * f) +
          (isNew ? 0.00739 : 0.00734) * e * _sin(mp - m) -
          (isNew ? 0.00514 : 0.00515) * e * _sin(mp + m) +
          (isNew ? 0.00208 : 0.00209) * e * e * _sin(2 * m) -
          0.00111 * _sin(mp - 2 * f) -
          0.00057 * _sin(mp + 2 * f) +
          0.00056 * e * _sin(2 * mp + m) -
          0.00042 * _sin(3 * mp) +
          0.00042 * e * _sin(m + 2 * f) +
          0.00038 * e * _sin(m - 2 * f) -
          0.00024 * e * _sin(2 * mp - m) -
          0.00017 * _sin(om) -
          0.00007 * _sin(mp + 2 * m) +
          0.00004 * _sin(2 * mp - 2 * f) +
          0.00004 * _sin(3 * m) +
          0.00003 * _sin(mp + m - 2 * f) +
          0.00003 * _sin(2 * mp + 2 * f) -
          0.00003 * _sin(mp + m + 2 * f) +
          0.00003 * _sin(mp - m + 2 * f) -
          0.00002 * _sin(mp - m - 2 * f) -
          0.00002 * _sin(3 * mp + m) +
          0.00002 * _sin(4 * mp);
    case MoonPhase.firstQuarter || MoonPhase.lastQuarter:
      jde +=
          -0.62801 * _sin(mp) +
          0.17172 * e * _sin(m) -
          0.01183 * e * _sin(mp + m) +
          0.00862 * _sin(2 * mp) +
          0.00804 * _sin(2 * f) +
          0.00454 * e * _sin(mp - m) +
          0.00204 * e * e * _sin(2 * m) -
          0.00180 * _sin(mp - 2 * f) -
          0.00070 * _sin(mp + 2 * f) -
          0.00040 * _sin(3 * mp) -
          0.00034 * e * _sin(2 * mp - m) +
          0.00032 * e * _sin(m + 2 * f) +
          0.00032 * e * _sin(m - 2 * f) -
          0.00028 * e * e * _sin(mp + 2 * m) +
          0.00027 * e * _sin(2 * mp + m) -
          0.00017 * _sin(om) -
          0.00005 * _sin(mp - m - 2 * f) +
          0.00004 * _sin(2 * mp + 2 * f) -
          0.00004 * _sin(mp + m + 2 * f) +
          0.00004 * _sin(mp - 2 * m) +
          0.00003 * _sin(mp + m - 2 * f) +
          0.00003 * _sin(3 * m) +
          0.00002 * _sin(2 * mp - 2 * f) +
          0.00002 * _sin(mp - m + 2 * f) -
          0.00002 * _sin(3 * mp + m);
      final w =
          0.00306 -
          0.00038 * e * _cos(m) +
          0.00026 * _cos(mp) -
          0.00002 * _cos(mp - m) +
          0.00002 * _cos(mp + m) +
          0.00002 * _cos(2 * f);
      jde += phase == MoonPhase.firstQuarter ? w : -w;
  }

  // Small corrections from the planets, common to every phase.
  const planets = [
    (0.000325, 299.77, 0.107408),
    (0.000165, 251.88, 0.016321),
    (0.000164, 251.83, 26.651886),
    (0.000126, 349.42, 36.412478),
    (0.000110, 84.66, 18.206239),
    (0.000062, 141.74, 53.303771),
    (0.000060, 207.14, 2.453732),
    (0.000056, 154.84, 7.306860),
    (0.000047, 34.52, 27.261239),
    (0.000042, 207.19, 0.121824),
    (0.000040, 291.34, 1.844379),
    (0.000037, 161.72, 24.198154),
    (0.000035, 239.56, 25.513099),
    (0.000023, 331.55, 3.592518),
  ];
  for (final (i, (amp, base, rate)) in planets.indexed) {
    // Only the first argument has a T² term.
    final a = base + rate * k - (i == 0 ? 0.009173 * t2 : 0);
    jde += amp * _sin(a);
  }

  // JDE is in Terrestrial Time, which runs about 69 seconds ahead of UTC
  // this century. The drift is a few seconds a decade: nothing next to
  // the width of a day.
  const deltaT = 69;
  final ms = (jde - 2440587.5) * Duration.millisecondsPerDay;
  return DateTime.fromMillisecondsSinceEpoch(
    ms.round() - deltaT * 1000,
    isUtc: true,
  );
}
