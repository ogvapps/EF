import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../core/theme/app_theme.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(leaderboardProvider);

    return Scaffold(
      backgroundColor: AppTheme.deepNavy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Clasificación', style: TextStyle(color: Colors.white)),
      ),
      body: leaderboardAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text('Aún no hay datos', style: TextStyle(color: Colors.white54)));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final isEven = index.isEven;

              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isEven
                    ? Colors.white.withValues(alpha: 0.05)
                    : AppTheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Position
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: index < 3
                          ? [AppTheme.gold, AppTheme.silver, AppTheme.bronze][index]
                              .withValues(alpha: 0.2)
                          : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: index < 3
                              ? [AppTheme.gold, AppTheme.silver, AppTheme.bronze][index]
                              : Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      index == 0 ? Icons.emoji_events : Icons.person,
                      color: index == 0 ? AppTheme.gold : Colors.white54,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        user.displayName,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                    // XP
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.flash_on, size: 14, color: AppTheme.primary),
                          const SizedBox(width: 4),
                          Text(
                            '${user.xp}',
                            style: const TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Level
                    Text(
                      'Nv. ${user.level}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e', style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}
