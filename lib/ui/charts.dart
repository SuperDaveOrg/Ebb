import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/day_charts.dart';
import 'package:ebb/domain/moon.dart';
import 'package:ebb/domain/temperature.dart';
import 'package:ebb/models/day_log.dart';
import 'package:ebb/ui/moon_icon.dart';
import 'package:ebb/ui/theme.dart';

TextStyle _labelStyle(ThemeData theme) => theme.textTheme.labelSmall!.copyWith(
  color: theme.colorScheme.onSurfaceVariant,
);

void _text(
  Canvas canvas,
  String s,
  TextStyle style,
  Offset at, {
  bool left = false,
}) {
  final tp = TextPainter(
    text: TextSpan(text: s, style: style),
    textDirection: TextDirection.ltr,
  )..layout();
  tp.paint(canvas, at + Offset(left ? 0 : -tp.width / 2, -tp.height / 2));
}

/// How each day's rating is drawn.
enum TimelineStyle { bars, line }

/// Each day's rating, as a bar or a point on a line, with logged period
/// days shaded behind and, when asked for, the moon's phases above.
///
/// The whole range always fits the width: a year looks like a year. Over a
/// long range the bars merge into one shape, the line loses its dots, and
/// month names and moons thin out rather than pile up.
class RatingTimelineChart extends StatelessWidget {
  const RatingTimelineChart({
    super.key,
    required this.days,
    this.style = TimelineStyle.bars,
    this.moons,
  });

  final List<TimelineDay> days;
  final TimelineStyle style;

  /// Phases by [isoDate]; null to leave the moon out.
  final Map<String, MoonEvent>? moons;

  static const _axisWidth = 22.0;
  static const _height = 220.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = EbbColors.of(context);
    final label = _labelStyle(theme);
    final rated = days.where((d) => d.rating != null).length;
    final fmt = DateFormat.yMMMd();
    final top = moons == null ? 8.0 : 22.0;

