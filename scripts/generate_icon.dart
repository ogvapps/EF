import 'dart:io';
import 'package:image/image.dart';

void main() {
  final size = 1024;
  final image = ImageRgba8(size, size);

  // Background gradient
  for (int y = 0; y < size; y++) {
    final t = y / size;
    final r = (11 + (26 - 11) * t).round();
    final g = (14 + (16 - 14) * t).round();
    final b = (26 + (64 - 26) * t).round();
    for (int x = 0; x < size; x++) {
      image.setPixelRgba(x, y, r, g, b, 255);
    }
  }

  final cx = size ~/ 2;
  final cy = size ~/ 2;
  final shieldW = 480;
  final shieldH = 520;

  // Shield body
  for (int y = cy - shieldH ~/ 2; y <= cy + shieldH ~/ 2; y++) {
    for (int x = cx - shieldW ~/ 2; x <= cx + shieldW ~/ 2; x++) {
      final dx = (x - cx).abs().toDouble();
      final dy = (y - cy).abs().toDouble();
      final halfW = shieldW / 2;
      final halfH = shieldH / 2;
      final yNorm = dy / halfH;
      final widthAtY = halfW * (1 - yNorm * 0.35);
      if (dx <= widthAtY && dy <= halfH) {
        final cornerR = 48.0;
        bool inside = true;
        if (dx > widthAtY - cornerR && dy > halfH - cornerR) {
          final ddx = dx - (widthAtY - cornerR);
          final ddy = dy - (halfH - cornerR);
          if (ddx * ddx + ddy * ddy > cornerR * cornerR) inside = false;
        }
        if (dx > widthAtY - cornerR && dy < cornerR && y < cy) {
          final ddx = dx - (widthAtY - cornerR);
          final ddy = cornerR - dy;
          if (ddx * ddx + ddy * ddy > cornerR * cornerR) inside = false;
        }
        if (inside) {
          final dist = dx / widthAtY;
          final glow = 0.6 + 0.4 * (1 - dist);
          final cR = (80 * glow).round().clamp(0, 255);
          final cG = (55 * glow).round().clamp(0, 255);
          final cB = (160 * glow).round().clamp(0, 255);
          image.setPixelRgba(x, y, cR, cG, cB, 255);
        }
      }
    }
  }

  // Shield border
  for (int y = cy - shieldH ~/ 2; y <= cy + shieldH ~/ 2; y++) {
    for (int x = cx - shieldW ~/ 2; x <= cx + shieldW ~/ 2; x++) {
      final dx = (x - cx).abs().toDouble();
      final dy = (y - cy).abs().toDouble();
      final halfW = shieldW / 2;
      final halfH = shieldH / 2;
      final yNorm = dy / halfH;
      final widthAtY = halfW * (1 - yNorm * 0.35);
      final borderW = 6.0;
      if (dy <= halfH && dx <= widthAtY && dx >= widthAtY - borderW) {
        image.setPixelRgba(x, y, 255, 215, 0, 200);
      }
    }
  }

  // Star at top
  final starCx = cx;
  final starCy = cy - 160;
  final starR = 56;
  for (int y = starCy - starR; y <= starCy + starR; y++) {
    for (int x = starCx - starR; x <= starCx + starR; x++) {
      final dx = (x - starCx).toDouble();
      final dy = (y - starCy).toDouble();
      final dist = dx * dx + dy * dy;
      if (dist < starR * starR * 0.25) {
        final intensity = (1 - dist / (starR * starR * 0.25));
        final c = (180 + 75 * intensity).round().clamp(0, 255);
        image.setPixelRgba(x, y, c, c, 40, (255 * intensity).round());
      }
    }
  }

  // Draw "EF" letters
  void fillRect(int x1, int y1, int x2, int y2, int r, int g, int b, int a) {
    for (int y = y1; y <= y2; y++) {
      for (int x = x1; x <= x2; x++) {
        image.setPixelRgba(x, y, r, g, b, a);
      }
    }
  }

  void drawHLine(int x1, int y, int w, int s, int r, int g, int b, int a) {
    fillRect(x1, y, x1 + w, y + s, r, g, b, a);
  }

  void drawVLine(int x, int y1, int h, int s, int r, int g, int b, int a) {
    fillRect(x, y1, x + s, y1 + h, r, g, b, a);
  }

  void drawLetterE(int x, int y, int w, int h, int s) {
    drawVLine(x, y, h, s, 255, 255, 255, 230);
    drawHLine(x, y, w, s, 255, 255, 255, 230);
    drawHLine(x, y + h ~/ 2 - s ~/ 2, w ~/ 2 + 10, s, 255, 255, 255, 230);
    drawHLine(x, y + h - s, w, s, 255, 255, 255, 230);
  }

  void drawLetterF(int x, int y, int w, int h, int s) {
    drawVLine(x, y, h, s, 255, 255, 255, 230);
    drawHLine(x, y, w, s, 255, 255, 255, 230);
    drawHLine(x, y + h ~/ 2 - s ~/ 2, w ~/ 2 + 10, s, 255, 255, 255, 230);
  }

  final letterH = 110;
  final letterW = 48;
  final stroke = 16;
  final letterY = cy + 20;

  drawLetterE(cx - 72, letterY, letterW, letterH, stroke);
  drawLetterF(cx + 16, letterY, letterW, letterH, stroke);

  // Save as PNG
  final png = encodePng(image);

  final outputDir = Directory('assets/icons');
  if (!outputDir.existsSync()) outputDir.createSync(recursive: true);
  File('assets/icons/icon_1024.png').writeAsBytesSync(png);
  print('Icon generated: assets/icons/icon_1024.png (${png.length} bytes)');
}
