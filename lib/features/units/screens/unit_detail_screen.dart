import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/unit_providers.dart';

import '../../../core/enums/attribute_type.dart';

class UnitDetailScreen extends ConsumerWidget {
  final String unitId;

  const UnitDetailScreen({super.key, required this.unitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitAsync = ref.watch(unitStreamProvider(unitId));
    final lessonsAsync = ref.watch(lessonListProvider(unitId));
    final challengesAsync = ref.watch(challengeListProvider(unitId));
    final progressAsync = ref.watch(unitProgressProvider(unitId));

    return unitAsync.when(
      data: (unit) {
        if (unit == null) {
          return const Scaffold(
            body: Center(child: Text('Unidad no encontrada')),
          );
        }
        return Scaffold(
          backgroundColor: const Color(0xFF1A1A2E),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                // Header
                SliverAppBar(
                  expandedHeight: 160,
                  backgroundColor: const Color(0xFF1A1A2E),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _parseColor(unit.colorHex).withValues(alpha: 0.3),
                            const Color(0xFF1A1A2E),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            unit.title,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${unit.course.replaceFirst('_', ' ').toUpperCase()} · ${unit.totalXP} XP',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Attribute focus
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: unit.attributeFocus.entries
                          .where((e) => e.value > 0)
                          .map((e) {
                        final attr = AttributeType.fromString(e.key);
                        return Chip(
                          avatar: Text(attr.icon, style: const TextStyle(fontSize: 14)),
                          label: Text('${attr.displayName} +${e.value}'),
                          backgroundColor: _parseColor(attr.color).withValues(alpha: 0.15),
                          side: BorderSide.none,
                          labelStyle: const TextStyle(color: Colors.white70, fontSize: 12),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                // Progress
                SliverToBoxAdapter(
                  child: progressAsync.when(
                    data: (progress) {
                      final completed = progress.where((p) => p.status.name == 'completed').length;
                      final total = lessonsAsync.valueOrNull?.length ?? 0 +
                          (challengesAsync.valueOrNull?.length ?? 0);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Progreso: $completed/$total',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: total > 0 ? completed / total : 0,
                                backgroundColor: Colors.white.withValues(alpha: 0.1),
                                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                                minHeight: 6,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        child: LinearProgressIndicator(backgroundColor: Color(0xFF1A1A2E)),
                      ),
                    ),
                    error: (_, __) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Error al cargar progreso',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12)),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                // Lessons section
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Lecciones',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                lessonsAsync.when(
                  data: (lessons) {
                    if (lessons.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text('No hay lecciones disponibles',
                              style: TextStyle(color: Colors.white38, fontSize: 13)),
                        ),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) => _LessonTile(
                          title: lessons[i].title,
                          type: lessons[i].type.value,
                          xp: lessons[i].xpReward,
                          duration: lessons[i].durationSec,
                          onTap: () => context.push(
                            '/home/unit/$unitId/lesson/${lessons[i].lessonId}',
                            extra: lessons[i],
                          ),
                        ),
                        childCount: lessons.length,
                      ),
                    );
                  },
                  loading: () => const SliverToBoxAdapter(
                    child: Center(child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF4CAF50)),
                    )),
                  ),
                  error: (e, _) => SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text('Error: $e',
                            style: const TextStyle(color: Colors.white54)),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                // Challenges section
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Retos físicos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                challengesAsync.when(
                  data: (challenges) {
                    if (challenges.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Text('No hay retos disponibles',
                              style: TextStyle(color: Colors.white38, fontSize: 13)),
                        ),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) => _ChallengeTile(
                          title: challenges[i].title,
                          difficulty: challenges[i].difficulty.value,
                          xp: challenges[i].xpReward,
                          type: challenges[i].type.value,
                          onTap: () => context.push(
                            '/home/unit/$unitId/challenge/${challenges[i].challengeId}',
                            extra: challenges[i],
                          ),
                        ),
                        childCount: challenges.length,
                      ),
                    );
                  },
                  loading: () => const SliverToBoxAdapter(
                    child: Center(child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFFF6B35)),
                    )),
                  ),
                  error: (e, _) => SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text('Error: $e',
                            style: const TextStyle(color: Colors.white54)),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                // Boss
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () => context.push(
                        '/home/unit/$unitId/boss',
                        extra: unit,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B35), Color(0xFFF44336)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Text('👑', style: TextStyle(fontSize: 36)),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Jefe Final',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    unit.bossName ?? 'Desafío final',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
    );
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return const Color(0xFF4CAF50);
    }
  }
}

class _LessonTile extends StatelessWidget {
  final String title;
  final String type;
  final int xp;
  final int duration;
  final VoidCallback onTap;

  const _LessonTile({
    required this.title,
    required this.type,
    required this.xp,
    required this.duration,
    required this.onTap,
  });

  IconData _iconForType() {
    switch (type) {
      case 'video':
        return Icons.play_circle_outline;
      case 'quiz':
        return Icons.quiz_outlined;
      case 'flashcard':
        return Icons.style_outlined;
      case 'reading':
        return Icons.menu_book_outlined;
      default:
        return Icons.circle_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Material(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(_iconForType(), color: const Color(0xFF4CAF50), size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  '$duration s',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '+$xp XP',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChallengeTile extends StatelessWidget {
  final String title;
  final String difficulty;
  final int xp;
  final String type;
  final VoidCallback onTap;

  const _ChallengeTile({
    required this.title,
    required this.difficulty,
    required this.xp,
    required this.type,
    required this.onTap,
  });

  Color _difficultyColor() {
    switch (difficulty) {
      case 'facil':
        return const Color(0xFF4CAF50);
      case 'medio':
        return const Color(0xFFFF9800);
      case 'dificil':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final diffColor = _difficultyColor();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Material(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const Icon(Icons.fitness_center, color: Color(0xFFFF6B35), size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: diffColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          difficulty[0].toUpperCase() + difficulty.substring(1),
                          style: TextStyle(
                            fontSize: 10,
                            color: diffColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '+$xp XP',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFFF6B35),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
