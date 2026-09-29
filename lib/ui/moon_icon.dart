import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:ebb/domain/moon.dart';

/// A small drawn moon: empty for new, half lit for the quarters, full for
/// full. Drawn rather than taken from an icon font so it follows the theme
/// and stays crisp at calendar size.
///
/// The quarters are lit as seen from the northern hemisphere, the same way
/// round as the moon emoji and most printed calendars.
class MoonIcon extends StatelessWidget {
  const MoonIcon(this.phase, {super.key, this.size = 9, this.backdrop});

  final MoonPhase phase;
  final double size;

  /// Painted as a thin ring behind the moon, so it stays readable where it
  /// overlaps a coloured band.
  final Color? backdrop;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(
        size: Size.square(size),
        painter: _MoonPainter(
          phase: phase,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          backdrop: backdrop,
        ),
      ),
    );
  }
}

class _MoonPainter extends CustomPainter {
  _MoonPainter({required this.phase, required this.color, this.backdrop});

  final MoonPhase phase;
  final Color color;
  final Color? backdrop;

  @override
  void paint(Canvas canvas, Size size) => paintMoon(
    canvas,
    size.center(Offset.zero),
    size.width,
    phase,
    color,
    backdrop: backdrop,
  );

  @override
  bool shouldRepaint(_MoonPainter old) =>
      old.phase != phase || old.color != color || old.backdrop != backdrop;
}

/// Draws a [size]-wide moon centred on [centre]. Shared with the charts, so
/// a moon looks the same everywhere.
void paintMoon(
  Canvas canvas,
  Offset centre,
  double size,
  MoonPhase phase,
  Color color, {
  Color? backdrop,
}) {
  final stroke = size / 9;
  final radius = size / 2 - stroke / 2;
  final disc = Rect.fromCircle(center: centre, radius: radius);

  if (backdrop != null) {
    canvas.drawCircle(centre, radius + stroke * 1.5, Paint()..color = backdrop);
  }

  final lit = Paint()..color = color;
  switch (phase) {
    case MoonPhase.full:
      canvas.drawOval(disc, lit);
    case MoonPhase.firstQuarter:
      canvas.drawArc(disc, -math.pi / 2, math.pi, true, lit);
    case MoonPhase.lastQuarter:
      canvas.drawArc(disc, math.pi / 2, math.pi, true, lit);
    case MoonPhase.newMoon:
      break;
  }
  canvas.drawOval(
    disc,
    Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke,
  );
}
