import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../core/providers/core_providers.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../data/models/unit_model.dart';
import '../providers/boss_providers.dart';

import '../../units/providers/unit_providers.dart';

class BossFightScreen extends ConsumerWidget {
  final String unitId;
  final UnitModel? unit;

  const BossFightScreen({
    super.key,
    required this.unitId,
    this.unit,
  });

  static const phases = [
    BossFightPhase('Quiz final', 'Responde correctamente', Icons.quiz_outlined, 10, 10),
    BossFightPhase('Movimiento', 'Ejercicio físico', Icons.fitness_center, 15, 15),
    BossFightPhase('Esfuerzo final', 'Resistencia', Icons.timer_outlined, 20, 20),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (unit != null) {
      return _buildWithUnit(context, ref, unit!);
    }

    final unitAsync = ref.watch(unitStreamProvider(unitId));
    return unitAsync.when(
      data: (loadedUnit) {
        if (loadedUnit == null) {
          return const Scaffold(
            backgroundColor: Color(0xFF1A1A2E),
            body: Center(child: Text('Unidad no encontrada', style: TextStyle(color: Colors.white70))),
          );
        }
        return _buildWithUnit(context, ref, loadedUnit);
      },
      loading: () => const Scaffold(
        backgroundColor: Color(0xFF1A1A2E),
        body: Center(child: CircularProgressIndicator(color: Color(0xFFFF6B35))),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: const Color(0xFF1A1A2E),
        body: Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white70))),
      ),
    );
  }

  Widget _buildWithUnit(BuildContext context, WidgetRef ref, UnitModel currentUnit) {
    final fight = ref.watch(bossFightProvider(phases));
    final bossName = currentUnit.bossName ?? 'Jefe Final';

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: fight.isCompleted
            ? _buildResult(context, ref, fight, currentUnit)
            : _buildFight(context, ref, fight, bossName),
      ),
    );
  }

  Widget _buildFight(BuildContext context, WidgetRef ref, BossFightState fight, String bossName) {
    final phase = phases[fight.currentPhase];
    final totalHP = phases.fold<int>(0, (sum, p) => sum + p.hp);
    final hpPercent = (totalHP - fight.bossHP) / totalHP;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Boss header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF44336), Color(0xFFFF6B35)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text('👑', style: TextStyle(fontSize: 40)),
                const SizedBox(height: 8),
                Text(
                  bossName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: hpPercent.clamp(0, 1),
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      hpPercent > 0.5
                          ? const Color(0xFF4CAF50)
                          : hpPercent > 0.25
                              ? const Color(0xFFFF9800)
                              : const Color(0xFFF44336),
                    ),
                    minHeight: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${fight.bossHP}/$totalHP',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Phase card
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(phase.icon, size: 48, color: const Color(0xFFFF6B35)),
                  const SizedBox(height: 16),
                  Text(
                    phase.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    phase.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'HP: ${phase.hp} · Daño: ${phase.damage}',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          CustomButton(
            text: fight.currentPhase == 0
                ? 'Comenzar fase'
                : '¡Atacar! (Fase ${fight.currentPhase + 1})',
            onPressed: () => ref.read(bossFightProvider(phases).notifier).attack(),
            gradient: const [Color(0xFFFF6B35), Color(0xFFFF6B35)],
          ),
        ],
      ),
    );
  }

  Widget _buildResult(BuildContext context, WidgetRef ref, BossFightState fight, UnitModel currentUnit) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(fight.isVictory ? '🏆' : '💪', style: const TextStyle(fontSize: 80)),
          const SizedBox(height: 16),
          Text(
            fight.isVictory ? '¡Jefe derrotado!' : '¡Sigue entrenando!',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            fight.isVictory
                ? 'Has completado ${currentUnit.title}'
                : 'Vuelve a intentarlo cuando estés listo',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          if (fight.isVictory) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Color(0xFFFFD700)),
                  const SizedBox(width: 8),
                  Text(
                    '+${currentUnit.bossXP} XP',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 32),
          CustomButton(
            text: 'Finalizar',
            onPressed: () async {
              if (fight.isVictory) {
                final authState = ref.read(authProvider);
                if (authState.user != null) {
                  await ref.read(userRepositoryProvider)
                      .addXP(authState.user!.uid, currentUnit.bossXP);
                  await ref.read(userRepositoryProvider)
                      .completeUnit(authState.user!.uid, unitId);
                }
              }
              if (context.mounted) context.pop();
            },
            gradient: fight.isVictory ? [const Color(0xFF4CAF50), const Color(0xFF4CAF50)] : [Colors.white.withValues(alpha: 0.2), Colors.white.withValues(alpha: 0.2)],
          ),
        ],
      ),
    );
  }
}
