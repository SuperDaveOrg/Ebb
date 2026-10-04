import 'dart:math' as math;
import 'dart:ui' as ui;

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

/// Says [milestone] was reached: a badge in the middle of the screen for a
/// few seconds, with fireworks or streamers behind it for the bigger ones.
/// Nothing blocks a tap: the overlay ignores the pointer and clears itself.
/// When the system asks for less animation the badge just appears and goes,
/// with nothing behind it.
void celebrate(BuildContext context, Milestone milestone, Who who) {
  final still = MediaQuery.disableAnimationsOf(context);
  final overlay = Overlay.of(context);
  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _Celebration(
      milestone: milestone,
      who: who,
      style: still ? null : milestone.style,
      still: still,
      onDone: entry.remove,
    ),
  );
  overlay.insert(entry);
}

class _Celebration extends StatefulWidget {
  const _Celebration({
    required this.milestone,
    required this.who,
    required this.style,
    required this.still,
    required this.onDone,
  });

  final Milestone milestone;
  final Who who;

  /// What plays behind the badge, if anything.
  final CelebrationStyle? style;
  final bool still;
  final VoidCallback onDone;

  @override
  State<_Celebration> createState() => _CelebrationState();
}

class _CelebrationState extends State<_Celebration>
    with SingleTickerProviderStateMixin {
  late final _total = widget.style == CelebrationStyle.fireworks ? 3600 : 3000;

  late final _controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: _total),
  )..forward().whenComplete(widget.onDone);

  final _seed = math.Random().nextInt(1 << 31);

  /// How long the badge takes to pop in, and to fade at the end.
  static const _inMs = 380;
  static const _outMs = 450;

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
    final badge = _Badge(milestone: widget.milestone, who: widget.who);
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.style != null)
            CustomPaint(
              painter: switch (widget.style!) {
                CelebrationStyle.fireworks => _FireworksPainter(
                  _controller,
                  palette,
                  Theme.of(context).brightness == Brightness.dark,
                  _seed,
                ),
                CelebrationStyle.streamers => _StreamersPainter(
                  _controller,
                  palette,
                  _seed,
                ),
              },
            ),
          Align(
            // Below the fireworks, which go off in the upper half.
            alignment: const Alignment(0, 0.2),
            child: widget.still
                ? badge
                : AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final ms = _controller.value * _total;
                      final popIn = (ms / _inMs).clamp(0.0, 1.0);
                      final out = ((_total - ms) / _outMs).clamp(0.0, 1.0);
                      return Opacity(
                        opacity: math.min(Curves.easeOut.transform(popIn), out),
                        child: Transform.scale(
                          scale:
                              0.6 + 0.4 * Curves.easeOutBack.transform(popIn),
                          child: child,
                        ),
                      );
                    },
                    child: badge,
                  ),
          ),
        ],
      ),
    );
  }
}

/// The milestone, large enough to notice, small enough to leave the
/// screen behind it in view.
class _Badge extends StatelessWidget {
  const _Badge({required this.milestone, required this.who});

