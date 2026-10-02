import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/unit_model.dart';
import '../../models/lesson_model.dart';
import '../../models/challenge_model.dart';
import '../../models/minigame_model.dart';

class UnitRemoteDataSource {
  final SupabaseClient _supabase;

  UnitRemoteDataSource({required SupabaseClient supabase}) : _supabase = supabase;

  Stream<List<UnitModel>> streamUnits(String course) {
    return _supabase
        .from('units')
        .stream(primaryKey: ['id'])
        .eq('is_active', true)
        .order('order')
        .map((list) => list
            .where((u) => u['course'] == course)
            .map((json) => UnitModel.fromJson(json))
            .toList());
  }

  Future<List<UnitModel>> getUnits(String course) async {
    final data = await _supabase
        .from('units')
        .select()
        .eq('course', course)
        .eq('is_active', true)
        .order('order');
    return data.map((json) => UnitModel.fromJson(json)).toList();
  }

  Stream<UnitModel?> streamUnit(String unitId) {
    return _supabase
        .from('units')
        .stream(primaryKey: ['id'])
        .eq('id', unitId)
        .map((list) => list.isNotEmpty ? UnitModel.fromJson(list.first) : null);
  }

  Future<UnitModel> getUnit(String unitId) async {
    final data = await _supabase
        .from('units')
        .select()
        .eq('id', unitId)
        .single();
    return UnitModel.fromJson(data);
  }

  Future<List<UnitModel>> getUnitsByTrimester(String course, int trimester) async {
    final data = await _supabase
        .from('units')
        .select()
        .eq('course', course)
        .eq('trimester', trimester)
        .eq('is_active', true)
        .order('order');
    return data.map((json) => UnitModel.fromJson(json)).toList();
  }

  Stream<List<LessonModel>> streamLessons(String unitId) {
    return _supabase
        .from('lessons')
        .stream(primaryKey: ['id'])
        .eq('unit_id', unitId)
        .order('order')
        .map((list) => list
            .where((l) => l['is_active'] == true)
            .map((json) => LessonModel.fromJson(json))
            .toList());
  }

  Future<List<LessonModel>> getLessons(String unitId) async {
    final data = await _supabase
        .from('lessons')
        .select()
        .eq('unit_id', unitId)
        .eq('is_active', true)
        .order('order');
    return data.map((json) => LessonModel.fromJson(json)).toList();
  }

  Future<LessonModel> getLesson(String unitId, String lessonId) async {
    final data = await _supabase
        .from('lessons')
        .select()
        .eq('id', lessonId)
        .eq('unit_id', unitId)
        .single();
    return LessonModel.fromJson(data);
  }

  Stream<List<ChallengeModel>> streamChallenges(String unitId) {
    return _supabase
        .from('challenges')
        .stream(primaryKey: ['id'])
        .eq('unit_id', unitId)
        .order('order')
        .map((list) => list
            .where((c) => c['is_active'] == true)
            .map((json) => ChallengeModel.fromJson(json))
            .toList());
  }

  Future<List<ChallengeModel>> getChallenges(String unitId) async {
    final data = await _supabase
        .from('challenges')
        .select()
        .eq('unit_id', unitId)
        .eq('is_active', true)
        .order('order');
    return data.map((json) => ChallengeModel.fromJson(json)).toList();
  }

  Future<ChallengeModel> getChallenge(String unitId, String challengeId) async {
    final data = await _supabase
        .from('challenges')
        .select()
        .eq('id', challengeId)
        .eq('unit_id', unitId)
        .single();
    return ChallengeModel.fromJson(data);
  }

  Stream<List<MinigameModel>> streamMinigames(String unitId) {
    return _supabase
        .from('minigames')
        .stream(primaryKey: ['id'])
        .eq('unit_id', unitId)
        .order('order')
        .map((list) => list
            .where((m) => m['is_active'] == true)
            .map((json) => MinigameModel.fromJson(json))
            .toList());
  }

  Future<List<MinigameModel>> getMinigames(String unitId) async {
    final data = await _supabase
        .from('minigames')
        .select()
        .eq('unit_id', unitId)
        .eq('is_active', true)
        .order('order');
    return data.map((json) => MinigameModel.fromJson(json)).toList();
  }

  Stream<Map<String, dynamic>?> streamBoss(String unitId) {
    return _supabase
        .from('boss')
        .stream(primaryKey: ['id', 'unit_id'])
        .eq('unit_id', unitId)
        .map((list) => list.isNotEmpty ? list.first : null);
  }

  Future<Map<String, dynamic>?> getBoss(String unitId) async {
    final data = await _supabase
        .from('boss')
        .select()
        .eq('unit_id', unitId)
        .maybeSingle();
    return data;
  }
}
