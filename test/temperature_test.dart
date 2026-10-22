import 'package:ebb/domain/temperature.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const c = TemperatureUnit.celsius, f = TemperatureUnit.fahrenheit;

  test('reads what was typed, with a point or a comma', () {
    expect(c.parse('36.45'), 36.45);
    expect(c.parse(' 36,45 '), 36.45);
    expect(c.parse('37'), 37.0);
    expect(f.parse('98.6'), 37.0);
  });

  test('refuses anything that isn’t a body temperature', () {
    for (final text in ['', 'warm', '3.6.5', '33.9', '43.1', '9.86']) {
      expect(c.parse(text), isNull, reason: text);
    }
    expect(f.parse('36.5'), isNull);
  });

  test('a reading typed in °F to two decimals comes back as typed', () {
    for (var hundredths = 9300; hundredths <= 10900; hundredths++) {
      final typed = (hundredths / 100).toStringAsFixed(2);
      final stored = f.parse(typed);
      if (stored == null) continue;
      expect(f.format(stored), typed);
    }
  });

  test('°C to two decimals comes back as typed too', () {
    for (var hundredths = 3400; hundredths <= 4300; hundredths++) {
      final typed = (hundredths / 100).toStringAsFixed(2);
      expect(c.format(c.parse(typed)!), typed);
    }
  });

  test('defaults to °F only where it’s the everyday unit', () {
    expect(TemperatureUnit.forCountry('US'), f);
    expect(TemperatureUnit.forCountry('us'), f);
    expect(TemperatureUnit.forCountry('DE'), c);
    expect(TemperatureUnit.forCountry('GB'), c);
    expect(TemperatureUnit.forCountry(null), c);
  });

  group('chart axis', () {
    test('rounds out to gridlines with room above and below', () {
      final (low, high) = temperatureAxis([36.32, 36.81], c);
      expect(low, closeTo(36.2, 1e-9));
      expect(high, closeTo(37.0, 1e-9));
    });

    test('never squeezes a day-to-day wobble into the whole height', () {
      final (low, high) = temperatureAxis([36.5, 36.52], c);
      expect(high - low, greaterThanOrEqualTo(0.6 - 1e-9));
      expect(low, lessThan(36.5));
      expect(high, greaterThan(36.52));
    });

    test('is in the unit shown', () {
      final (low, high) = temperatureAxis([37.0], f);
      expect(low, lessThan(98.6));
      expect(high, greaterThan(98.6));
      expect(high - low, greaterThanOrEqualTo(1.2 - 1e-9));
    });

    test('has a sensible span with nothing to show', () {
      final (low, high) = temperatureAxis(const [], c);
      expect(low, lessThan(36.5));
      expect(high, greaterThan(36.5));
    });
  });
}
