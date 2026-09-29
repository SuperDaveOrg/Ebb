import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:ebb/domain/dates.dart';
import 'package:ebb/domain/day_charts.dart';
import 'package:ebb/domain/moon.dart';
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

  static final _month = DateFormat.MMM();
  static final _monthYear = DateFormat.yMMM();

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
      // All four phases while they have room, then new and full moons, then
      // full moons alone, then none: never a smear of overlapping moons.
      const room = 14.0;
      final shown = switch (slot) {
        _ when slot * 29.53 / 4 >= room => MoonPhase.values.toSet(),
        _ when slot * 29.53 / 2 >= room => {MoonPhase.newMoon, MoonPhase.full},
        _ when slot * 29.53 >= room => {MoonPhase.full},
        _ => const <MoonPhase>{},
      };
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

    // A tick on every month; a name on every month there's room for,
    // keeping to calendar steps (quarters, halves) so they read naturally.
    // The year goes on the first name and wherever it changes.
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
    for (var i = 0; i < days.length; i++) {
      final d = days[i].date;
      if (d.day != 1) continue;
      final x = plot.left + i * slot;
      canvas.drawLine(
        Offset(x, plot.bottom),
        Offset(x, plot.bottom + 4),
        gridPaint,
      );
      if ((d.month - 1) % step != 0) continue;
      final name = d.year != year ? _monthYear.format(d) : _month.format(d);
      _text(canvas, name, label, Offset(x + 3, size.height - 10), left: true);
      year = d.year;
    }
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