    return Semantics(
      label:
          'Day ratings from ${fmt.format(days.first.date)} to '
          '${fmt.format(days.last.date)}: $rated rated days, with period '
          'days shaded${moons == null ? '' : ' and moon phases marked'}.',
      excludeSemantics: true,
      child: SizedBox(
        height: _height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: _axisWidth,
              child: CustomPaint(
                painter: _AxisPainter(label: label, top: top, style: style),
              ),
            ),
            Expanded(
              child: CustomPaint(
                painter: _TimelinePainter(
                  days: days,
                  style: style,
                  moons: moons,
                  top: top,
                  bar: theme.colorScheme.primary,
                  grid: colors.track,
                  period: colors.period,
                  label: label,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bars stand on 0, so a 1 is still a bar you can see; a line has no need,
/// and runs 1 to 5 over the full height.
double _timelineY(num rating, double top, double bottom, TimelineStyle style) =>
    style == TimelineStyle.bars
    ? bottom - rating / 5 * (bottom - top)
    : bottom - (rating - 1) / 4 * (bottom - top);

/// The 1–5 labels, beside the chart.
class _AxisPainter extends CustomPainter {
  _AxisPainter({required this.label, required this.top, required this.style});

  final TextStyle label;
  final double top;
  final TimelineStyle style;

  @override
  void paint(Canvas canvas, Size size) {
    final bottom = size.height - 22;
    for (final r in [1, 3, 5]) {
      _text(
        canvas,
        '$r',
        label,
        Offset(4, _timelineY(r, top, bottom, style)),
        left: true,
      );
    }
  }

  @override
  bool shouldRepaint(_AxisPainter old) =>
      old.label != label || old.top != top || old.style != style;
}

class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    required this.days,
    required this.style,
    required this.moons,
    required this.top,
    required this.bar,
    required this.grid,
    required this.period,
    required this.label,
  });

  final List<TimelineDay> days;
  final TimelineStyle style;
  final Map<String, MoonEvent>? moons;
  final double top;
  final Color bar;
  final Color grid;
  final Color period;
  final TextStyle label;

  @override
  void paint(Canvas canvas, Size size) {
    final plot = Rect.fromLTRB(0, top, size.width - 4, size.height - 22);
    final slot = plot.width / days.length;
    double y(num rating) => _timelineY(rating, plot.top, plot.bottom, style);

    // Each run of period days as one block: drawn a day at a time, the
    // translucent edges overlap into stripes.
    final shade = Paint()..color = period.withValues(alpha: 0.18);
    for (var i = 0; i < days.length; i++) {
      if (!days[i].period || (i > 0 && days[i - 1].period)) continue;
      var j = i;
      while (j + 1 < days.length && days[j + 1].period) {
        j++;
      }
      canvas.drawRect(
        Rect.fromLTRB(
          plot.left + i * slot,
          plot.top,
          plot.left + (j + 1) * slot,
          plot.bottom,
        ),
        shade,
      );
    }

    final gridPaint = Paint()
      ..color = grid
      ..strokeWidth = 1;
    for (final r in [1, 3, 5]) {
      canvas.drawLine(
        Offset(plot.left, y(r)),
        Offset(plot.right, y(r)),
        gridPaint,
      );
    }

    double cx(int i) => plot.left + (i + 0.5) * slot;
    final barPaint = Paint()..color = bar;
    switch (style) {
      case TimelineStyle.bars:
        // A gap between bars while it can be seen; after that they touch.
        final width = slot >= 3 ? slot * 0.7 : slot;
        for (var i = 0; i < days.length; i++) {
          final r = days[i].rating;
          if (r == null) continue;
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromLTRB(
                cx(i) - width / 2,
                y(r),
                cx(i) + width / 2,
                plot.bottom,
              ),
              topLeft: Radius.circular(width / 2),
              topRight: Radius.circular(width / 2),
            ),
            barPaint,
          );
        }
      case TimelineStyle.line:
        // Joined only from one rated day to the next: across an unrated
        // day the line breaks, rather than inventing what came between.
        final linePaint = Paint()
          ..color = bar
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.round
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
        // Dots only while there's room for them; over a long range they
        // would crowd into a second, thicker line.
        final dot = slot >= 2 ? math.min(3.0, slot * 0.4 + 0.8) : 0.0;
        for (var i = 0; i < days.length; i++) {
          final r = days[i].rating;
          if (r == null) continue;
          final prev = i > 0 ? days[i - 1].rating : null;
          if (prev != null) {
            canvas.drawLine(
              Offset(cx(i - 1), y(prev)),
              Offset(cx(i), y(r)),
              linePaint,
            );
          }
          if (dot > 0) canvas.drawCircle(Offset(cx(i), y(r)), dot, barPaint);
        }
    }

    final m = moons;
    if (m != null) {
      final shown = _phasesWithRoom(slot);
      for (var i = 0; i < days.length; i++) {
        final e = m[isoDate(days[i].date)];
        if (e == null || !shown.contains(e.phase)) continue;
        paintMoon(
          canvas,
          Offset(plot.left + (i + 0.5) * slot, top / 2),
          10,
          e.phase,
          label.color!,
        );
      }
    }

    _paintMonths(
      canvas,
      first: days.first.date,
      count: days.length,
      left: plot.left,
      slot: slot,
      axis: plot.bottom,
      labelY: size.height - 10,
      label: label,
      grid: gridPaint,
    );
  }

  @override
  bool shouldRepaint(_TimelinePainter old) =>
      old.days != days ||
      old.style != style ||
      old.moons != moons ||
      old.top != top ||
      old.bar != bar ||
      old.grid != grid ||
      old.period != period ||
      old.label != label;
}

/// The phases there's room to draw when each day is [slot] wide: all four,
/// then new and full moons, then full moons alone, then none — never a
/// smear of overlapping moons.
Set<MoonPhase> _phasesWithRoom(double slot) {
  const room = 14.0;
  return switch (slot) {
    _ when slot * 29.53 / 4 >= room => MoonPhase.values.toSet(),
    _ when slot * 29.53 / 2 >= room => {MoonPhase.newMoon, MoonPhase.full},
    _ when slot * 29.53 >= room => {MoonPhase.full},
    _ => const <MoonPhase>{},
  };
}

