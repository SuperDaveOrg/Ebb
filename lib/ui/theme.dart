import 'package:flutter/material.dart';

/// Ebb's look.
///
/// Deliberately calm: this is a health app, not a "women's app". No
/// pink-by-default, no flowers, no euphemism — but nothing clinical or covert
/// either. Warm neutrals, one confident colour, and a soft serif for the
/// numbers that matter.
///
/// Fonts are bundled (assets/fonts, SIL OFL). Never fetch them at runtime:
/// Ebb has no network, by design.

/// The handful of colours everything is built from.
class EbbPalette {
  const EbbPalette({
    required this.name,
    required this.primary,
    required this.onPrimary,
    required this.background,
    required this.card,
    required this.ink,
    required this.muted,
    required this.period,
    required this.track,
    required this.elapsed,
    required this.error,
  });

  final String name;

  /// Buttons, the progress arc, links.
  final Color primary;
  final Color onPrimary;
  final Color background;

  /// Raised surfaces: cards, sheets, dialogs.
  final Color card;

  /// Body text.
  final Color ink;

  /// Secondary text, icons, dividers.
  final Color muted;

  /// Period days on the ring, and the expected window (at lower opacity).
  final Color period;

  /// The unfilled part of the ring.
  final Color track;

  /// Days of the cycle already gone, on the ring — and the logo's ring.
  final Color elapsed;
  final Color error;

  // Three candidates, chosen between by eye. Each has a dark twin.

  /// The SuperDaveLab family: GridDock's navy and cream, with clay for
  /// the period. The logo's teal lives in the icon, not the UI.
  static const tide = EbbPalette(
    name: 'Tide',
    primary: Color(0xFF14344B),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFF5F1EA),
    card: Color(0xFFFFFCF7),
    ink: Color(0xFF14232E),
    muted: Color(0xFF65737B),
    period: Color(0xFFC4613F),
    track: Color(0xFFE4DCCF),
    elapsed: Color(0xFFA09EB9),
    error: Color(0xFFB3261E),
  );
  static const tideDark = EbbPalette(
    name: 'Tide',
    primary: Color(0xFF8CC7D3),
    onPrimary: Color(0xFF062C35),
    background: Color(0xFF11191C),
    card: Color(0xFF1A2428),
    ink: Color(0xFFE8EEF0),
    muted: Color(0xFF93A3A9),
    period: Color(0xFFE48D6D),
    track: Color(0xFF2A373C),
    elapsed: Color(0xFF55536B),
    error: Color(0xFFF2B8B5),
  );

  /// Aubergine on ivory, with copper for the period.
  static const dusk = EbbPalette(
    name: 'Dusk',
    primary: Color(0xFF4B3A63),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFF6F2EE),
    card: Color(0xFFFFFCFA),
    ink: Color(0xFF231D2B),
    muted: Color(0xFF6E6677),
    period: Color(0xFFB8643F),
    track: Color(0xFFE5DDE0),
    elapsed: Color(0xFFBDB3C8),
    error: Color(0xFFB3261E),
  );
  static const duskDark = EbbPalette(
    name: 'Dusk',
    primary: Color(0xFFC9B6E6),
    onPrimary: Color(0xFF2A1D3D),
    background: Color(0xFF16131B),
    card: Color(0xFF211C28),
    ink: Color(0xFFEEE9F3),
    muted: Color(0xFFA39BAD),
    period: Color(0xFFE39A74),
    track: Color(0xFF332C3B),
    elapsed: Color(0xFF5C526A),
    error: Color(0xFFF2B8B5),
  );

  /// Forest green on oat, with terracotta for the period.
  static const moss = EbbPalette(
    name: 'Moss',
    primary: Color(0xFF2F5A45),
    onPrimary: Color(0xFFFFFFFF),
    background: Color(0xFFF4F1E7),
    card: Color(0xFFFFFDF7),
    ink: Color(0xFF1E2A22),
    muted: Color(0xFF69756C),
    period: Color(0xFFB5553A),
    track: Color(0xFFE2DDCD),
    elapsed: Color(0xFFB3C2B7),
    error: Color(0xFFB3261E),
  );
  static const mossDark = EbbPalette(
    name: 'Moss',
    primary: Color(0xFF9CCDB2),
    onPrimary: Color(0xFF0E2A1D),
    background: Color(0xFF121814),
    card: Color(0xFF1B231E),
    ink: Color(0xFFE7EEE9),
    muted: Color(0xFF97A59B),
    period: Color(0xFFE08A6C),
    track: Color(0xFF2B3630),
    elapsed: Color(0xFF485F52),
    error: Color(0xFFF2B8B5),
  );
}

/// Colours the ring and other custom widgets need beyond [ColorScheme].
class EbbColors extends ThemeExtension<EbbColors> {
  const EbbColors({
    required this.period,
    required this.window,
    required this.track,
    required this.elapsed,
  });

  final Color period;

  /// When the next period is likely: a paler period colour, mixed against
  /// the card so it stays warm on dark backgrounds instead of turning muddy.
  final Color window;
  final Color track;
  final Color elapsed;

  static EbbColors of(BuildContext context) =>
      Theme.of(context).extension<EbbColors>()!;

  @override
  EbbColors copyWith({
    Color? period,
    Color? window,
    Color? track,
    Color? elapsed,
  }) => EbbColors(
    period: period ?? this.period,
    window: window ?? this.window,
    track: track ?? this.track,
    elapsed: elapsed ?? this.elapsed,
  );

