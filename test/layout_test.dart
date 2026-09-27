import 'package:ebb/ui/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Captures what the layout helpers decide at a given screen width.
Future<(EdgeInsets, bool)> measure(WidgetTester tester, double width) async {
  late EdgeInsets padding;
  late bool wide;
  await tester.pumpWidget(MediaQuery(
    data: MediaQueryData(size: Size(width, 900)),
    child: Builder(builder: (context) {
      padding = readablePadding(context, base: const EdgeInsets.all(16));
      wide = isWide(context);
      return const SizedBox();
    }),
  ));
  return (padding, wide);
}

void main() {
  testWidgets('phones are left exactly as they were', (tester) async {
    for (final width in [360.0, 412.0, 600.0]) {
      final (padding, wide) = await measure(tester, width);
      expect(padding, const EdgeInsets.all(16), reason: 'width $width');
      expect(wide, isFalse);
    }
  });

  testWidgets('wider screens centre a readable column', (tester) async {
    final (padding, wide) = await measure(tester, 1280);
    // (1280 - 680) / 2 = 300 each side, on top of the list's own 16.
    expect(padding.left, 316);
    expect(padding.right, 316);
    expect(padding.top, 16);
    expect(wide, isTrue);
  });

  testWidgets('tablet portrait gets the column but not two panes',
      (tester) async {
    final (padding, wide) = await measure(tester, 800);
    expect(padding.left, 76);
    expect(wide, isFalse);
  });
}
