import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/achievement_model.dart';

class AchievementRepository {
  final SupabaseClient _supabase;

  AchievementRepository({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;

  Stream<List<AchievementModel>> streamAchievements() {
    return _supabase
        .from('achievements')
        .stream(primaryKey: ['id'])
        .eq('is_active', true)
        .map((list) =>
            list.map((json) => AchievementModel.fromJson(json)).toList());
  }

  Future<List<AchievementModel>> getAchievements() async {
    final data = await _supabase
        .from('achievements')
        .select()
        .eq('is_active', true);
    return data.map((json) => AchievementModel.fromJson(json)).toList();
  }

  Future<AchievementModel> getAchievement(String achievementId) async {
    final data = await _supabase
        .from('achievements')
        .select()
        .eq('id', achievementId)
        .single();
    return AchievementModel.fromJson(data);
  }

  Future<Map<String, dynamic>> getUserAchievementsWithDetails(String userId) async {
    final allAchievements = await getAchievements();
    final userAchData = await _supabase
        .from('user_achievements')
        .select()
        .eq('user_id', userId);

    final unlockedIds = userAchData
        .map((d) => d['achievement_id'] as String)
        .toSet();

    final progressMap = <String, int>{};
    for (final d in userAchData) {
      progressMap[d['achievement_id'] as String] = d['progress'] ?? 100;
    }

    return {
      'achievements': allAchievements,
      'unlockedIds': unlockedIds,
      'progressMap': progressMap,
    };
  }

  Future<List<AchievementModel>> checkAndUnlock(
      String userId, Map<String, dynamic> context) async {
    final allAchievements = await getAchievements();
    final unlocked = <AchievementModel>[];

    for (final achievement in allAchievements) {
      final alreadyUnlocked = await _supabase
          .from('user_achievements')
          .select()
          .eq('user_id', userId)
          .eq('achievement_id', achievement.achievementId)
          .maybeSingle();

      if (alreadyUnlocked != null) continue;

      final earned = _evaluateCondition(achievement.condition, context);
      if (earned) {
        await _supabase.from('user_achievements').insert({
          'user_id': userId,
          'achievement_id': achievement.achievementId,
          'unlocked_at': DateTime.now().toIso8601String(),
          'progress': 100,
          'is_complete': true,
          'claimed': false,
        });
        unlocked.add(achievement);
      }
    }

    return unlocked;
  }

  Future<void> claimReward(String userId, String achievementId) async {
    await _supabase
        .from('user_achievements')
        .update({'claimed': true})
        .eq('user_id', userId)
        .eq('achievement_id', achievementId);
  }

  bool _evaluateCondition(
      AchievementCondition condition, Map<String, dynamic> context) {
    final value = context[condition.type];
    if (value == null) return false;
    return (value as num) >= condition.target;
  }
}
