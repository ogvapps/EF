import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/core_providers.dart';
import '../../../data/models/challenge_model.dart';

enum ChallengeStatus { ready, countdown, inProgress, completed, failed }

class ChallengeState {
  final ChallengeModel challenge;
  final ChallengeStatus status;
  final int countdown;
  final double currentValue;
  final int? heartRate;
  final int elapsedSeconds;
  final int stars;
  final bool saved;
  final double adaptedGoal;

  const ChallengeState({
    required this.challenge,
    this.status = ChallengeStatus.ready,
    this.countdown = 3,
    this.currentValue = 0,
    this.heartRate,
    this.elapsedSeconds = 0,
    this.stars = 0,
    this.saved = false,
    this.adaptedGoal = 0,
  });

  ChallengeState.withAdaptedGoal({
    required this.challenge,
    required this.adaptedGoal,
    this.status = ChallengeStatus.ready,
    this.countdown = 3,
    this.currentValue = 0,
    this.heartRate,
    this.elapsedSeconds = 0,
    this.stars = 0,
    this.saved = false,
  });

  double get minValue => adaptedGoal * 0.5;
  double get maxValue => adaptedGoal * 1.5;

  ChallengeState copyWith({
    ChallengeStatus? status,
    int? countdown,
    double? currentValue,
    int? heartRate,
    int? elapsedSeconds,
    int? stars,
    bool? saved,
  }) =>
      ChallengeState.withAdaptedGoal(
        challenge: challenge,
        adaptedGoal: adaptedGoal,
        status: status ?? this.status,
        countdown: countdown ?? this.countdown,
        currentValue: currentValue ?? this.currentValue,
        heartRate: heartRate ?? this.heartRate,
        elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
        stars: stars ?? this.stars,
        saved: saved ?? this.saved,
      );
}

class ChallengeNotifier extends StateNotifier<ChallengeState> {
  final Ref _ref;
  Timer? _countdownTimer;
  Timer? _challengeTimer;

  ChallengeNotifier(this._ref, ChallengeModel challenge)
      : super(ChallengeState.withAdaptedGoal(
          challenge: challenge,
          adaptedGoal: challenge.goalValue,
        ));

  void setAdaptedGoal(double goal) {
    if (state.status == ChallengeStatus.ready) {
      state = ChallengeState.withAdaptedGoal(
        challenge: state.challenge,
        adaptedGoal: goal,
      );
    }
  }

  void startCountdown() {
    state = state.copyWith(status: ChallengeStatus.countdown, countdown: 3);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.countdown <= 1) {
        timer.cancel();
        _startChallenge();
      } else {
        state = state.copyWith(countdown: state.countdown - 1);
      }
    });
  }

  void _startChallenge() {
    state = state.copyWith(status: ChallengeStatus.inProgress);
    _challengeTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
    });
  }

  void updateValue(double value) {
    state = state.copyWith(currentValue: value);
    _checkCompletion(value);
  }

  void updateHeartRate(int bpm) {
    state = state.copyWith(heartRate: bpm);
  }

  void _checkCompletion(double value) {
    if (value >= state.adaptedGoal) {
      _complete(value);
    }
  }

  void completeManually() {
    _complete(state.currentValue);
  }

  void _complete(double value) {
    _countdownTimer?.cancel();
    _challengeTimer?.cancel();

    int stars = 0;
    if (value >= state.minValue) stars = 1;
    if (value >= state.adaptedGoal) stars = 2;
    if (value >= state.maxValue) stars = 3;

    state = state.copyWith(
      status: stars > 0 ? ChallengeStatus.completed : ChallengeStatus.failed,
      currentValue: value,
      stars: stars,
    );
  }

  void fail() {
    _countdownTimer?.cancel();
    _challengeTimer?.cancel();
    state = state.copyWith(status: ChallengeStatus.failed);
  }

  Future<void> saveResult(String userId, String unitId) async {
    if (state.saved) return;
    final repo = _ref.read(progressRepositoryProvider);

    await repo.completeChallenge(
      userId: userId,
      unitId: unitId,
      challenge: state.challenge,
      achievedValue: state.currentValue,
      heartRate: state.heartRate,
      duration: state.elapsedSeconds,
    );

    state = state.copyWith(saved: true);
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _challengeTimer?.cancel();
    super.dispose();
  }
}

final challengeProvider = StateNotifierProvider.autoDispose.family<ChallengeNotifier, ChallengeState, ChallengeModel>(
  (ref, challenge) => ChallengeNotifier(ref, challenge),
);
