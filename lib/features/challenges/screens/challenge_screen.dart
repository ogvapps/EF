import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/challenge_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/providers/ai_providers.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../data/models/challenge_model.dart';

import '../../units/providers/unit_providers.dart';

class ChallengeScreen extends ConsumerWidget {
  final String unitId;
  final String challengeId;
  final ChallengeModel? challenge;

  const ChallengeScreen({
    super.key,
    required this.unitId,
    required this.challengeId,
    this.challenge,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (challenge != null) {
      return _ChallengeBody(unitId: unitId, challenge: challenge!);
    }

    final challengeAsync = ref.watch(challengeDetailProvider((unitId: unitId, challengeId: challengeId)));
    return challengeAsync.when(
      data: (loaded) => _ChallengeBody(unitId: unitId, challenge: loaded),
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
}

class _ChallengeBody extends ConsumerWidget {
  final String unitId;
  final ChallengeModel challenge;

  const _ChallengeBody({
    required this.unitId,
    required this.challenge,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(challengeProvider(challenge));
    ref.listen(adaptedChallengeValueProvider(challenge), (_, next) {
      if (next != challenge.goalValue) {
        ref.read(challengeProvider(challenge).notifier).setAdaptedGoal(next);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: state.status == ChallengeStatus.inProgress
                        ? () => _confirmExit(context)
                        : () => context.pop(),
                  ),
                  const Spacer(),
                  if (state.status == ChallengeStatus.inProgress)
                    Text(
                      '${state.elapsedSeconds}s',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              Expanded(child: _buildBody(context, ref, state)),

              // Bottom
              _buildBottom(context, ref, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, ChallengeState state) {
    switch (state.status) {
      case ChallengeStatus.ready:
        return _ReadyContent(challenge: challenge);
      case ChallengeStatus.countdown:
        return _CountdownContent(countdown: state.countdown);
      case ChallengeStatus.inProgress:
        return _ActiveContent(state: state, challenge: challenge, ref: ref);
      case ChallengeStatus.completed:
        return _ResultContent(state: state, passed: true);
      case ChallengeStatus.failed:
        return _ResultContent(state: state, passed: false);
    }
  }

  Widget _buildBottom(BuildContext context, WidgetRef ref, ChallengeState state) {
    switch (state.status) {
      case ChallengeStatus.ready:
        return CustomButton(
          text: '¡Empezar!',
          onPressed: () => ref.read(challengeProvider(challenge).notifier).startCountdown(),
          gradient: const [Color(0xFF4CAF50), Color(0xFF4CAF50)],
        );
      case ChallengeStatus.countdown:
        return const SizedBox.shrink();
      case ChallengeStatus.inProgress:
        return CustomButton(
          text: 'Completar',
          onPressed: () => ref.read(challengeProvider(challenge).notifier).completeManually(),
          gradient: const [Color(0xFFFF6B35), Color(0xFFFF6B35)],
        );
      case ChallengeStatus.completed:
      case ChallengeStatus.failed:
        return Row(
          children: [
            if (state.status == ChallengeStatus.failed)
              Expanded(
                child: CustomButton(
                  text: 'Reintentar',
                  onPressed: () => ref.read(challengeProvider(challenge).notifier).startCountdown(),
                  gradient: [Colors.white.withValues(alpha: 0.1), Colors.white.withValues(alpha: 0.1)],
                  textColor: Colors.white,
                ),
              ),
            if (state.status == ChallengeStatus.failed) const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  text: state.status == ChallengeStatus.completed ? 'Guardar y salir' : 'Salir',
                  onPressed: () async {
                    if (state.status == ChallengeStatus.completed) {
                      final authState = ref.read(authProvider);
                      if (authState.user != null) {
                        try {
                          await ref.read(challengeProvider(challenge).notifier)
                              .saveResult(authState.user!.uid, unitId);
                          await ref.read(userRepositoryProvider)
                              .addXP(authState.user!.uid, challenge.xpReward);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('¡Resultado guardado! +XP')),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error al guardar: $e')),
                            );
                          }
                        }
                      }
                    }
                    if (context.mounted) context.pop();
                  },
                gradient: state.status == ChallengeStatus.completed
                    ? [const Color(0xFF4CAF50), const Color(0xFF4CAF50)]
                    : [Colors.white.withValues(alpha: 0.2), Colors.white.withValues(alpha: 0.2)],
              ),
            ),
          ],
        );
    }
  }

  void _confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        title: const Text('¿Salir?', style: TextStyle(color: Colors.white)),
        content: const Text('Perderás el progreso de este reto',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Seguir', style: TextStyle(color: Color(0xFF4CAF50))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: const Text('Salir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _ReadyContent extends StatelessWidget {
  final ChallengeModel challenge;
  const _ReadyContent({required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFFF6B35).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(
            child: Text('🏃', style: TextStyle(fontSize: 48)),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          challenge.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          challenge.introText.isNotEmpty
              ? challenge.introText
              : 'Prepárate para el reto físico',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.6),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        _InfoRow(label: 'Objetivo', value: '${challenge.goalValue} ${challenge.goalType}'),
        const SizedBox(height: 8),
        _InfoRow(label: 'Dificultad', value: challenge.difficulty.value),
        const SizedBox(height: 8),
        _InfoRow(label: 'Recompensa', value: '${challenge.xpReward} XP'),
        const SizedBox(height: 24),
        Text(
          '⭐ 3 estrellas: ${challenge.maxValue} ${challenge.goalType}',
          style: TextStyle(color: const Color(0xFFFFD700).withValues(alpha: 0.7), fontSize: 13),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _CountdownContent extends StatelessWidget {
  final int countdown;
  const _CountdownContent({required this.countdown});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1, end: 0),
        duration: const Duration(seconds: 1),
        builder: (_, value, __) {
          return Transform.scale(
            scale: 1 + value * 0.5,
            child: Opacity(
              opacity: 1 - value,
              child: Text(
                '$countdown',
                style: const TextStyle(
                  fontSize: 96,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ActiveContent extends StatelessWidget {
  final ChallengeState state;
  final ChallengeModel challenge;
  final WidgetRef ref;
  const _ActiveContent({required this.state, required this.challenge, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Current value
        Text(
          state.currentValue.toStringAsFixed(0),
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          challenge.goalType,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 16),
        ),
        const SizedBox(height: 24),
        // Progress to goal
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: (state.currentValue / challenge.goalValue).clamp(0, 1),
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(
              state.currentValue >= challenge.goalValue
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFFFF6B35),
            ),
            minHeight: 12,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Meta: ${challenge.goalValue} ${challenge.goalType}',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 14),
        ),
        const SizedBox(height: 32),
        // Quick add buttons
        Wrap(
          spacing: 12,
          children: [1, 5, 10].map((n) {
            return ElevatedButton(
              onPressed: () => ref
                  .read(challengeProvider(challenge).notifier)
                  .updateValue(state.currentValue + n),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('+$n'),
            );
          }).toList(),
        ),
        if (state.heartRate != null) ...[
          const SizedBox(height: 16),
          Text(
            'FC: ${state.heartRate} lpm',
            style: const TextStyle(color: Color(0xFFF44336), fontSize: 16),
          ),
        ],
      ],
    );
  }
}

class _ResultContent extends StatelessWidget {
  final ChallengeState state;
  final bool passed;
  const _ResultContent({required this.state, required this.passed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(passed ? '🎉' : '💪', style: const TextStyle(fontSize: 64)),
        const SizedBox(height: 16),
        Text(
          passed ? '¡Reto completado!' : 'Sigue intentándolo',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        // Stars
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                i < state.stars ? Icons.star : Icons.star_border,
                color: const Color(0xFFFFD700),
                size: 40,
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ResultStat(label: 'Valor', value: state.currentValue.toStringAsFixed(0)),
              _ResultStat(label: 'Tiempo', value: '${state.elapsedSeconds}s'),
              _ResultStat(label: 'XP', value: '+${state.challenge.xpReward}'),
            ],
          ),
        ),
      ],
    );
  }
}

class _ResultStat extends StatelessWidget {
  final String label;
  final String value;
  const _ResultStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.5))),
      ],
    );
  }
}
