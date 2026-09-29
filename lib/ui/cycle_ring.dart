import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:ebb/ui/theme.dart';

/// The home screen's centrepiece: the current cycle as a ring.
///
/// Read clockwise from the top. The solid warm arc is the period, the faint
/// one is when the next period is likely to start — a range, never a single
/// tick, because the estimate is a range — and the dot is today. The ring
/// only ever shows what the numbers underneath already say.
class CycleRing extends StatelessWidget {
  const CycleRing({
    super.key,
    required this.day,
    required this.cycleLength,
    required this.periodDays,
    required this.windowStart,
    required this.windowEnd,
    required this.inPeriod,
    required this.label,
    this.size = 248,
  });

  /// 1-based day of the current cycle.
  final int day;

  /// Expected length. The ring stretches if today is already past it.
  final int cycleLength;

  /// Days of bleeding to mark from the start (so far, if still going).
  final int periodDays;

  /// The likely window for the next start, as 1-based days of this cycle.
  final int? windowStart;
  final int? windowEnd;
  final bool inPeriod;

  /// Under the number: "of your cycle", "of Sam’s period".
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = EbbColors.of(context);
    return Semantics(
      label: 'Day $day $label',
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _RingPainter(
            day: day,
            total: math.max(cycleLength, day),
            periodDays: periodDays,
            windowStart: windowStart,
            windowEnd: windowEnd,
            inPeriod: inPeriod,
            progress: theme.colorScheme.primary,
            elapsed: colors.elapsed,
            period: colors.period,
            window: colors.window,
            track: colors.track,
            halo: theme.cardTheme.color ?? theme.colorScheme.surface,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('DAY', style: theme.textTheme.labelSmall),
                Text('$day', style: theme.textTheme.displayLarge),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.day,
    required this.total,
    required this.periodDays,
    required this.windowStart,
    required this.windowEnd,
    required this.inPeriod,
    required this.progress,
    required this.elapsed,
    required this.period,
    required this.window,
    required this.track,
    required this.halo,
  });

  final int day;
  final int total;
  final int periodDays;
  final int? windowStart;
  final int? windowEnd;
  final bool inPeriod;
  final Color progress;
  final Color elapsed;
  final Color period;
  final Color window;
  final Color track;
  final Color halo;

  static const _stroke = 14.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - _stroke;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final perDay = 2 * math.pi / total;
    const top = -math.pi / 2;

    Paint arc(Color c, {double width = _stroke}) => Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..color = c;

    // Days are counted from the start of day 1, so day d spans
    // [(d-1) * perDay, d * perDay).
    void span(int from, int to, Paint paint) {
      final sweep = (to - from + 1) * perDay;
      if (sweep <= 0) return;
      // Inset a hair so round caps don't overshoot the day they belong to.
      final inset = math.min(0.04, sweep / 4);
      canvas.drawArc(
        rect,
        top + (from - 1) * perDay + inset,
        sweep - inset * 2,
        false,
        paint,
      );
    }

    canvas.drawCircle(center, radius, arc(track));

    // Time already passed is only a tint: the period and the likely window
    // are what matter, so they're drawn on top, and today is the dot. The
    // same tint is the logo's ring (assets/brand/ebb_logo.svg).
    span(1, day, arc(elapsed));

    final ws = windowStart, we = windowEnd;
    if (ws != null && we != null) {
      span(ws.clamp(1, total), we.clamp(1, total), arc(window));
    }

    span(1, math.min(periodDays, total), arc(period));

    // Today: a dot sitting on the ring, ringed in the card colour so it
    // reads against both the arc and the track.
    final angle = top + (day - 0.5) * perDay;
    final dot = center + Offset(math.cos(angle), math.sin(angle)) * radius;
    canvas.drawCircle(dot, _stroke * 0.95, Paint()..color = halo);
    canvas.drawCircle(
      dot,
      _stroke * 0.62,
      Paint()..color = inPeriod ? period : progress,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.day != day ||
      old.total != total ||
      old.periodDays != periodDays ||
      old.windowStart != windowStart ||
      old.windowEnd != windowEnd ||
      old.inPeriod != inPeriod ||
      old.progress != progress ||
      old.elapsed != elapsed ||
      old.period != period ||
      old.window != window ||
      old.track != track ||
      old.halo != halo;
}
