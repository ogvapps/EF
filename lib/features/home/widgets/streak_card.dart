import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {
  final int streak;
  const StreakCard({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            Text(streak > 0 ? '🔥' : '⏳', style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$streak días',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                Text('Racha',
                    style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.45))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
