import '../../core/enums/progress_status.dart';

class UserProgressModel {
  final String progressId;
  final String userId;
  final String unitId;
  final String refId;
  final String refType;
  final ProgressStatus status;
  final double? score;
  final int stars;
  final int timeSpentSec;
  final int attempts;
  final DateTime? completedAt;
  final List<QuizAnswer>? quizAnswers;
  final ChallengeResult? challengeResult;
  final int? aiDifficulty;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProgressModel({
    required this.progressId,
    required this.userId,
    required this.unitId,
    required this.refId,
    required this.refType,
    this.status = ProgressStatus.available,
    this.score,
    this.stars = 0,
    this.timeSpentSec = 0,
    this.attempts = 0,
    this.completedAt,
    this.quizAnswers,
    this.challengeResult,
    this.aiDifficulty,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'unit_id': unitId,
        'ref_id': refId,
        'ref_type': refType,
        'status': status.value,
        'score': score,
        'stars': stars,
        'time_spent_sec': timeSpentSec,
        'attempts': attempts,
        'completed_at': completedAt?.toIso8601String(),
        'quiz_answers': quizAnswers?.map((a) => a.toJson()).toList(),
        'challenge_result': challengeResult?.toJson(),
        'ai_difficulty': aiDifficulty,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.parse(value.toString());
  }

  factory UserProgressModel.fromJson(Map<String, dynamic> data) {
    return UserProgressModel(
      progressId: data['progress_id'] ?? '${data['user_id']}_${data['ref_id']}',
      userId: data['user_id'] ?? '',
      unitId: data['unit_id'] ?? '',
      refId: data['ref_id'] ?? '',
      refType: data['ref_type'] ?? 'lesson',
      status: ProgressStatus.fromString(data['status'] ?? 'available'),
      score: data['score']?.toDouble(),
      stars: data['stars'] ?? 0,
      timeSpentSec: data['time_spent_sec'] ?? 0,
      attempts: data['attempts'] ?? 0,
      completedAt: data['completed_at'] != null ? _parseDate(data['completed_at']) : null,
      quizAnswers: (data['quiz_answers'] as List?)
          ?.map((a) => QuizAnswer.fromJson(a))
          .toList(),
      challengeResult: data['challenge_result'] != null
          ? ChallengeResult.fromJson(data['challenge_result'])
          : null,
      aiDifficulty: data['ai_difficulty'],
      createdAt: _parseDate(data['created_at']),
      updatedAt: _parseDate(data['updated_at']),
    );
  }

  UserProgressModel copyWith({
    ProgressStatus? status,
    double? score,
    int? stars,
    int? timeSpentSec,
    int? attempts,
    DateTime? completedAt,
    int? aiDifficulty,
  }) =>
      UserProgressModel(
        progressId: progressId,
        userId: userId,
        unitId: unitId,
        refId: refId,
        refType: refType,
        status: status ?? this.status,
        score: score ?? this.score,
        stars: stars ?? this.stars,
        timeSpentSec: timeSpentSec ?? this.timeSpentSec,
        attempts: attempts ?? this.attempts,
        completedAt: completedAt ?? this.completedAt,
        quizAnswers: quizAnswers,
        challengeResult: challengeResult,
        aiDifficulty: aiDifficulty ?? this.aiDifficulty,
        createdAt: createdAt,
        updatedAt: DateTime.now(),
      );
}

class QuizAnswer {
  final String questionId;
  final int selected;
  final bool correct;
  final DateTime timestamp;

  QuizAnswer({
    required this.questionId,
    required this.selected,
    required this.correct,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'selected': selected,
        'correct': correct,
        'timestamp': timestamp.toIso8601String(),
      };

  factory QuizAnswer.fromJson(Map<String, dynamic> data) => QuizAnswer(
        questionId: data['questionId'] ?? '',
        selected: data['selected'] ?? 0,
        correct: data['correct'] ?? false,
        timestamp: data['timestamp'] is DateTime
            ? data['timestamp']
            : DateTime.parse(data['timestamp'] ?? DateTime.now().toIso8601String()),
      );
}

class ChallengeResult {
  final double value;
  final int? heartRate;
  final int? duration;

  ChallengeResult({required this.value, this.heartRate, this.duration});

  Map<String, dynamic> toJson() => {
        'value': value,
        'heartRate': heartRate,
        'duration': duration,
      };

  factory ChallengeResult.fromJson(Map<String, dynamic> data) =>
      ChallengeResult(
        value: (data['value'] ?? 0).toDouble(),
        heartRate: data['heartRate'],
        duration: data['duration'],
      );
}
