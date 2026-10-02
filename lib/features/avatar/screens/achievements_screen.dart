import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/achievement_model.dart';
import '../../../core/enums/achievement_rarity.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../core/providers/core_providers.dart';

final userAchievementsProvider = FutureProvider<List<UserAchievementDisplay>>((ref) {
  final uid = ref.watch(currentUidProvider);
  if (uid == null) return [];
  return ref.read(achievementRepositoryProvider).getUserAchievementsWithDetails(uid).then((data) {
    final achievements = data['achievements'] as List<AchievementModel>;
    final unlockedIds = data['unlockedIds'] as Set<String>;
    final progressMap = data['progressMap'] as Map<String, int>;
    return achievements.map((a) => UserAchievementDisplay(
      achievement: a,
      isUnlocked: unlockedIds.contains(a.achievementId),
      progress: progressMap[a.achievementId] ?? 0,
    )).toList();
  });
});

// Modelo de visualización (matching con AchievementModel)
class UserAchievementDisplay {
  final AchievementModel achievement;
  final bool isUnlocked;
  final int progress;

  const UserAchievementDisplay({
    required this.achievement,
    required this.isUnlocked,
    required this.progress,
  });
}

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsAsync = ref.watch(userAchievementsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Logros', style: TextStyle(color: Colors.white)),
      ),
      body: achievementsAsync.when(
        data: (achievements) {
          if (achievements.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🏅', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 16),
                  const Text('Aún no tienes logros',
                      style: TextStyle(color: Colors.white54)),
                  const SizedBox(height: 8),
                  Text('Completa lecciones y retos para ganarlos',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.3))),
                ],
              ),
            );
          }

          final unlocked = achievements.where((a) => a.isUnlocked).toList();
          final locked = achievements.where((a) => !a.isUnlocked).toList();

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (unlocked.isNotEmpty) ...[
                const Text('Desbloqueados',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 12),
                ...unlocked.map((a) => _AchievementCard(display: a)),
                const SizedBox(height: 24),
              ],
              if (locked.isNotEmpty) ...[
                const Text('Bloqueados',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 12),
                ...locked.map((a) => _AchievementCard(display: a)),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e', style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final UserAchievementDisplay display;

  const _AchievementCard({required this.display});

  Color _rarityColor(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.comun:
        return Colors.grey;
      case AchievementRarity.raro:
        return const Color(0xFF4CAF50);
      case AchievementRarity.epico:
        return const Color(0xFFFF9800);
      case AchievementRarity.legendario:
        return const Color(0xFFFFD700);
    }
  }

  @override
  Widget build(BuildContext context) {
    final a = display.achievement;
    final color = _rarityColor(a.rarity);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: display.isUnlocked
            ? color.withValues(alpha: 0.08)
            : Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: display.isUnlocked
              ? color.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Text(a.iconURL.isNotEmpty ? a.iconURL : '🏆',
              style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a.title,
                  style: TextStyle(
                    color: display.isUnlocked ? Colors.white : Colors.white38,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  a.description,
                  style: TextStyle(
                    color: display.isUnlocked
                        ? Colors.white.withValues(alpha: 0.5)
                        : Colors.white.withValues(alpha: 0.2),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (display.isUnlocked)
            const Text('✅', style: TextStyle(fontSize: 18))
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${display.progress}%',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 11,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
