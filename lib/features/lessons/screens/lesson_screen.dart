import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/lesson_flow_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/rewards_widgets.dart';
import '../../../data/models/lesson_model.dart';
import '../../../core/enums/lesson_type.dart';

import '../../units/providers/unit_providers.dart';

class LessonScreen extends ConsumerWidget {
  final String unitId;
  final String lessonId;
  final LessonModel? lesson;

  const LessonScreen({
    super.key,
    required this.unitId,
    required this.lessonId,
    this.lesson,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (lesson != null) {
      return _LessonBody(unitId: unitId, lessonId: lessonId, lesson: lesson!);
    }

    final lessonAsync = ref.watch(lessonDetailProvider((unitId: unitId, lessonId: lessonId)));
    return lessonAsync.when(
      data: (loadedLesson) => _LessonBody(unitId: unitId, lessonId: lessonId, lesson: loadedLesson),
      loading: () => const Scaffold(
        backgroundColor: AppTheme.deepNavy,
        body: Center(child: CircularProgressIndicator(color: AppTheme.primary)),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: AppTheme.deepNavy,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Center(child: Text('Error al cargar lección: $e', style: const TextStyle(color: Colors.white70))),
      ),
    );
  }
}

class _LessonBody extends ConsumerWidget {
  final String unitId;
  final String lessonId;
  final LessonModel lesson;

  const _LessonBody({
    required this.unitId,
    required this.lessonId,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalContent = (lesson.contentHTML != null || lesson.videoURL != null) ? 1 : 0;
    final flow = ref.watch(lessonFlowProvider(totalContent));
    final hasQuiz = lesson.quizData != null && lesson.quizData!.questions.isNotEmpty;

    return Scaffold(
      backgroundColor: AppTheme.deepNavy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white70),
          onPressed: () => context.pop(),
        ),
        title: Text(
          lesson.title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => ref.read(lessonFlowProvider(totalContent).notifier).skipToQuiz(),
            child: const Text('Saltar', style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: flow.step.index / 4.0,
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(child: _buildStepContent(context, ref, flow, hasQuiz)),
              SafeArea(
                child: CustomButton(
                  text: _buttonText(flow, totalContent, hasQuiz),
                  onPressed: () {
                    if (flow.step == LessonStep.complete) {
                      _saveAndShowReward(ref, context);
                    } else if (flow.step == LessonStep.quiz && hasQuiz) {
                      context.push(
                        '/home/unit/$unitId/quiz/$lessonId',
                        extra: lesson.quizData!.questions,
                      );
                    } else {
                      ref.read(lessonFlowProvider(totalContent).notifier).nextStep();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, WidgetRef ref, LessonFlowState flow, bool hasQuiz) {
    switch (flow.step) {
      case LessonStep.intro:
        return _IntroContent(title: lesson.title, description: lesson.description);
      case LessonStep.content:
        return _ContentPage(lesson: lesson, index: flow.contentIndex);
      case LessonStep.practice:
        return _PracticePage(lesson: lesson);
      case LessonStep.quiz:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('📝', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 16),
              Text(
                hasQuiz ? 'Hora del quiz' : '¡Lección completada!',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                hasQuiz
                    ? 'Demuestra lo que has aprendido en el quiz interactivo'
                    : 'Has revisado todo el contenido de esta lección',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      case LessonStep.complete:
        return const SizedBox.shrink();
    }
  }

  String _buttonText(LessonFlowState flow, int totalContent, bool hasQuiz) {
    switch (flow.step) {
      case LessonStep.intro:
        return 'Empezar lección';
      case LessonStep.content:
        return flow.contentIndex < totalContent - 1 ? 'Siguiente' : 'Practicar';
      case LessonStep.practice:
        return hasQuiz ? 'Hacer quiz' : 'Finalizar lección';
      case LessonStep.quiz:
        return hasQuiz ? 'Comenzar quiz' : 'Continuar';
      case LessonStep.complete:
        return 'Continuar';
    }
  }

  void _saveAndShowReward(WidgetRef ref, BuildContext context) async {
    final authState = ref.read(authProvider);
    if (authState.user == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => XpRewardPopup(
        xp: lesson.xpReward,
        coins: lesson.coinReward,
        onComplete: () async {
          final repo = ref.read(progressRepositoryProvider);
          final lessonForSave = LessonModel(
            lessonId: lessonId,
            unitId: unitId,
            order: lesson.order,
            type: lesson.type,
            title: lesson.title,
            durationSec: lesson.durationSec,
            createdAt: DateTime.now(),
          );
          try {
            await repo.completeLesson(
              userId: authState.user!.uid,
              unitId: unitId,
              lesson: lessonForSave,
              score: 100,
            );
            await ref.read(userRepositoryProvider).addXP(authState.user!.uid, lesson.xpReward);
            if (context.mounted) context.pop();
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error al guardar: $e')),
              );
            }
          }
        },
      ),
    );
  }
}

class _IntroContent extends StatelessWidget {
  final String title;
  final String description;
  const _IntroContent({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Center(
            child: Text('🎯', style: TextStyle(fontSize: 48)),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          description.isNotEmpty ? description : 'Completa esta lección para ganar XP y mejorar tus atributos.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.6),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ContentPage extends StatelessWidget {
  final LessonModel lesson;
  final int index;
  const _ContentPage({required this.lesson, required this.index});

  @override
  Widget build(BuildContext context) {
    if (lesson.type == LessonType.video) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.play_circle_fill, size: 64, color: AppTheme.primary),
                  SizedBox(height: 8),
                  Text('Reproduciendo...', style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Aquí se reproducirá el vídeo educativo de ~1 minuto',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          if (lesson.contentHTML != null)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                lesson.contentHTML!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            )
          else
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.menu_book_outlined, size: 64, color: AppTheme.primary),
                const SizedBox(height: 16),
                Text(
                  lesson.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _PracticePage extends StatelessWidget {
  final LessonModel lesson;
  const _PracticePage({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('💡', style: TextStyle(fontSize: 48)),
        const SizedBox(height: 16),
        const Text(
          'Practica lo aprendido',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          'Repite mentalmente los conceptos clave antes del quiz',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.primary.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              const Text('🎯', style: TextStyle(fontSize: 32)),
              const SizedBox(height: 8),
              Text(
                'Tiempo estimado: ${lesson.durationSec} segundos',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