  @override
  EbbColors lerp(EbbColors? other, double t) => other == null
      ? this
      : EbbColors(
          period: Color.lerp(period, other.period, t)!,
          window: Color.lerp(window, other.window, t)!,
          track: Color.lerp(track, other.track, t)!,
          elapsed: Color.lerp(elapsed, other.elapsed, t)!,
        );
}

class EbbTheme {
  /// The palette in use. Swapped by hand while choosing; there's no user
  /// setting for it.
  static const light = EbbPalette.tide;
  static const dark = EbbPalette.tideDark;

  static ThemeData lightTheme() => _build(light, Brightness.light);
  static ThemeData darkTheme() => _build(dark, Brightness.dark);

  static const _serif = 'Fraunces';
  static const _sans = 'Figtree';

  /// The bundled fonts are variable: Flutter needs the weight axis set
  /// explicitly, not just [FontWeight].
  static TextStyle _font(
    String family,
    double size,
    double weight, {
    double? height,
    double? spacing,
    Color? color,
  }) => TextStyle(
    fontFamily: family,
    fontSize: size,
    fontWeight: FontWeight.values[((weight / 100).round() - 1).clamp(0, 8)],
    fontVariations: [
      FontVariation('wght', weight),
      if (family == _serif) const FontVariation('SOFT', 100),
      if (family == _serif) FontVariation('opsz', size.clamp(9, 144)),
    ],
    height: height,
    letterSpacing: spacing,
    color: color,
  );

  static ThemeData _build(EbbPalette p, Brightness brightness) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: p.primary,
      onPrimary: p.onPrimary,
      primaryContainer: Color.alphaBlend(
        p.primary.withValues(alpha: 0.14),
        p.card,
      ),
      onPrimaryContainer: p.primary,
      // Clay means "period" and nothing else, so tonal buttons and other
      // secondary accents take a soft navy instead.
      secondary: p.primary,
      onSecondary: p.onPrimary,
      secondaryContainer: Color.alphaBlend(
        p.primary.withValues(alpha: 0.10),
        p.card,
      ),
      onSecondaryContainer: p.primary,
      error: p.error,
      onError: brightness == Brightness.light ? Colors.white : Colors.black,
      surface: p.background,
      onSurface: p.ink,
      onSurfaceVariant: p.muted,
      surfaceContainerLowest: p.card,
      surfaceContainerLow: p.card,
      surfaceContainer: p.card,
      surfaceContainerHigh: p.card,
      surfaceContainerHighest: p.track,
      outline: p.muted,
      outlineVariant: p.track,
    );

    final text = TextTheme(
      displayLarge: _font(_serif, 64, 560, height: 1.0, color: p.ink),
      displayMedium: _font(_serif, 48, 560, height: 1.05, color: p.ink),
      headlineMedium: _font(_serif, 30, 520, height: 1.15, color: p.ink),
      headlineSmall: _font(_serif, 25, 520, height: 1.2, color: p.ink),
      titleLarge: _font(_serif, 22, 560, height: 1.25, color: p.ink),
      titleMedium: _font(_sans, 16.5, 620, height: 1.3, color: p.ink),
      titleSmall: _font(
        _sans,
        14,
        650,
        height: 1.3,
        spacing: 0.2,
        color: p.ink,
      ),
      bodyLarge: _font(_sans, 16.5, 420, height: 1.45, color: p.ink),
      bodyMedium: _font(_sans, 15, 420, height: 1.45, color: p.ink),
      bodySmall: _font(_sans, 13, 440, height: 1.4, color: p.muted),
      labelLarge: _font(_sans, 15.5, 620, spacing: 0.1),
      labelMedium: _font(_sans, 13, 600, spacing: 0.2, color: p.muted),
      labelSmall: _font(_sans, 11.5, 650, spacing: 0.6, color: p.muted),
    );

    final rounded = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      textTheme: text,
      fontFamily: _sans,
      scaffoldBackgroundColor: p.background,
      extensions: [
        EbbColors(
          period: p.period,
          window: Color.alphaBlend(
            p.period.withValues(
              alpha: brightness == Brightness.light ? 0.38 : 0.62,
            ),
            p.card,
          ),
          track: p.track,
          elapsed: p.elapsed,
        ),
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: p.background,
        foregroundColor: p.ink,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        titleTextStyle: _font(_serif, 24, 560, color: p.ink),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: p.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: p.track),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          // Tall, but not forced full-width: an infinite minimum breaks any
          // button in a Row or dialog. Buttons in a ListView still stretch.
          minimumSize: const Size(64, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: p.primary,
          textStyle: text.labelLarge,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        titleTextStyle: text.titleLarge,
        contentTextStyle: text.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.card,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: p.ink,
        contentTextStyle: _font(_sans, 14.5, 500, color: p.background),
        shape: rounded,
      ),
      dividerTheme: DividerThemeData(color: p.track, thickness: 1, space: 1),
      listTileTheme: ListTileThemeData(
        iconColor: p.muted,
        titleTextStyle: text.bodyLarge,
        subtitleTextStyle: text.bodySmall,
      ),
      switchTheme: SwitchThemeData(
        trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: p.primary,
        foregroundColor: p.onPrimary,
        elevation: 1,
        shape: rounded,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: p.primary,
        linearTrackColor: p.track,
      ),
    );
  }
}
