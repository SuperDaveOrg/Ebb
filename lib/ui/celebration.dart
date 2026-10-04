import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:ebb/domain/milestones.dart';
import 'package:ebb/ui/theme.dart';
import 'package:ebb/ui/wording.dart';

/// How each milestone is named in History, and what's said when it's
/// reached. About the record, never the body, and nothing it doesn't know:
/// "six cycles" is a count, not a promise that estimates are now right.
extension MilestoneWording on Milestone {
  String get title => switch (this) {
    Milestone.firstPeriod => 'First period logged',
    Milestone.firstCycle => 'First full cycle',
    Milestone.threeCycles => 'Three full cycles',
    Milestone.sixCycles => 'Six full cycles',
    Milestone.oneYear => 'A year of history',
    Milestone.twoYears => 'Two years of history',
    Milestone.fiveYears => 'Five years of history',
    Milestone.firstBackup => 'First backup saved',
  };

  String message(Who who) => switch (this) {
    Milestone.firstPeriod => '${who.whoseCap} first period in Ebb.',
    Milestone.firstCycle =>
      'A first full cycle. Ebb can start learning ${who.whose} rhythm.',
    Milestone.threeCycles =>
      'Three full cycles logged. Each one gives Ebb more to go on.',
    Milestone.sixCycles =>
      'Six full cycles logged: as many as Ebb looks at for each estimate.',
    Milestone.oneYear => 'A year of ${who.whose} history in Ebb.',
    Milestone.twoYears => 'Two years of ${who.whose} history in Ebb.',
    Milestone.fiveYears => 'Five years of ${who.whose} history in Ebb.',
    Milestone.firstBackup =>
      'Your first backup is saved. Keep a copy somewhere other than this '
          'phone.',
  };

  IconData get icon => switch (this) {
    Milestone.firstPeriod => Icons.flag_outlined,
    Milestone.firstCycle ||
    Milestone.threeCycles ||
    Milestone.sixCycles => Icons.autorenew,
    Milestone.oneYear ||
    Milestone.twoYears ||
    Milestone.fiveYears => Icons.event_available_outlined,
    Milestone.firstBackup => Icons.save_alt,
  };

  /// The bigger moments get something to watch; the rest just a message.
  CelebrationStyle? get style => switch (this) {
    Milestone.firstPeriod ||
    Milestone.oneYear ||
    Milestone.twoYears ||
    Milestone.fiveYears => CelebrationStyle.fireworks,
    Milestone.sixCycles => CelebrationStyle.streamers,
    _ => null,
  };
}

enum CelebrationStyle { fireworks, streamers }

/// Says [milestone] was reached, with fireworks or streamers for the bigger
/// ones. Nothing moves when the system asks for less animation, and nothing
/// blocks a tap: the overlay ignores the pointer and clears itself.
void celebrate(BuildContext context, Milestone milestone, Who who) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(milestone.message(who))),
  );
  final style = milestone.style;
  if (style == null || MediaQuery.disableAnimationsOf(context)) return;
  final overlay = Overlay.of(context);
  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _Celebration(style: style, onDone: entry.remove),
  );
  overlay.insert(entry);
}

class _Celebration extends StatefulWidget {
  const _Celebration({required this.style, required this.onDone});

  final CelebrationStyle style;
  final VoidCallback onDone;

  @override
  State<_Celebration> createState() => _CelebrationState();
}

class _CelebrationState extends State<_Celebration>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2800),
  )..forward().whenComplete(widget.onDone);

  final _seed = math.Random().nextInt(1 << 31);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = EbbColors.of(context);
    final palette = [
      scheme.primary,
      colors.period,
      colors.elapsed,
      colors.window,
    ];
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: switch (widget.style) {
          CelebrationStyle.fireworks => _FireworksPainter(
            _controller,
            palette,
            _seed,
          ),
          CelebrationStyle.streamers => _StreamersPainter(
            _controller,
            palette,
            _seed,
          ),
        },
      ),
    );
  }
}

