import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/animated_widgets.dart';

class UnitShimmer extends StatelessWidget {
  const UnitShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: const Row(
        children: [
          ShimmerContainer(width: 40, height: 40, radius: 12),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerContainer(width: 80, height: 10),
                SizedBox(height: 6),
                ShimmerContainer(width: 140, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
