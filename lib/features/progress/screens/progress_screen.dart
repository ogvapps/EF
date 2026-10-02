import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../auth/providers/auth_providers.dart';
import '../providers/progress_providers.dart';
import '../../../core/enums/attribute_type.dart';
import '../../../core/theme/app_theme.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((s) => s.user));

    if (user == null) {
      return const Scaffold(
        backgroundColor: AppTheme.deepNavy,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final attributes = user.attributes;
    final completionAsync = ref.watch(courseCompletionProvider(user.course));
    final weeklyAsync = ref.watch(weeklyXPProvider);
    final starsAsync = ref.watch(starsDistributionProvider);

    return Scaffold(
      backgroundColor: AppTheme.deepNavy,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tu progreso',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // ── Stats grid ──
              Row(
                children: [
                  Expanded(child: _StatCard(label: 'Nivel', value: '${user.level}', icon: '⭐')),
                  const SizedBox(width: 12),
                  Expanded(child: _StatCard(label: 'XP Total', value: '${user.xp}', icon: '⚡')),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _StatCard(label: 'Racha', value: '${user.streak} días', icon: '🔥')),
                  const SizedBox(width: 12),
                  Expanded(child: _StatCard(label: 'Lecciones', value: '${user.totalLessonsCompleted}', icon: '📖')),
                ],
              ),

              const SizedBox(height: 24),

              // ── Weekly XP Chart ──
              const Text(
                'XP esta semana',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 12),
              weeklyAsync.when(
                data: (data) => Container(
                  height: 180,
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: (data.reduce((a, b) => a > b ? a : b) * 1.3).clamp(10, double.infinity),
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, _) {
                              const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
                              final idx = value.toInt();
                              if (idx < 0 || idx >= days.length) return const SizedBox.shrink();
                              return Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(days[idx],
                                    style: const TextStyle(color: Colors.white38, fontSize: 11)),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(data.length, (i) {
                        return BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: data[i],
                              color: AppTheme.primary,
                              width: 14,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
                loading: () => Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primary),
                  ),
                ),
                error: (_, __) => Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text('No hay datos suficientes',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Stars distribution ──
              const Text(
                'Estrellas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 12),
              starsAsync.when(
                data: (stars) => Row(
                  children: [
                    Expanded(child: _StarBadge(count: stars[3] ?? 0, stars: 3)),
                    const SizedBox(width: 12),
                    Expanded(child: _StarBadge(count: stars[2] ?? 0, stars: 2)),
                    const SizedBox(width: 12),
                    Expanded(child: _StarBadge(count: stars[1] ?? 0, stars: 1)),
                  ],
                ),
                loading: () => SizedBox(
                  height: 48,
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white.withValues(alpha: 0.3)),
                  ),
                ),
                error: (_, __) => SizedBox(
                  height: 48,
                  child: Center(
                    child: Text('Error al cargar estrellas',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13)),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── Atributos ──
              const Text(
                'Atributos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 12),
              ...AttributeType.values.map((attr) {
                final value = attributes[attr.value] ?? 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _AttributeBar(
                    icon: attr.icon,
                    label: attr.displayName,
                    value: value,
                    maxValue: 100,
                    color: _parseColor(attr.color),
                  ),
                );
              }),

              const SizedBox(height: 24),

              // ── Progreso del curso ──
              const Text(
                'Progreso del curso',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 12),
              completionAsync.when(
                data: (completion) => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: completion,
                              backgroundColor: Colors.white.withValues(alpha: 0.1),
                              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                              strokeWidth: 10,
                            ),
                            Center(
                              child: Text(
                                '${(completion * 100).round()}%',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${(completion * 100).round()}% del curso completado',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const Text('Error', style: TextStyle(color: Colors.white54)),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return AppTheme.primary;
    }
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }
}

class _StarBadge extends StatelessWidget {
  final int count;
  final int stars;
  const _StarBadge({required this.count, required this.stars});

  @override
  Widget build(BuildContext context) {
    final label = stars == 3 ? '3 ★' : stars == 2 ? '2 ★' : '1 ★';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.gold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.gold.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(
            '$count',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppTheme.gold),
          ),
          Text(label, style: const TextStyle(fontSize: 11, color: AppTheme.gold)),
        ],
      ),
    );
  }
}

class _AttributeBar extends StatelessWidget {
  final String icon;
  final String label;
  final int value;
  final int maxValue;
  final Color color;

  const _AttributeBar({
    required this.icon,
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white70)),
            const Spacer(),
            Text('$value', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value / maxValue,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
