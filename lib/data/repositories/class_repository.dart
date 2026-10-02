import 'dart:async';
import '../datasources/remote/class_remote_datasource.dart';
import '../../core/services/cache_service.dart';
import '../../core/services/logger_service.dart';
import '../models/class_model.dart';
import '../models/user_model.dart';

class ClassRepository {
  final ClassRemoteDataSource _dataSource;
  final CacheService? _cache;
  final LoggerService? _logger;

  ClassRepository({
    required ClassRemoteDataSource dataSource,
    CacheService? cache,
    LoggerService? logger,
  })  : _dataSource = dataSource,
        _cache = cache,
        _logger = logger;

  Stream<List<ClassModel>> streamTeacherClasses(String teacherId) {
    return _dataSource.streamTeacherClasses(teacherId);
  }

  Future<List<ClassModel>> getTeacherClasses(String teacherId) async {
    _logger?.firestore('read', 'classes', docId: 'teacher_$teacherId');
    if (_cache == null) return _dataSource.getTeacherClasses(teacherId);
    final key = 'classes_$teacherId';
    try {
      final classes = await _dataSource.getTeacherClasses(teacherId);
      await _cache.put(key, classes.map((c) => c.toJson()).toList());
      return classes;
    } catch (e) {
      _logger?.firestore('cache_hit', 'classes', docId: key, error: e);
      final cached = await _cache.get(key);
      if (cached != null) {
        return (cached as List).map((m) {
          final map = m as Map<String, dynamic>;
          return ClassModel.fromJson(map);
        }).toList();
      }
      rethrow;
    }
  }

  Stream<ClassModel?> streamClass(String classId) {
    return _dataSource.streamClass(classId);
  }

  Future<ClassModel> getClass(String classId) async {
    _logger?.firestore('read', 'classes', docId: classId);
    if (_cache == null) return _dataSource.getClass(classId);
    try {
      final classModel = await _dataSource.getClass(classId);
      await _cache.put('class_$classId', classModel.toJson());
      return classModel;
    } catch (e) {
      _logger?.firestore('cache_hit', 'classes', docId: classId, error: e);
      final cached = await _cache.get('class_$classId');
      if (cached != null) {
        return ClassModel.fromJson(cached as Map<String, dynamic>);
      }
      rethrow;
    }
  }

  Future<void> createClass(ClassModel classModel) async {
    await _dataSource.createClass(classModel);
  }

  Future<void> updateClass(String classId, Map<String, dynamic> data) async {
    await _dataSource.updateClass(classId, data);
  }

  Future<void> deleteClass(String classId) async {
    await _dataSource.deleteClass(classId);
  }

  Future<void> addStudent(String classId, String studentUid) async {
    await _dataSource.addStudent(classId, studentUid);
  }

  Future<void> removeStudent(String classId, String studentUid) async {
    await _dataSource.removeStudent(classId, studentUid);
  }

  Future<List<UserModel>> getClassStudents(String classId) async {
    return _dataSource.getClassStudents(classId);
  }

  Future<void> addCustomChallenge(String classId, CustomChallenge challenge) async {
    await _dataSource.addCustomChallenge(classId, challenge);
  }

  Future<void> removeCustomChallenge(String classId, String challengeTitle) async {
    await _dataSource.removeCustomChallenge(classId, challengeTitle);
  }

  Future<Map<String, dynamic>> getClassAnalytics(String classId) async {
    final students = await getClassStudents(classId);
    double avgXP = 0;
    double avgStreak = 0;
    final totalAttributes = <String, int>{};
    for (final student in students) {
      avgXP += student.xp;
      avgStreak += student.streak;
      student.attributes.forEach((key, value) {
        totalAttributes[key] = (totalAttributes[key] ?? 0) + value;
      });
    }
    final count = students.length.clamp(1, 999999);
    avgXP /= count;
    avgStreak /= count;
    final avgAttributes = totalAttributes.map(
      (key, value) => MapEntry(key, (value / count).round()),
    );
    return {
      'totalStudents': students.length,
      'averageXP': avgXP.round(),
      'averageStreak': avgStreak.round(),
      'averageAttributes': avgAttributes,
    };
  }

  Future<List<UserModel>> getAtRiskStudents(String classId) async {
    final students = await getClassStudents(classId);
    students.sort((a, b) => a.xp.compareTo(b.xp));
    return students.take(5).toList();
  }
}
