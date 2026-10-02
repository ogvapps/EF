import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_progress_model.dart';
import '../models/lesson_model.dart';
import '../models/challenge_model.dart';
import '../../core/enums/progress_status.dart';
import '../../core/services/pending_write_service.dart';

class ProgressRepository {
  final SupabaseClient _supabase;
  final PendingWriteService? _pendingWrites;

  ProgressRepository({SupabaseClient? supabase, PendingWriteService? pendingWrites})
      : _supabase = supabase ?? Supabase.instance.client,
        _pendingWrites = pendingWrites;

  Stream<UserProgressModel?> streamProgress(String userId, String refId) {
    return _supabase
        .from('user_progress')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((list) {
          final filtered = list.where((p) => p['ref_id'] == refId).toList();
          return filtered.isNotEmpty ? UserProgressModel.fromJson(filtered.first) : null;
        });
  }

  Stream<List<UserProgressModel>> streamUnitProgress(String userId, String unitId) {
    return _supabase
        .from('user_progress')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((list) => list
            .where((p) => p['unit_id'] == unitId)
            .map((json) => UserProgressModel.fromJson(json))
            .toList());
  }

  Future<UserProgressModel?> getProgress(String userId, String refId) async {
    final data = await _supabase
        .from('user_progress')
        .select()
        .eq('user_id', userId)
        .eq('ref_id', refId)
        .limit(1)
        .maybeSingle();
    if (data == null) return null;
    return UserProgressModel.fromJson(data);
  }

  Future<List<UserProgressModel>> getUserProgress(String userId) async {
    final data = await _supabase
        .from('user_progress')
        .select()
        .eq('user_id', userId);
    return data.map((json) => UserProgressModel.fromJson(json)).toList();
  }

  Future<UserProgressModel> completeLesson({
    required String userId,
    required String unitId,
    required LessonModel lesson,
    List<QuizAnswer>? quizAnswers,
    double? score,
  }) async {
    final now = DateTime.now();
    final progressId = '${userId}_${lesson.lessonId}';

    final progress = UserProgressModel(
      progressId: progressId,
      userId: userId,
      unitId: unitId,
      refId: lesson.lessonId,
      refType: 'lesson',
      status: ProgressStatus.completed,
      score: score ?? 100,
      stars: score != null && score >= 100 ? 3 : score != null && score >= 70 ? 2 : 1,
      timeSpentSec: lesson.durationSec,
      attempts: 1,
      completedAt: now,
      quizAnswers: quizAnswers,
      createdAt: now,
      updatedAt: now,
    );

    try {
      await _supabase.from('user_progress').upsert(
        progress.toJson(),
        onConflict: 'user_id, ref_id',
      );
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'user_progress',
        'docId': progressId,
        'data': progress.toJson(),
        'operation': 'set',
        'merge': true,
        'type': 'completeLesson',
        'userId': userId,
        'unitId': unitId,
        'lessonId': lesson.lessonId,
      });
    }

    return progress;
  }

  Future<UserProgressModel> completeChallenge({
    required String userId,
    required String unitId,
    required ChallengeModel challenge,
    required double achievedValue,
    int? heartRate,
    int? duration,
  }) async {
    final now = DateTime.now();
    final progressId = '${userId}_${challenge.challengeId}';

    int stars = 0;
    if (achievedValue >= challenge.minValue) stars = 1;
    if (achievedValue >= challenge.goalValue) stars = 2;
    if (achievedValue >= challenge.maxValue) stars = 3;

    final score = ((achievedValue / challenge.maxValue) * 100).clamp(0, 100);

    final progress = UserProgressModel(
      progressId: progressId,
      userId: userId,
      unitId: unitId,
      refId: challenge.challengeId,
      refType: 'challenge',
      status: stars > 0 ? ProgressStatus.completed : ProgressStatus.failed,
      score: score.toDouble(),
      stars: stars,
      timeSpentSec: duration ?? 0,
      attempts: 1,
      completedAt: stars > 0 ? now : null,
      challengeResult: ChallengeResult(
        value: achievedValue,
        heartRate: heartRate,
        duration: duration,
      ),
      createdAt: now,
      updatedAt: now,
    );

    try {
      await _supabase.from('user_progress').upsert(
        progress.toJson(),
        onConflict: 'user_id, ref_id',
      );
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'user_progress',
        'docId': progressId,
        'data': progress.toJson(),
        'operation': 'set',
        'merge': true,
        'type': 'completeChallenge',
        'userId': userId,
        'unitId': unitId,
        'challengeId': challenge.challengeId,
      });
    }

    return progress;
  }

  Future<UserProgressModel> completeBoss({
    required String userId,
    required String unitId,
    required double score,
    required bool passed,
  }) async {
    final now = DateTime.now();
    final progressId = '${userId}_${unitId}_boss';

    final progress = UserProgressModel(
      progressId: progressId,
      userId: userId,
      unitId: unitId,
      refId: '${unitId}_boss',
      refType: 'boss',
      status: passed ? ProgressStatus.completed : ProgressStatus.failed,
      score: score,
      stars: score >= 90 ? 3 : score >= 70 ? 2 : score >= 50 ? 1 : 0,
      completedAt: passed ? now : null,
      createdAt: now,
      updatedAt: now,
    );

    try {
      await _supabase.from('user_progress').upsert(
        progress.toJson(),
        onConflict: 'user_id, ref_id',
      );
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'user_progress',
        'docId': progressId,
        'data': progress.toJson(),
        'operation': 'set',
        'merge': true,
        'type': 'completeBoss',
        'userId': userId,
        'unitId': unitId,
      });
    }

    return progress;
  }

  Future<Map<String, int>> getUnitStats(String userId, String unitId) async {
    final progress = await streamUnitProgress(userId, unitId).first;

    return {
      'total': progress.length,
      'completed':
          progress.where((p) => p.status == ProgressStatus.completed).length,
      'failed':
          progress.where((p) => p.status == ProgressStatus.failed).length,
      'threeStars':
          progress.where((p) => p.stars >= 3).length,
      'totalXP': progress.fold<int>(
          0, (sum, p) => sum + (p.stars > 0 ? 50 : 0)),
    };
  }

  Future<double> getCourseCompletion(String userId, String course) async {
    final units = await _supabase
        .from('units')
        .select('id')
        .eq('course', course)
        .eq('is_active', true);

    final totalUnits = units.length;
    if (totalUnits == 0) return 0;

    final userData = await _supabase
        .from('users')
        .select('completed_units')
        .eq('auth_id', userId)
        .single();
    final completedUnits = List<String>.from(userData['completed_units'] ?? []);

    return completedUnits.length / totalUnits;
  }
}
