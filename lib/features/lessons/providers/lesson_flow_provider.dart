import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LessonStep { intro, content, practice, quiz, complete }

class LessonFlowState {
  final LessonStep step;
  final int contentIndex;
  final bool isCompleted;
  final int xpEarned;

  const LessonFlowState({
    this.step = LessonStep.intro,
    this.contentIndex = 0,
    this.isCompleted = false,
    this.xpEarned = 0,
  });

  LessonFlowState copyWith({
    LessonStep? step,
    int? contentIndex,
    bool? isCompleted,
    int? xpEarned,
  }) =>
      LessonFlowState(
        step: step ?? this.step,
        contentIndex: contentIndex ?? this.contentIndex,
        isCompleted: isCompleted ?? this.isCompleted,
        xpEarned: xpEarned ?? this.xpEarned,
      );
}

class LessonFlowNotifier extends StateNotifier<LessonFlowState> {
  final int _totalContentItems;

  LessonFlowNotifier(this._totalContentItems)
      : super(const LessonFlowState());

  void nextStep() {
    switch (state.step) {
      case LessonStep.intro:
        state = state.copyWith(step: LessonStep.content);
        break;
      case LessonStep.content:
        if (state.contentIndex < _totalContentItems - 1) {
          state = state.copyWith(contentIndex: state.contentIndex + 1);
        } else {
          state = state.copyWith(step: LessonStep.practice);
        }
        break;
      case LessonStep.practice:
        state = state.copyWith(step: LessonStep.quiz);
        break;
      case LessonStep.quiz:
        state = state.copyWith(step: LessonStep.complete, isCompleted: true);
        break;
      case LessonStep.complete:
        break;
    }
  }

  void skipToQuiz() {
    state = state.copyWith(step: LessonStep.quiz);
  }

  void completeWithXP(int xp) {
    state = state.copyWith(
      isCompleted: true,
      step: LessonStep.complete,
      xpEarned: xp,
    );
  }
}

final lessonFlowProvider = StateNotifierProvider.autoDispose.family<LessonFlowNotifier, LessonFlowState, int>(
  (ref, totalItems) => LessonFlowNotifier(totalItems),
);
