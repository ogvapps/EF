import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/lesson_model.dart';
import '../../../data/models/quiz_question_model.dart';
import '../../../data/models/user_progress_model.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/enums/lesson_type.dart';

class QuizState {
  final List<QuizQuestion> questions;
  final int currentIndex;
  final Map<int, int> answers;
  final List<bool> results;
  final bool isCompleted;
  final int score;
  final bool showExplanation;

  const QuizState({
    required this.questions,
    this.currentIndex = 0,
    this.answers = const {},
    this.results = const [],
    this.isCompleted = false,
    this.score = 0,
    this.showExplanation = false,
  });

  int get progress => questions.isEmpty ? 0 : ((currentIndex / questions.length) * 100).round();
  int get correctCount => results.where((r) => r).length;
  int get totalQuestions => questions.length;

  QuizState copyWith({
    int? currentIndex,
    Map<int, int>? answers,
    List<bool>? results,
    bool? isCompleted,
    int? score,
    bool? showExplanation,
  }) =>
      QuizState(
        questions: questions,
        currentIndex: currentIndex ?? this.currentIndex,
        answers: answers ?? this.answers,
        results: results ?? this.results,
        isCompleted: isCompleted ?? this.isCompleted,
        score: score ?? this.score,
        showExplanation: showExplanation ?? this.showExplanation,
      );
}

class QuizNotifier extends StateNotifier<QuizState> {
  final Ref _ref;

  QuizNotifier(this._ref, List<QuizQuestion> questions)
      : super(QuizState(questions: questions));

  void selectAnswer(int questionIndex, int answerIndex) {
    if (state.isCompleted) return;

    final question = state.questions[questionIndex];
    final isCorrect = answerIndex == question.correct;
    final newAnswers = Map<int, int>.from(state.answers)
      ..[questionIndex] = answerIndex;
    final newResults = List<bool>.from(state.results)
      ..add(isCorrect);

    state = state.copyWith(
      answers: newAnswers,
      results: newResults,
      showExplanation: true,
    );
  }

  void nextQuestion() {
    if (state.currentIndex >= state.questions.length - 1) {
      _finishQuiz();
    } else {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        showExplanation: false,
      );
    }
  }

  void _finishQuiz() {
    final score = ((state.correctCount / state.totalQuestions) * 100).round();
    state = state.copyWith(isCompleted: true, score: score);
  }

  Future<void> saveResult(
      String userId, String unitId, String lessonId) async {
    final repo = _ref.read(progressRepositoryProvider);
    final lesson = LessonModel(
      lessonId: lessonId,
      unitId: unitId,
      order: 0,
      type: LessonType.quiz,
      title: '',
      durationSec: 0,
      createdAt: DateTime.now(),
    );

    final quizAnswers = state.answers.entries.map((e) => QuizAnswer(
      questionId: state.questions[e.key].id,
      selected: e.value,
      correct: state.results[e.key],
      timestamp: DateTime.now(),
    )).toList();

    await repo.completeLesson(
      userId: userId,
      unitId: unitId,
      lesson: lesson,
      quizAnswers: quizAnswers,
      score: state.score.toDouble(),
    );
  }
}

final quizProvider = StateNotifierProvider.autoDispose.family<QuizNotifier, QuizState, List<QuizQuestion>>(
  (ref, questions) => QuizNotifier(ref, questions),
);
