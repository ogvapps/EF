import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/quiz_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../data/models/quiz_question_model.dart';
import '../../../core/providers/core_providers.dart';

import '../../units/providers/unit_providers.dart';

class QuizScreen extends ConsumerWidget {
  final String unitId;
  final String lessonId;
  final List<QuizQuestion> questions;

  const QuizScreen({
    super.key,
    required this.unitId,
    required this.lessonId,
    this.questions = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (questions.isNotEmpty) {
      return _QuizBody(unitId: unitId, lessonId: lessonId, questions: questions);
    }

    final lessonAsync = ref.watch(lessonDetailProvider((unitId: unitId, lessonId: lessonId)));
    return lessonAsync.when(
      data: (lesson) {
        final loadedQuestions = lesson.quizData?.questions ?? <QuizQuestion>[];
        if (loadedQuestions.isEmpty) {
          return Scaffold(
            backgroundColor: const Color(0xFF1A1A2E),
            appBar: AppBar(backgroundColor: Colors.transparent),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No hay preguntas disponibles para este quiz', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Volver'),
                  ),
                ],
              ),
            ),
          );
        }
        return _QuizBody(unitId: unitId, lessonId: lessonId, questions: loadedQuestions);
      },
      loading: () => const Scaffold(
        backgroundColor: Color(0xFF1A1A2E),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50))),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: const Color(0xFF1A1A2E),
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Center(child: Text('Error: $e', style: const TextStyle(color: Colors.white70))),
      ),
    );
  }
}

class _QuizBody extends ConsumerWidget {
  final String unitId;
  final String lessonId;
  final List<QuizQuestion> questions;

  const _QuizBody({
    required this.unitId,
    required this.lessonId,
    required this.questions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.watch(quizProvider(questions));

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white70),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Quiz',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: quiz.isCompleted ? _buildResults(context, ref, quiz) : _buildQuiz(context, ref, quiz),
      ),
    );
  }

  Widget _buildQuiz(BuildContext context, WidgetRef ref, QuizState quiz) {
    final question = quiz.questions[quiz.currentIndex];
    final selectedAnswer = quiz.answers[quiz.currentIndex];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: quiz.progress / 100,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${quiz.currentIndex + 1}/${quiz.totalQuestions}',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Question
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),

          // Options
          ...List.generate(question.options.length, (i) {
            final isSelected = selectedAnswer == i;
            final isCorrect = i == question.correct;
            final showResult = selectedAnswer != null && quiz.showExplanation;

            Color? optionColor;
            if (showResult) {
              optionColor = isCorrect
                  ? const Color(0xFF4CAF50)
                  : isSelected
                      ? const Color(0xFFF44336)
                      : null;
            } else if (isSelected) {
              optionColor = const Color(0xFF4CAF50).withValues(alpha: 0.3);
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: optionColor ?? Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: selectedAnswer == null
                      ? () => ref.read(quizProvider(questions).notifier)
                          .selectAnswer(quiz.currentIndex, i)
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4CAF50).withValues(alpha: 0.2)
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + i),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: isSelected ? const Color(0xFF4CAF50) : Colors.white54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            question.options[i],
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (showResult && isCorrect)
                          const Icon(Icons.check_circle, color: Color(0xFF4CAF50)),
                        if (showResult && isSelected && !isCorrect)
                          const Icon(Icons.cancel, color: Color(0xFFF44336)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),

          const Spacer(),

          // Explanation
          if (selectedAnswer != null && quiz.showExplanation)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                question.explanation.isNotEmpty
                    ? question.explanation
                    : (selectedAnswer == question.correct
                        ? '¡Correcto!'
                        : 'La respuesta correcta era: ${question.options[question.correct]}'),
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),

          if (selectedAnswer != null) ...[
            const SizedBox(height: 12),
            CustomButton(
              text: quiz.currentIndex < quiz.totalQuestions - 1
                  ? 'Siguiente pregunta'
                  : 'Ver resultados',
              onPressed: () => ref.read(quizProvider(questions).notifier).nextQuestion(),
              gradient: const [Color(0xFF4CAF50), Color(0xFF4CAF50)],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResults(BuildContext context, WidgetRef ref, QuizState quiz) {
    final pct = quiz.score;
    final passed = pct >= 70;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(passed ? '🎉' : '💪', style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            passed ? '¡Quiz superado!' : 'Sigue practicando',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$pct% de aciertos',
            style: TextStyle(
              fontSize: 16,
              color: passed ? const Color(0xFF4CAF50) : const Color(0xFFFF6B35),
            ),
          ),
          const SizedBox(height: 24),
          // Score bar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _Stat(label: 'Correctas', value: '${quiz.correctCount}/${quiz.totalQuestions}'),
                    _Stat(label: 'Puntuación', value: '$pct%'),
                    _Stat(label: 'Estrellas', value: passed ? '⭐' : '☆'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Finalizar',
            onPressed: () async {
              final authState = ref.read(authProvider);
              if (authState.user == null) return;

              await ref.read(quizProvider(questions).notifier)
                  .saveResult(authState.user!.uid, unitId, lessonId);

              final xp = passed ? 50 : 25;
              await ref.read(userRepositoryProvider).addXP(authState.user!.uid, xp);

              if (context.mounted) context.pop();
            },
            gradient: const [Color(0xFF4CAF50), Color(0xFF4CAF50)],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.5)),
        ),
      ],
    );
  }
}