  final Milestone milestone;
  final Who who;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Semantics(
      liveRegion: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Material(
          color: theme.cardTheme.color ?? scheme.surface,
          elevation: 8,
          shadowColor: Colors.black54,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    milestone.icon,
                    size: 38,
                    color: scheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  milestone.title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  milestone.message(who),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
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

/// Rockets rising to bursts across the upper screen, one after another.
/// Each burst flashes, throws a ring of sparks that streak, slow, droop and
/// twinkle out. A blurred copy drawn underneath gives the glow.
class _FireworksPainter extends CustomPainter {
  _FireworksPainter(this.t, List<Color> palette, this.dark, int seed)
    : _colours = _brighten(palette, dark),
      _bursts = _makeBursts(math.Random(seed)),
      super(repaint: t);

  final Animation<double> t;
  final bool dark;
  final List<Color> _colours;
  final List<_Burst> _bursts;

  /// The period and primary colours pushed to firework brightness, with a
  /// gold and a teal turned from the period colour. The pale window colour
  /// would brighten into the period colour again, and the lavender into a
  /// harsh indigo, so they sit this out.
  static List<Color> _brighten(List<Color> palette, bool dark) {
    final warm = HSLColor.fromColor(palette[1]);
    Color turned(double by) => warm.withHue((warm.hue + by) % 360).toColor();
    return [
      for (final c in [
        palette[1],
        turned(35),
        palette[0],
        turned(170),
      ].map(HSLColor.fromColor))
        c
            .withSaturation(math.max(c.saturation, dark ? 0.85 : 0.75))
            // Deeper on a light screen, where a pale spark disappears.
            .withLightness(dark ? 0.68 : 0.46)
            .toColor(),
    ];
  }

  static List<_Burst> _makeBursts(math.Random r) => [
    for (var i = 0; i < 10; i++)
      _Burst(
        x: 0.12 + r.nextDouble() * 0.76,
        y: 0.12 + r.nextDouble() * 0.33,
        delay: _rise + i * 0.052 + r.nextDouble() * 0.03,
        size: 0.75 + r.nextDouble() * 0.45,
        colour: i,
        sparks: [
          for (var s = 0, n = 48 + r.nextInt(16); s < n; s++)
            _Spark(
              angle: (s + r.nextDouble() * 0.6) * 2 * math.pi / n,
              speed: 0.7 + r.nextDouble() * 0.3,
              twinkle: r.nextDouble() * 2 * math.pi,
            ),
        ],
      ),
  ];

  /// How long a rocket takes to climb, and a burst to burn out, as
  /// fractions of the whole animation.
  static const _rise = 0.1;
  static const _life = 0.38;

  @override
  void paint(Canvas canvas, Size size) {
    final glow = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = dark ? 7 : 9;
    final core = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.4;
    canvas.saveLayer(
      Offset.zero & size,
      Paint()..imageFilter = ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
    );
    _draw(canvas, size, glow, isCore: false);
    canvas.restore();
    _draw(canvas, size, core, isCore: true);
  }

  void _draw(Canvas canvas, Size size, Paint paint, {required bool isCore}) {
    final now = t.value;
    final reach = size.shortestSide * 0.34;
    for (final b in _bursts) {
      final base = _colours[b.colour % _colours.length];
      // Cores run hot towards white at night; on a light screen white would
      // vanish, so they keep their colour.
      final colour = isCore && dark
          ? Color.lerp(base, Colors.white, 0.55)!
          : base;
      final centre = Offset(b.x * size.width, b.y * size.height);

      final climb = (now - (b.delay - _rise)) / _rise;
      if (climb > 0 && climb < 1) {
        final from = Offset(centre.dx, size.height);
        final rise = Curves.easeOut.transform(climb);
        final head = Offset.lerp(from, centre, rise)!;
        paint.color = colour.withValues(alpha: 0.9);
        canvas.drawLine(head, head + Offset(0, 36 * (1 - climb) + 8), paint);
        continue;
      }

      final local = (now - b.delay) / _life;
      if (local <= 0 || local >= 1) continue;
      final r = reach * b.size;

      if (local < 0.14) {
        final f = local / 0.14;
        canvas.drawCircle(
          centre,
          r * 0.35 * f + 4,
          Paint()
            ..shader = RadialGradient(
              colors: [
                Color.lerp(base, Colors.white, 0.7)!.withValues(alpha: 1 - f),
                base.withValues(alpha: 0),
              ],
            ).createShader(Rect.fromCircle(center: centre, radius: r * 0.4)),
        );
      }

      final ease = Curves.easeOutCubic.transform(local);
      final lag = Curves.easeOutCubic.transform((local - 0.16).clamp(0, 1));
      final fade = 1 - Curves.easeIn.transform(local);
      final fall = local * local * r * 0.45;
      for (final s in b.sparks) {
        final flicker = local < 0.45
            ? 1.0
            : 0.5 + 0.5 * math.sin(now * 140 + s.twinkle);
        paint.color = colour.withValues(alpha: fade * flicker);
        final dir = Offset(math.cos(s.angle), math.sin(s.angle)) * r * s.speed;
        canvas.drawLine(
          centre + dir * lag + Offset(0, fall * 0.8),
          centre + dir * ease + Offset(0, fall),
          paint,
        );
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
    required this.size,
    required this.colour,
    required this.sparks,
  });

  /// Centre, as a fraction of the screen.
  final double x, y;

  /// When it goes off, as a fraction of the whole animation.
  final double delay;

  /// Relative to the standard burst.
  final double size;
  final int colour;
  final List<_Spark> sparks;
}

class _Spark {
  const _Spark({
    required this.angle,
    required this.speed,
    required this.twinkle,
  });

  final double angle, speed, twinkle;
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