final _month = DateFormat.MMM();
final _monthYear = DateFormat.yMMM();

/// A tick on every month; a name on every month there's room for, keeping
/// to calendar steps (quarters, halves) so they read naturally. The year
/// goes on the first name and wherever it changes.
void _paintMonths(
  Canvas canvas, {
  required DateTime first,
  required int count,
  required double left,
  required double slot,
  required double axis,
  required double labelY,
  required TextStyle label,
  required Paint grid,
}) {
  const labelRoom = 56.0;
  final step = [
    1,
    2,
    3,
    4,
    6,
    12,
  ].firstWhere((n) => n * 30.4 * slot >= labelRoom, orElse: () => 12);
  int? year;
  for (var i = 0; i < count; i++) {
    final d = addDays(first, i);
    if (d.day != 1) continue;
    final x = left + i * slot;
    canvas.drawLine(Offset(x, axis), Offset(x, axis + 4), grid);
    if ((d.month - 1) % step != 0) continue;
    final name = d.year != year ? _monthYear.format(d) : _month.format(d);
    _text(canvas, name, label, Offset(x + 3, labelY), left: true);
    year = d.year;
  }
}

/// One member's lane on the group view.
class GroupLane {
  const GroupLane(this.name, this.runs);

  final String name;
  final List<PeriodRun> runs;
}

/// Everyone in a group side by side: one lane each, periods as bars over the
/// same days, and — for comparing with the moon — the moon's phases along the
/// top with a faint line down through every lane at each full and new moon.
///
/// Only lays the lanes out. It measures nothing between them: whether
/// anyone's periods keep time with anyone else's, or with the moon, is for
/// the people looking to judge.
class GroupLanesChart extends StatelessWidget {
  const GroupLanesChart({
    super.key,
    required this.from,
    required this.to,
    required this.lanes,
    required this.moons,
  });

  final DateTime from;
  final DateTime to;
  final List<GroupLane> lanes;

  /// Phases by [isoDate].
  final Map<String, MoonEvent> moons;

  static const _nameWidth = 76.0;
  static const _laneHeight = 34.0;
  static const _top = 22.0;
  static const _bottom = 24.0;

  String get _summary {
    final fmt = DateFormat.MMMd();
    final each = [
      for (final l in lanes)
        '${l.name}: ${l.runs.isEmpty ? 'no period days' : [for (final r in l.runs) '${fmt.format(r.start)} to ${fmt.format(r.end)}${r.estimated ? ', estimated' : ''}'].join('; ')}',
    ];
    return 'Periods from ${fmt.format(from)} to ${fmt.format(to)}. '
        '${each.join('. ')}.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = EbbColors.of(context);
    return Semantics(
      label: _summary,
      excludeSemantics: true,
      child: SizedBox(
        width: double.infinity,
        height: _top + lanes.length * _laneHeight + _bottom,
        child: CustomPaint(
          painter: _LanesPainter(
            from: from,
            days: daysBetween(from, to) + 1,
            lanes: lanes,
            moons: moons,
            name: theme.textTheme.labelMedium!.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            label: _labelStyle(theme),
            grid: colors.track,
            period: colors.period,
          ),
        ),
      ),
    );
  }
}

class _LanesPainter extends CustomPainter {
  _LanesPainter({
    required this.from,
    required this.days,
    required this.lanes,
    required this.moons,
    required this.name,
    required this.label,
    required this.grid,
    required this.period,
  });

  final DateTime from;
  final int days;
  final List<GroupLane> lanes;
  final Map<String, MoonEvent> moons;
  final TextStyle name;
  final TextStyle label;
  final Color grid;
  final Color period;

