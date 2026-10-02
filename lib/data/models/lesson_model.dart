import '../../core/enums/lesson_type.dart';
import 'quiz_question_model.dart';

class LessonModel {
  final String lessonId;
  final String unitId;
  final int order;
  final LessonType type;
  final String title;
  final String description;
  final int durationSec;
  final String? videoURL;
  final String? contentHTML;
  final QuizData? quizData;
  final int xpReward;
  final Map<String, int> attributeRewards;
  final int coinReward;
  final bool isActive;
  final DateTime createdAt;

  LessonModel({
    required this.lessonId,
    required this.unitId,
    required this.order,
    required this.type,
    required this.title,
    this.description = '',
    this.durationSec = 60,
    this.videoURL,
    this.contentHTML,
    this.quizData,
    this.xpReward = 25,
    Map<String, int>? attributeRewards,
    this.coinReward = 5,
    this.isActive = true,
    required this.createdAt,
  }) : attributeRewards = attributeRewards ?? {};

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.parse(value.toString());
  }

  factory LessonModel.fromJson(Map<String, dynamic> data) {
    return LessonModel(
      lessonId: data['lesson_id'] ?? data['id'] ?? '',
      unitId: data['unit_id'] ?? '',
      order: data['order'] ?? 0,
      type: LessonType.fromString(data['type'] ?? 'video'),
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      durationSec: data['duration_sec'] ?? 60,
      videoURL: data['video_url'],
      contentHTML: data['content_html'],
      quizData: data['quiz_data'] != null
          ? QuizData.fromJson(data['quiz_data'])
          : null,
      xpReward: data['xp_reward'] ?? 25,
      attributeRewards: Map<String, int>.from(data['attribute_rewards'] ?? {}),
      coinReward: data['coin_reward'] ?? 5,
      isActive: data['is_active'] ?? true,
      createdAt: _parseDate(data['created_at']),
    );
  }
}

class QuizData {
  final int minPassScore;
  final List<QuizQuestion> questions;

  QuizData({this.minPassScore = 70, required this.questions});

  factory QuizData.fromJson(Map<String, dynamic> data) => QuizData(
        minPassScore: data['minPassScore'] ?? 70,
        questions: (data['questions'] as List? ?? [])
            .map((q) => QuizQuestion.fromJson(q))
            .toList(),
      );
}
