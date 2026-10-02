import 'package:flutter/services.dart';

class HapticService {
  HapticService._();

  static void tap() => HapticFeedback.lightImpact();
  static void medium() => HapticFeedback.mediumImpact();
  static void heavy() => HapticFeedback.heavyImpact();
  static void select() => HapticFeedback.selectionClick();
  static void success() => HapticFeedback.heavyImpact();
  static void error() => HapticFeedback.heavyImpact();
}
