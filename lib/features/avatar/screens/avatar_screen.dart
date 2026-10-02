import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/avatar_providers.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../core/enums/avatar_tier.dart';

class AvatarScreen extends ConsumerWidget {
  const AvatarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((s) => s.user));
    final tier = ref.watch(avatarTierProvider);
    final nextXP = ref.watch(nextLevelXPProvider);
    final inventoryAsync = ref.watch(inventoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Avatar circle
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _tierColor(tier).withValues(alpha: 0.3),
                      _tierColor(tier).withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: _tierColor(tier).withValues(alpha: 0.5),
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    user?.displayName.isNotEmpty == true
                        ? user!.displayName[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: _tierColor(tier),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Tier badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: _tierColor(tier).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tier.displayName,
                  style: TextStyle(
                    color: _tierColor(tier),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user?.displayName ?? 'Explorador',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Nivel ${user?.level ?? 1} · ${user?.xp ?? 0} XP',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              ),
              const SizedBox(height: 16),
              // XP to next tier
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 1 - (nextXP / 500).clamp(0, 1),
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(_tierColor(tier)),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$nextXP XP para siguiente nivel',
                style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.4)),
              ),

              const SizedBox(height: 24),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: _ActionCard(
                      icon: '👔',
                      label: 'Personalizar',
                      onTap: () => context.push('/avatar/customize'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionCard(
                      icon: '🛒',
                      label: 'Tienda',
                      onTap: () => context.push('/avatar/shop'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionCard(
                      icon: '📦',
                      label: 'Inventario',
                      onTap: () => context.push('/avatar/inventory'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Tier progress
              const Text(
                'Rangos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              ...AvatarTier.values.map((t) {
                final unlocked = t.index <= tier.index;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: unlocked
                        ? _tierColor(t).withValues(alpha: 0.1)
                        : Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: unlocked
                          ? _tierColor(t).withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        unlocked ? Icons.check_circle : Icons.lock,
                        color: unlocked ? _tierColor(t) : Colors.white24,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          t.displayName,
                          style: TextStyle(
                            color: unlocked ? Colors.white : Colors.white38,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (unlocked)
                        Text(
                          '${_tierLevel(t)}',
                          style: TextStyle(
                            color: _tierColor(t).withValues(alpha: 0.7),
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 24),

              // Inventory count
              inventoryAsync.when(
                data: (items) => _StatCard(
                  icon: '🎒',
                  label: 'Objetos desbloqueados',
                  value: '${items.length}',
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _tierColor(AvatarTier tier) {
    switch (tier) {
      case AvatarTier.rookie:
        return Colors.grey;
      case AvatarTier.amateur:
        return const Color(0xFF4CAF50);
      case AvatarTier.competidor:
        return const Color(0xFF2196F3);
      case AvatarTier.capitan:
        return const Color(0xFFFF9800);
      case AvatarTier.elite:
        return const Color(0xFFFFD700);
    }
  }

  int _tierLevel(AvatarTier tier) {
    switch (tier) {
      case AvatarTier.rookie:
        return 0;
      case AvatarTier.amateur:
        return 10;
      case AvatarTier.competidor:
        return 25;
      case AvatarTier.capitan:
        return 45;
      case AvatarTier.elite:
        return 70;
    }
  }
}

class _ActionCard extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
