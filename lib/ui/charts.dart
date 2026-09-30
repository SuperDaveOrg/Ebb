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
