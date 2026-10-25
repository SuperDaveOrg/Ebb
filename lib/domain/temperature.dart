import 'dart:math' as math;

/// Body temperatures, kept in degrees Celsius and shown in whichever unit she
/// reads her thermometer in.
///
/// Only recorded and drawn, never interpreted: Ebb doesn't look for a rise
/// or work out fertile days from it. See docs/roadmap.md.

/// The lowest and highest temperature Ebb accepts, in °C. Wide enough for a
/// fever or a cold room, narrow enough to catch a slip of the finger.
const minTemperature = 34.0, maxTemperature = 43.0;

bool isTemperature(double? c) =>
    c != null && c.isFinite && c >= minTemperature && c <= maxTemperature;

/// Stored to a thousandth of a degree: fine enough that a reading typed in °F
/// to two decimals comes back exactly as typed.
double roundTemperature(double c) => (c * 1000).roundToDouble() / 1000;

enum TemperatureUnit {
  celsius('°C'),
  fahrenheit('°F');

  const TemperatureUnit(this.symbol);
  final String symbol;

  static TemperatureUnit fromName(String? name) => TemperatureUnit.values
      .firstWhere((u) => u.name == name, orElse: () => TemperatureUnit.celsius);

  /// The unit people in [countryCode] usually read a thermometer in.
  static TemperatureUnit forCountry(String? countryCode) =>
      _fahrenheitCountries.contains(countryCode?.toUpperCase())
      ? TemperatureUnit.fahrenheit
      : TemperatureUnit.celsius;

  /// Where Fahrenheit is the everyday unit.
  static const _fahrenheitCountries = {
    'US',
    'LR',
    'BS',
    'BZ',
    'KY',
    'PW',
    'FM',
    'MH',
  };

  double fromCelsius(double c) =>
      this == TemperatureUnit.celsius ? c : c * 9 / 5 + 32;

  double toCelsius(double v) =>
      this == TemperatureUnit.celsius ? v : (v - 32) * 5 / 9;

  /// The size of a gridline step on the chart, in this unit.
  double get chartStep => this == TemperatureUnit.celsius ? 0.1 : 0.2;

  /// [c] in this unit, to two decimals: "36.45".
  String format(double c) => fromCelsius(c).toStringAsFixed(2);

  /// [c] with its unit: "36.45 °C".
  String formatWithUnit(double c) => '${format(c)} $symbol';

  /// What she typed, in this unit, as °C; null if it isn't a number or isn't
  /// a body temperature. A comma works as the decimal point too.
  double? parse(String text) {
    final v = double.tryParse(text.trim().replaceAll(',', '.'));
    if (v == null) return null;
    final c = roundTemperature(toCelsius(v));
    return isTemperature(c) ? c : null;
  }
}

/// The span the chart's axis covers, in [unit]: the readings with a little
/// room above and below, rounded out to whole gridline steps, and never so
/// tight that ordinary day-to-day wobble fills the whole height.
(double low, double high) temperatureAxis(
  Iterable<double> celsius,
  TemperatureUnit unit,
) {
  final values = celsius.map(unit.fromCelsius).toList();
  final step = unit.chartStep;
  if (values.isEmpty) {
    final mid = unit.fromCelsius(36.5);
    return (mid - 3 * step, mid + 3 * step);
  }
  var low = (values.reduce(math.min) / step).floor() * step - step;
  var high = (values.reduce(math.max) / step).ceil() * step + step;
  const minSteps = 6;
  final missing = minSteps - ((high - low) / step).round();
  if (missing > 0) {
    low -= (missing ~/ 2) * step;
    high += (missing - missing ~/ 2) * step;
  }
  return (low, high);
}
