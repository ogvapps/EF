import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/unit_map_provider.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../core/services/connectivity_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/utils/responsive.dart';

import '../widgets/home_header.dart';
import '../widgets/streak_card.dart';
import '../widgets/daily_card.dart';
import '../widgets/unit_card.dart';
import '../widgets/home_shimmer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final unitsAsync = ref.watch(unitMapProvider(user?.course ?? '1_eso'));
    final userAsync = ref.watch(currentUserProvider);
    final connectivity = ref.watch(connectivityStatusProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeHeader(user, userAsync, connectivity, context, ref),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  StreakCard(streak: user?.streak ?? 0),
                  const SizedBox(width: 12),
                  DailyCard(onTap: () => context.push('/progress')),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 4, height: 24,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: AppTheme.primaryGradient, begin: Alignment.topCenter, end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('Tus unidades', style: AppTheme.heading),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => ref.invalidate(unitMapProvider(user?.course ?? '1_eso')),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.refresh_rounded, size: 18, color: Colors.white.withValues(alpha: 0.5)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          unitsAsync.when(
            data: (units) {
              if (units.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Column(
                        children: [
                          Icon(Icons.school_outlined, size: 48, color: Colors.white.withValues(alpha: 0.2)),
                          const SizedBox(height: 12),
                          Text('No hay unidades disponibles',
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                        ],
                      ),
                    ),
                  ),
                );
              }
              final cols = Responsive.gridColumns(context);
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: cols > 1
                    ? SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: cols,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.4,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (_, i) {
                            final unit = units[i];
                            return UnitCard(
                              title: unit.title,
                              order: unit.order,
                              unitId: unit.unitId,
                              colorHex: unit.colorHex,
                              totalXP: unit.totalXP,
                              isCompleted: user?.completedUnits.contains(unit.unitId) ?? false,
                              index: i,
                              onTap: () => context.push('/home/unit/${unit.unitId}'),
                            );
                          },
                          childCount: units.length,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, i) {
                            final unit = units[i];
                            return UnitCard(
                              title: unit.title,
                              order: unit.order,
                              unitId: unit.unitId,
                              colorHex: unit.colorHex,
                              totalXP: unit.totalXP,
                              isCompleted: user?.completedUnits.contains(unit.unitId) ?? false,
                              index: i,
                              onTap: () => context.push('/home/unit/${unit.unitId}'),
                            );
                          },
                          childCount: units.length,
                        ),
                      ),
              );
            },
            loading: () => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: List.generate(4, (i) => Padding(
                    padding: EdgeInsets.only(bottom: i < 3 ? 12 : 0),
                    child: const UnitShimmer(),
                  )),
                ),
              ),
            ),
            error: (e, _) => SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Column(
                    children: [
                      Icon(Icons.cloud_off, size: 48, color: Colors.white.withValues(alpha: 0.3)),
                      const SizedBox(height: 12),
                      const Text('Error al cargar unidades', style: TextStyle(color: Colors.white54)),
                      const SizedBox(height: 16),
                      TextButton.icon(
                        onPressed: () => ref.invalidate(unitMapProvider(user?.course ?? '1_eso')),
                        icon: const Icon(Icons.refresh, color: AppTheme.primary),
                        label: const Text('Reintentar', style: TextStyle(color: AppTheme.primary)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}