  @override
  void paint(Canvas canvas, Size size) {
    const top = GroupLanesChart._top, laneH = GroupLanesChart._laneHeight;
    final plot = Rect.fromLTRB(
      GroupLanesChart._nameWidth,
      top,
      size.width - 4,
      top + lanes.length * laneH,
    );
    final slot = plot.width / days;
    double x(DateTime d) => plot.left + daysBetween(from, d) * slot;

    final gridPaint = Paint()
      ..color = grid
      ..strokeWidth = 1;

    // Moons along the top, and full and new moons carried down through the
    // lanes so a start near one lines up by eye.
    final shown = _phasesWithRoom(slot);
    final guide = Paint()
      ..color = label.color!.withValues(alpha: 0.28)
      ..strokeWidth = 1;
    for (var i = 0; i < days; i++) {
      final e = moons[isoDate(addDays(from, i))];
      if (e == null || !shown.contains(e.phase)) continue;
      final cx = plot.left + (i + 0.5) * slot;
      paintMoon(canvas, Offset(cx, top / 2), 10, e.phase, label.color!);
      // Solid down from a full moon, dashed from a new one, so the two can
      // be told apart without looking back up at the moons.
      if (e.phase == MoonPhase.full) {
        canvas.drawLine(Offset(cx, plot.top), Offset(cx, plot.bottom), guide);
      } else if (e.phase == MoonPhase.newMoon) {
        for (var y = plot.top; y < plot.bottom; y += 6) {
          canvas.drawLine(
            Offset(cx, y),
            Offset(cx, math.min(y + 3, plot.bottom)),
            guide,
          );
        }
      }
    }

    final fill = Paint()..color = period;
    final outline = Paint()
      ..color = period
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    const barH = 14.0;
    for (final (i, lane) in lanes.indexed) {
      final laneTop = plot.top + i * laneH;
      final mid = laneTop + laneH / 2;

      final tp = TextPainter(
        text: TextSpan(text: lane.name, style: name),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: GroupLanesChart._nameWidth - 10);
      tp.paint(canvas, Offset(0, mid - tp.height / 2));

      canvas.drawLine(
        Offset(plot.left, laneTop + laneH),
        Offset(plot.right, laneTop + laneH),
        gridPaint,
      );

      for (final run in lane.runs) {
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTRB(
            x(run.start),
            mid - barH / 2,
            // At least a sliver, so a one-day period still shows at a year's
            // width.
            math.max(x(run.start) + 2, x(run.end) + slot),
            mid + barH / 2,
          ),
          const Radius.circular(barH / 2),
        );
        canvas.drawRRect(
          run.estimated ? rect.deflate(0.75) : rect,
          run.estimated ? outline : fill,
        );
      }
    }

    _paintMonths(
      canvas,
      first: from,
      count: days,
      left: plot.left,
      slot: slot,
      axis: plot.bottom,
      labelY: size.height - 10,
      label: label,
      grid: gridPaint,
    );
  }

  @override
  bool shouldRepaint(_LanesPainter old) =>
      old.from != from ||
      old.days != days ||
      old.lanes != lanes ||
      old.moons != moons ||
      old.name != name ||
      old.label != label ||
      old.grid != grid ||
      old.period != period;
}

/// Waking temperatures as points over the days, with cervical mucus in two
/// rows beneath — how it felt and how it looked — and logged period days
/// shaded behind both, the way a paper chart for the sympto-thermal method
/// is laid out.
///
/// Draws only what was logged. It finds no rise, draws no cover line and
/// marks no fertile days: those are the method's rules, and applying them is
/// left to her.
class TemperatureChart extends StatelessWidget {
  const TemperatureChart({super.key, required this.days, required this.unit});

  final List<TemperatureDay> days;
  final TemperatureUnit unit;

  static const _axisWidth = 46.0;
  static const _plotHeight = 200.0;
  static const _rowHeight = 18.0;
  static const _rowGap = 6.0;

  /// Room between the readings and the mucus rows, so the lowest label on
  /// the axis stays clear of "Felt".
  static const _plotGap = 18.0;
  static const _months = 22.0;

  static double get height =>
      _plotHeight + _plotGap + 2 * _rowHeight + _rowGap + _months;

