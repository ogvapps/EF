import 'dart:async';
import '../datasources/remote/unit_remote_datasource.dart';
import '../../core/services/cache_service.dart';
import '../../core/services/logger_service.dart';
import '../models/unit_model.dart';
import '../models/lesson_model.dart';
import '../models/challenge_model.dart';
import '../models/minigame_model.dart';

class UnitRepository {
  final UnitRemoteDataSource _dataSource;
  final CacheService? _cache;
  final LoggerService? _logger;

  UnitRepository({
    required UnitRemoteDataSource dataSource,
    CacheService? cache,
    LoggerService? logger,
  })  : _dataSource = dataSource,
        _cache = cache,
        _logger = logger;

  Stream<List<UnitModel>> streamUnits(String course) {
    return _dataSource.streamUnits(course);
  }

  Future<List<UnitModel>> getUnits(String course) async {
    _logger?.firestore('read', 'units', docId: course);
    if (_cache == null) return _dataSource.getUnits(course);
    try {
      final units = await _dataSource.getUnits(course);
      await _cache.put('units_$course',
          units.map((u) => u.toJson()).toList());
      return units;
    } catch (e) {
      _logger?.firestore('cache_hit', 'units', docId: course, error: e);
      final cached = await _cache.get('units_$course');
      if (cached != null) {
        return (cached as List).map((m) {
          final map = m as Map<String, dynamic>;
          return UnitModel.fromJson(map);
        }).toList();
      }
      rethrow;
    }
  }

  Stream<UnitModel?> streamUnit(String unitId) {
    return _dataSource.streamUnit(unitId);
  }

  Future<UnitModel> getUnit(String unitId) async {
    _logger?.firestore('read', 'units', docId: unitId);
    if (_cache == null) return _dataSource.getUnit(unitId);
    try {
      final unit = await _dataSource.getUnit(unitId);
      await _cache.put('unit_$unitId', unit.toJson());
      return unit;
    } catch (e) {
      _logger?.firestore('cache_hit', 'units', docId: unitId, error: e);
      final cached = await _cache.get('unit_$unitId');
      if (cached != null) {
        return UnitModel.fromJson(cached as Map<String, dynamic>);
      }
      rethrow;
    }
  }

  Future<List<UnitModel>> getUnitsByTrimester(String course, int trimester) async {
    _logger?.firestore('read', 'units', docId: '${course}_t$trimester');
    if (_cache == null) return _dataSource.getUnitsByTrimester(course, trimester);
    final key = 'units_${course}_t$trimester';
    try {
      final units = await _dataSource.getUnitsByTrimester(course, trimester);
      await _cache.put(key, units.map((u) => u.toJson()).toList());
      return units;
    } catch (e) {
      _logger?.firestore('cache_hit', 'units', docId: key, error: e);
      final cached = await _cache.get(key);
      if (cached != null) {
        return (cached as List).map((m) {
          final map = m as Map<String, dynamic>;
          return UnitModel.fromJson(map);
        }).toList();
      }
      rethrow;
    }
  }

  Stream<List<LessonModel>> streamLessons(String unitId) {
    return _dataSource.streamLessons(unitId);
  }

  Future<List<LessonModel>> getLessons(String unitId) async {
    return _dataSource.getLessons(unitId);
  }

  Future<LessonModel> getLesson(String unitId, String lessonId) async {
    return _dataSource.getLesson(unitId, lessonId);
  }

  Stream<List<ChallengeModel>> streamChallenges(String unitId) {
    return _dataSource.streamChallenges(unitId);
  }

  Future<List<ChallengeModel>> getChallenges(String unitId) async {
    return _dataSource.getChallenges(unitId);
  }

  Future<ChallengeModel> getChallenge(String unitId, String challengeId) async {
    return _dataSource.getChallenge(unitId, challengeId);
  }

  Stream<List<MinigameModel>> streamMinigames(String unitId) {
    return _dataSource.streamMinigames(unitId);
  }

  Future<List<MinigameModel>> getMinigames(String unitId) async {
    return _dataSource.getMinigames(unitId);
  }

  Future<Map<String, dynamic>?> getBoss(String unitId) async {
    return _dataSource.getBoss(unitId);
  }

  Stream<Map<String, dynamic>?> streamBoss(String unitId) {
    return _dataSource.streamBoss(unitId);
  }
}
