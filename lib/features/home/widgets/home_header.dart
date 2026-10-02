import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/connectivity_service.dart';

class HomeHeader extends SliverAppBar {
  HomeHeader(
    dynamic user,
    dynamic userAsync,
    dynamic connectivity,
    BuildContext context,
    WidgetRef ref, {
    super.key,
  }) : super(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: AppTheme.deepNavy,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A1040), Color(0xFF0B0E1A)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -40,
                    right: -20,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primary.withValues(alpha: 0.12),
                            AppTheme.primary.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -30,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.secondary.withValues(alpha: 0.08),
                            AppTheme.secondary.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          connectivity.when(
                            data: (status) {
                              if (status == ConnectivityStatus.offline) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade900.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.wifi_off, color: Colors.white, size: 16),
                                      SizedBox(width: 6),
                                      Text('Sin conexión',
                                          style: TextStyle(color: Colors.white, fontSize: 12)),
                                    ],
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                            loading: () => const SizedBox.shrink(),
                            error: (_, __) => const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => context.push('/more/perfil'),
                                child: _AvatarBadge(user),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hola, ${user?.displayName ?? 'Explorador'}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    _XpBar(user?.xp ?? 0, user?.level ?? 1),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              _CoinsBadge(user?.coins ?? 0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}

class _AvatarBadge extends StatelessWidget {
  final dynamic user;
  const _AvatarBadge(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppTheme.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.neonShadow(AppTheme.primary, blur: 12),
      ),
      child: Center(
        child: Text(
          user?.displayName.isNotEmpty == true
              ? user!.displayName[0].toUpperCase()
              : '?',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
    );
  }
}

class _XpBar extends StatelessWidget {
  final int xp;
  final int level;
  const _XpBar(this.xp, this.level);

  @override
  Widget build(BuildContext context) {
    final xpInLevel = xp % 500;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            height: 6,
            child: LinearProgressIndicator(
              value: xpInLevel / 500,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accent),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          'Nv.$level · $xpInLevel/500 XP',
          style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.45)),
        ),
      ],
    );
  }
}

class _CoinsBadge extends StatelessWidget {
  final int coins;
  const _CoinsBadge(this.coins);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.gold.withValues(alpha: 0.15), AppTheme.gold.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.gold.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🪙', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text('$coins', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.gold)),
        ],
      ),
    );
  }
}
