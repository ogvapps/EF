import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class UnitCard extends StatelessWidget {
  final String title;
  final int order;
  final String unitId;
  final String colorHex;
  final int totalXP;
  final bool isCompleted;
  final int index;
  final VoidCallback onTap;

  const UnitCard({
    super.key,
    required this.title,
    required this.order,
    required this.unitId,
    required this.colorHex,
    required this.totalXP,
    required this.isCompleted,
    required this.index,
    required this.onTap,
  });

  Color get _unitColor {
    try {
      return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return AppTheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _unitColor;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + index * 80),
      curve: Curves.easeOutCubic,
      builder: (_, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: child,
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.08), color.withValues(alpha: 0.02)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withValues(alpha: 0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 22)
                      : Text('$order',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('UD$order',
                        style: TextStyle(fontSize: 11, color: color.withValues(alpha: 0.6), fontWeight: FontWeight.w600, letterSpacing: 1)),
                    const SizedBox(height: 2),
                    Text(title,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bolt, size: 12, color: Colors.white70),
                    const SizedBox(width: 2),
                    Text('$totalXP',
                        style: TextStyle(fontSize: 12, color: color.withValues(alpha: 0.8), fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right,
                  color: Colors.white.withValues(alpha: 0.4), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
