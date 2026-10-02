import 'package:flutter/material.dart';

class Responsive {
  static double _screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double _screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isMobile(BuildContext context) => _screenWidth(context) < 600;
  static bool isTablet(BuildContext context) =>
      _screenWidth(context) >= 600 && _screenWidth(context) < 1200;
  static bool isDesktop(BuildContext context) => _screenWidth(context) >= 1200;

  static double width(BuildContext context, double fraction) =>
      _screenWidth(context) * fraction;
  static double height(BuildContext context, double fraction) =>
      _screenHeight(context) * fraction;

  static EdgeInsets padding(BuildContext context) {
    final w = _screenWidth(context);
    if (w >= 1200) return const EdgeInsets.symmetric(horizontal: 320, vertical: 24);
    if (w >= 600) return const EdgeInsets.symmetric(horizontal: 80, vertical: 24);
    return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  }

  static double cardWidth(BuildContext context) {
    final w = _screenWidth(context);
    if (w >= 1200) return 360;
    if (w >= 600) return w * 0.45;
    return w - 40;
  }

  static int gridColumns(BuildContext context) {
    final w = _screenWidth(context);
    if (w >= 1200) return 4;
    if (w >= 900) return 3;
    if (w >= 600) return 2;
    return 1;
  }
}
