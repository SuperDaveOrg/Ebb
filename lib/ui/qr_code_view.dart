import 'package:flutter/material.dart';
import 'package:qr/qr.dart';

/// A QR code, always dark on light with a quiet zone, whatever the app theme:
/// scanners expect that contrast and a dark-mode inversion would slow them.
class QrCodeView extends StatelessWidget {
  QrCodeView({super.key, required String data})
    : _image = QrImage(
        QrCode(
          payload: QrPayload.fromString(data),
          errorCorrectLevel: QrErrorCorrectLevel.medium,
        ),
      );

  final QrImage _image;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ColoredBox(
        color: Colors.white,
        child: CustomPaint(painter: _QrPainter(_image)),
      ),
    );
  }
}

class _QrPainter extends CustomPainter {
  _QrPainter(this.image);

  final QrImage image;

  /// The standard asks for four modules of blank margin.
  static const _quiet = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final n = image.moduleCount;
    final module = size.shortestSide / (n + _quiet * 2);
    final paint = Paint()
      ..color = Colors.black
      ..isAntiAlias = false;
    final path = Path();
    for (var r = 0; r < n; r++) {
      for (var c = 0; c < n; c++) {
        if (!image.isDark(r, c)) continue;
        // Slight overlap so no hairline gaps appear between modules.
        path.addRect(
          Rect.fromLTWH(
            (c + _quiet) * module,
            (r + _quiet) * module,
            module + 0.5,
            module + 0.5,
          ),
        );
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_QrPainter old) => old.image != image;
}
