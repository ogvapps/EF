import 'dart:io';
import 'package:image/image.dart';

void main() {
  final size = 1024;
  final cx = size ~/ 2;
  final cy = size ~/ 2;

  final image = Image(width: size, height: size);

  // Background gradient
  for (int y = 0; y < size; y++) {
    final t = y / size;
    final r = (11 + (26 - 11) * t).toInt();
    final g = (14 + (16 - 14) * t).toInt();
    final b = (26 + (64 - 26) * t).toInt();
    for (int x = 0; x < size; x++) {
      image.setPixelRgba(x, y, r, g, b, 255);
    }
  }

  // Shield
  final sw = 480, sh = 520;
  for (int y = cy - sh ~/ 2; y <= cy + sh ~/ 2; y++) {
    for (int x = cx - sw ~/ 2; x <= cx + sw ~/ 2; x++) {
      final dx = (x - cx).abs().toDouble();
      final dy = (y - cy).abs().toDouble();
      final hw = sw / 2, hh = sh / 2;
      final wy = hw * (1 - dy / hh * 0.35);
      if (dx <= wy && dy <= hh) {
        bool inside = true;
        final cr = 48.0;
        if (dx > wy - cr && dy > hh - cr) {
          final ddx = dx - (wy - cr), ddy = dy - (hh - cr);
          if (ddx * ddx + ddy * ddy > cr * cr) inside = false;
        }
        if (dx > wy - cr && dy < cr && y < cy) {
          final ddx = dx - (wy - cr), ddy = cr - dy;
          if (ddx * ddx + ddy * ddy > cr * cr) inside = false;
        }
        if (inside) {
          final glow = 0.6 + 0.4 * (1 - dx / wy);
          image.setPixelRgba(x, y, (80 * glow).toInt(), (55 * glow).toInt(), (160 * glow).toInt(), 255);
        } else if (dx <= wy + 6 && dy <= hh && dx >= wy - 4) {
          image.setPixelRgba(x, y, 255, 215, 0, 200);
        }
      }
    }
  }

  // Star
  for (int y = cy - 170; y <= cy - 150; y++) {
    for (int x = cx - 14; x <= cx + 14; x++) {
      final d = (x - cx).abs() + (y - (cy - 160)).abs() * 0.7;
      if (d < 14) {
        final i = (1 - d / 14);
        image.setPixelRgba(x, y, (180 + 75 * i).toInt(), (180 + 75 * i).toInt(), 40, (255 * i).toInt());
      }
    }
  }

  // EF letters
  void hLine(int x, int y, int w, int s, int r, int g, int b, int a) {
    for (int i = y; i <= y + s; i++)
      for (int j = x; j <= x + w; j++)
        if (j >= 0 && j < size && i >= 0 && i < size) image.setPixelRgba(j, i, r, g, b, a);
  }
  void vLine(int x, int y, int h, int s, int r, int g, int b, int a) {
    for (int i = y; i <= y + h; i++)
      for (int j = x; j <= x + s; j++)
        if (j >= 0 && j < size && i >= 0 && i < size) image.setPixelRgba(j, i, r, g, b, a);
  }

  void letterE(int x, int y, int w, int h, int s) {
    vLine(x, y, h, s, 255, 255, 255, 230);
    hLine(x, y, w, s, 255, 255, 255, 230);
    hLine(x, y + h ~/ 2 - s ~/ 2, w ~/ 2 + 10, s, 255, 255, 255, 230);
    hLine(x, y + h - s, w, s, 255, 255, 255, 230);
  }

  void letterF(int x, int y, int w, int h, int s) {
    vLine(x, y, h, s, 255, 255, 255, 230);
    hLine(x, y, w, s, 255, 255, 255, 230);
    hLine(x, y + h ~/ 2 - s ~/ 2, w ~/ 2 + 10, s, 255, 255, 255, 230);
  }

  letterE(cx - 72, cy + 20, 48, 110, 16);
  letterF(cx + 16, cy + 20, 48, 110, 16);

  final png = encodePng(image);
  File(r'D:\Aplicaciones\EF\assets\icons\icon_1024.png').writeAsBytesSync(png);
  print('Icon generated! ${png.length} bytes');
}