  String get _summary {
    final fmt = DateFormat.yMMMd();
    final readings = [
      for (final d in days)
        if (d.temperature != null) d.temperature!,
    ];
    final mucus = days
        .where((d) => d.mucusFeel != null || d.mucusLook != null)
        .length;
    final range = readings.isEmpty
        ? 'no temperatures'
        : '${readings.length} temperature${readings.length == 1 ? '' : 's'}, '
              'from ${unit.formatWithUnit(readings.reduce(math.min))} to '
              '${unit.formatWithUnit(readings.reduce(math.max))}';
    return 'Temperatures from ${fmt.format(days.first.date)} to '
        '${fmt.format(days.last.date)}: $range, cervical mucus noted on '
        '$mucus day${mucus == 1 ? '' : 's'}, with period days shaded.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = EbbColors.of(context);
    final label = _labelStyle(theme);
    final axis = temperatureAxis(days.map((d) => d.temperature).nonNulls, unit);
    return Semantics(
      label: _summary,
      excludeSemantics: true,
      child: SizedBox(
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: _axisWidth,
              child: CustomPaint(
                painter: _TemperatureAxisPainter(
                  axis: axis,
                  unit: unit,
                  label: label,
                ),
              ),
            ),
            Expanded(
              child: CustomPaint(
                painter: _TemperaturePainter(
                  days: days,
                  axis: axis,
                  unit: unit,
                  point: theme.colorScheme.primary,
                  look: theme.colorScheme.tertiary,
                  grid: colors.track,
                  period: colors.period,
                  label: label,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Where things sit vertically, shared by the axis and the chart.
class _TemperatureLayout {
  _TemperatureLayout(this.axis);

  final (double, double) axis;

  static const top = 8.0;
  static const plotBottom = TemperatureChart._plotHeight;
  static const feelTop = plotBottom + TemperatureChart._plotGap;
  static const lookTop =
      feelTop + TemperatureChart._rowHeight + TemperatureChart._rowGap;
  static const rowsBottom = lookTop + TemperatureChart._rowHeight;

  double y(double value) {
    final (low, high) = axis;
    return plotBottom - (value - low) / (high - low) * (plotBottom - top);
  }

  /// Every gridline from the bottom of the axis to the top, in the unit
  /// shown.
  List<double> lines(double step) {
    final (low, high) = axis;
    final n = ((high - low) / step).round();
    return [for (var i = 0; i <= n; i++) low + i * step];
  }

  /// Every how many gridlines to put a label, keeping them apart.
  int labelEvery(double step) {
    final (low, high) = axis;
    final px = (plotBottom - top) / ((high - low) / step);
    return [1, 2, 5, 10].firstWhere((k) => k * px >= 22, orElse: () => 10);
  }
}

class _TemperatureAxisPainter extends CustomPainter {
  _TemperatureAxisPainter({
    required this.axis,
    required this.unit,
    required this.label,
  });

  final (double, double) axis;
  final TemperatureUnit unit;
  final TextStyle label;

  @override
  void paint(Canvas canvas, Size size) {
    final layout = _TemperatureLayout(axis);
    final step = unit.chartStep;
    final every = layout.labelEvery(step);
    final lines = layout.lines(step);
    for (final (i, v) in lines.indexed) {
      if (i % every != 0) continue;
      _text(
        canvas,
        v.toStringAsFixed(1),
        label,
        Offset(2, layout.y(v)),
        left: true,
      );
    }
    const half = TemperatureChart._rowHeight / 2;
    _text(
      canvas,
      'Felt',
      label,
      const Offset(2, _TemperatureLayout.feelTop + half),
      left: true,
    );
    _text(
      canvas,
      'Looked',
      label,
      const Offset(2, _TemperatureLayout.lookTop + half),
      left: true,
    );
  }

  @override
  bool shouldRepaint(_TemperatureAxisPainter old) =>
      old.axis != axis || old.unit != unit || old.label != label;
}

class _TemperaturePainter extends CustomPainter {
  _TemperaturePainter({
    required this.days,
    required this.axis,
    required this.unit,
    required this.point,
    required this.look,
    required this.grid,
    required this.period,
    required this.label,
  });

  final List<TemperatureDay> days;
  final (double, double) axis;
  final TemperatureUnit unit;
  final Color point;
  final Color look;
  final Color grid;
  final Color period;
  final TextStyle label;

  @override
  void paint(Canvas canvas, Size size) {
    final layout = _TemperatureLayout(axis);
    final right = size.width - 4;
    final slot = right / days.length;
    double cx(int i) => (i + 0.5) * slot;

    // Period days as blocks behind the readings and the mucus rows alike.
    final shade = Paint()..color = period.withValues(alpha: 0.18);
    for (var i = 0; i < days.length; i++) {
      if (!days[i].period || (i > 0 && days[i - 1].period)) continue;
      var j = i;
      while (j + 1 < days.length && days[j + 1].period) {
        j++;
      }
      canvas.drawRect(
        Rect.fromLTRB(
          i * slot,
          _TemperatureLayout.top,
          (j + 1) * slot,
          _TemperatureLayout.rowsBottom,
        ),
        shade,
      );
    }

    final gridPaint = Paint()
      ..color = grid
      ..strokeWidth = 1;
    final step = unit.chartStep;
    final every = layout.labelEvery(step);
    final faint = Paint()
      ..color = grid.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    for (final (i, v) in layout.lines(step).indexed) {
      final y = layout.y(v);
      canvas.drawLine(
        Offset(0, y),
        Offset(right, y),
        i % every == 0 ? gridPaint : faint,
      );
    }

    // Joined only from one reading to the next day's, and never to or from
    // one that may have been affected: across a gap the line breaks rather
    // than inventing what came between.
    final linePaint = Paint()
      ..color = point
      ..strokeWidth = 2
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final dot = slot >= 2 ? math.min(3.5, slot * 0.4 + 1) : 1.2;
    final fill = Paint()..color = point;
    final ring = Paint()
      ..color = point
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    double? y(double? c) => c == null ? null : layout.y(unit.fromCelsius(c));
    for (var i = 0; i < days.length; i++) {
      final d = days[i];
      final yi = y(d.temperature);
      if (yi == null) continue;
      if (i > 0) {
        final prev = days[i - 1];
        final yp = y(prev.temperature);
        if (yp != null && !prev.disturbed && !d.disturbed) {
          canvas.drawLine(Offset(cx(i - 1), yp), Offset(cx(i), yi), linePaint);
        }
      }
      if (d.disturbed) {
        canvas.drawCircle(Offset(cx(i), yi), math.max(dot, 2.5), ring);
      } else {
        canvas.drawCircle(Offset(cx(i), yi), dot, fill);
      }
    }

    // Mucus as a bar per day, taller from dry to wet and from nothing seen
    // to egg white. Only an order of what was noted: no day is singled out.
    final width = slot >= 3 ? slot * 0.7 : slot;
    void bars(
      double top,
      Color color,
      int? Function(TemperatureDay) level,
      int levels,
    ) {
      final paint = Paint()..color = color;
      const h = TemperatureChart._rowHeight;
      canvas.drawLine(Offset(0, top + h), Offset(right, top + h), faint);
      for (var i = 0; i < days.length; i++) {
        final n = level(days[i]);
        if (n == null) continue;
        final barH = math.max(2.0, h * (n + 1) / levels);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTRB(
              cx(i) - width / 2,
              top + h - barH,
              cx(i) + width / 2,
              top + h,
            ),
            Radius.circular(math.min(2, width / 2)),
          ),
          paint,
        );
      }
    }

    bars(
      _TemperatureLayout.feelTop,
      point,
      (d) => d.mucusFeel?.index,
      MucusFeel.values.length,
    );
    bars(
      _TemperatureLayout.lookTop,
      look,
      (d) => d.mucusLook?.index,
      MucusLook.values.length,
    );

    _paintMonths(
      canvas,
      first: days.first.date,
      count: days.length,
      left: 0,
      slot: slot,
      axis: _TemperatureLayout.rowsBottom,
      labelY: size.height - 10,
      label: label,
      grid: gridPaint,
    );
  }

  @override
  bool shouldRepaint(_TemperaturePainter old) =>
      old.days != days ||
      old.axis != axis ||
      old.unit != unit ||
      old.point != point ||
      old.look != look ||
      old.grid != grid ||
      old.period != period ||
      old.label != label;
}
