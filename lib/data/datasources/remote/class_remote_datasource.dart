import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/class_model.dart';
import '../../models/user_model.dart';

class ClassRemoteDataSource {
  final SupabaseClient _supabase;

  ClassRemoteDataSource({required SupabaseClient supabase}) : _supabase = supabase;

  Stream<List<ClassModel>> streamTeacherClasses(String teacherId) {
    return _supabase
        .from('classes')
        .stream(primaryKey: ['id'])
        .eq('teacher_id', teacherId)
        .map((list) =>
            list.map((json) => ClassModel.fromJson(json)).toList());
  }

  Future<List<ClassModel>> getTeacherClasses(String teacherId) async {
    final data = await _supabase
        .from('classes')
        .select()
        .eq('teacher_id', teacherId);
    return data.map((json) => ClassModel.fromJson(json)).toList();
  }

  Stream<ClassModel?> streamClass(String classId) {
    return _supabase
        .from('classes')
        .stream(primaryKey: ['id'])
        .eq('id', classId)
        .map((list) => list.isNotEmpty ? ClassModel.fromJson(list.first) : null);
  }

  Future<ClassModel> getClass(String classId) async {
    final data = await _supabase
        .from('classes')
        .select()
        .eq('id', classId)
        .single();
    return ClassModel.fromJson(data);
  }

  Future<void> createClass(ClassModel classModel) async {
    await _supabase.from('classes').insert({
      'id': classModel.classId,
      'teacher_id': classModel.teacherId,
      'course': classModel.course,
      'group': classModel.group,
      'school_year': classModel.schoolYear,
      'students': classModel.students,
      'custom_challenges': classModel.customChallenges.map((c) => {
        'title': c.title,
        'description': c.description,
        'dueDate': c.dueDate.toIso8601String(),
        'xpReward': c.xpReward,
        'isActive': c.isActive,
      }).toList(),
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateClass(String classId, Map<String, dynamic> data) async {
    data['updated_at'] = DateTime.now().toIso8601String();
    await _supabase.from('classes').update(data).eq('id', classId);
  }

  Future<void> deleteClass(String classId) async {
    await _supabase.from('classes').delete().eq('id', classId);
  }

  Future<void> addStudent(String classId, String studentUid) async {
    final classDoc = await getClass(classId);
    final updated = List<String>.from(classDoc.students)..add(studentUid);
    await _supabase.from('classes').update({
      'students': updated,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', classId);
  }

  Future<void> removeStudent(String classId, String studentUid) async {
    final classDoc = await getClass(classId);
    final updated = List<String>.from(classDoc.students)..remove(studentUid);
    await _supabase.from('classes').update({
      'students': updated,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', classId);
  }

  Future<List<UserModel>> getClassStudents(String classId) async {
    final classDoc = await getClass(classId);
    if (classDoc.students.isEmpty) return [];

    try {
      final data = await _supabase
          .from('users')
          .select()
          .inFilter('auth_id', classDoc.students);
      return data.map((json) => UserModel.fromJson(json)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> addCustomChallenge(String classId, CustomChallenge challenge) async {
    final classDoc = await getClass(classId);
    final updated = List<CustomChallenge>.from(classDoc.customChallenges)
      ..add(challenge);
    final challengesJson = updated.map((c) => {
      'title': c.title,
      'description': c.description,
      'dueDate': c.dueDate.toIso8601String(),
      'xpReward': c.xpReward,
      'isActive': c.isActive,
    }).toList();
    await _supabase.from('classes').update({
      'custom_challenges': challengesJson,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', classId);
  }

  Future<void> removeCustomChallenge(String classId, String challengeTitle) async {
    final classDoc = await getClass(classId);
    final filtered = classDoc.customChallenges
        .where((c) => c.title != challengeTitle)
        .toList();
    final challengesJson = filtered.map((c) => ({
      'title': c.title,
      'description': c.description,
      'dueDate': c.dueDate.toIso8601String(),
      'xpReward': c.xpReward,
      'isActive': c.isActive,
    })).toList();
    await _supabase.from('classes').update({
      'custom_challenges': challengesJson,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', classId);
  }
}