/// A few bursts in the upper part of the screen, one after another, each a
/// ring of sparks that slow, fall a little and fade.
class _FireworksPainter extends CustomPainter {
  _FireworksPainter(this.t, this.palette, int seed)
    : _bursts = _makeBursts(math.Random(seed)),
      super(repaint: t);

  final Animation<double> t;
  final List<Color> palette;
  final List<_Burst> _bursts;

  static List<_Burst> _makeBursts(math.Random r) => [
    for (var i = 0; i < 4; i++)
      _Burst(
        x: 0.2 + r.nextDouble() * 0.6,
        y: 0.15 + r.nextDouble() * 0.3,
        delay: i * 0.16 + r.nextDouble() * 0.05,
        sparks: 22 + r.nextInt(10),
        colour: i,
        spin: r.nextDouble() * math.pi,
      ),
  ];

  static const _life = 0.5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeCap = StrokeCap.round;
    final reach = size.shortestSide * 0.28;
    for (final b in _bursts) {
      final local = (t.value - b.delay) / _life;
      if (local <= 0 || local >= 1) continue;
      final ease = Curves.easeOutCubic.transform(local);
      final fade = 1 - Curves.easeIn.transform(local);
      final centre = Offset(b.x * size.width, b.y * size.height);
      final fall = local * local * reach * 0.35;
      paint
        ..color = palette[b.colour % palette.length].withValues(alpha: fade)
        ..strokeWidth = 3;
      for (var i = 0; i < b.sparks; i++) {
        final angle = b.spin + i * 2 * math.pi / b.sparks;
        final dir = Offset(math.cos(angle), math.sin(angle));
        final head = centre + dir * (ease * reach) + Offset(0, fall);
        final tail = centre + dir * (ease * reach * 0.8) + Offset(0, fall);
        canvas.drawLine(tail, head, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_FireworksPainter old) => false;
}

class _Burst {
  const _Burst({
    required this.x,
    required this.y,
    required this.delay,
    required this.sparks,
    required this.colour,
    required this.spin,
  });

  /// Centre, as a fraction of the screen.
  final double x, y;

  /// When it goes off, as a fraction of the whole animation.
  final double delay;
  final int sparks;
  final int colour;
  final double spin;
}

/// Ribbons drifting down from the top, swaying as they fall.
class _StreamersPainter extends CustomPainter {
  _StreamersPainter(this.t, this.palette, int seed)
    : _ribbons = _makeRibbons(math.Random(seed)),
      super(repaint: t);

  final Animation<double> t;
  final List<Color> palette;
  final List<_Ribbon> _ribbons;

  static List<_Ribbon> _makeRibbons(math.Random r) => [
    for (var i = 0; i < 36; i++)
      _Ribbon(
        x: r.nextDouble(),
        delay: r.nextDouble() * 0.35,
        speed: 0.8 + r.nextDouble() * 0.5,
        sway: 10 + r.nextDouble() * 18,
        phase: r.nextDouble() * 2 * math.pi,
        length: 14 + r.nextDouble() * 16,
        colour: i,
      ),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    // Fades out over the last fifth, rather than leaving mid-fall.
    final fade =
        1 - Curves.easeIn.transform(((t.value - 0.8) / 0.2).clamp(0, 1));
    for (final r in _ribbons) {
      final local = (t.value - r.delay) / (1 - r.delay);
      if (local <= 0) continue;
      final y = -r.length + local * r.speed * (size.height + r.length);
      final x = r.x * size.width;
      paint.color = palette[r.colour % palette.length].withValues(alpha: fade);
      final path = Path();
      for (var i = 0; i <= 6; i++) {
        final along = i / 6;
        final py = y + along * r.length;
        final px =
            x + math.sin(r.phase + local * 9 + along * math.pi) * r.sway * 0.4;
        i == 0 ? path.moveTo(px, py) : path.lineTo(px, py);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_StreamersPainter old) => false;
}

class _Ribbon {
  const _Ribbon({
    required this.x,
    required this.delay,
    required this.speed,
    required this.sway,
    required this.phase,
    required this.length,
    required this.colour,
  });

  final double x, delay, speed, sway, phase, length;
  final int colour;
}
