import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/core_providers.dart';
import '../../../data/models/unit_model.dart';
import '../../../data/models/lesson_model.dart';
import '../../../data/models/challenge_model.dart';
import '../../../data/models/minigame_model.dart';
import '../../../data/models/user_progress_model.dart';
import '../../auth/providers/auth_providers.dart';

// ── Unidad ──
final unitStreamProvider = StreamProvider.autoDispose.family<UnitModel?, String>((ref, unitId) {
  final repo = ref.read(unitRepositoryProvider);
  return repo.streamUnit(unitId);
});

// ── Lecciones ──
final lessonListProvider = FutureProvider.autoDispose.family<List<LessonModel>, String>((ref, unitId) {
  final repo = ref.read(unitRepositoryProvider);
  return repo.getLessons(unitId);
});

final lessonStreamProvider = StreamProvider.autoDispose.family<List<LessonModel>, String>((ref, unitId) {
  final repo = ref.read(unitRepositoryProvider);
  return repo.streamLessons(unitId);
});

final lessonDetailProvider = FutureProvider.autoDispose.family<LessonModel, ({String unitId, String lessonId})>(
  (ref, params) {
    final repo = ref.read(unitRepositoryProvider);
    return repo.getLesson(params.unitId, params.lessonId);
  },
);

// ── Retos ──
final challengeListProvider = FutureProvider.autoDispose.family<List<ChallengeModel>, String>((ref, unitId) {
  final repo = ref.read(unitRepositoryProvider);
  return repo.getChallenges(unitId);
});

final challengeStreamProvider = StreamProvider.autoDispose.family<List<ChallengeModel>, String>((ref, unitId) {
  final repo = ref.read(unitRepositoryProvider);
  return repo.streamChallenges(unitId);
});

final challengeDetailProvider = FutureProvider.autoDispose.family<ChallengeModel, ({String unitId, String challengeId})>(
  (ref, params) {
    final repo = ref.read(unitRepositoryProvider);
    return repo.getChallenge(params.unitId, params.challengeId);
  },
);

// ── Minijuegos ──
final minigameListProvider = FutureProvider.autoDispose.family<List<MinigameModel>, String>((ref, unitId) {
  final repo = ref.read(unitRepositoryProvider);
  return repo.getMinigames(unitId);
});

// ── Boss ──
final bossProvider = FutureProvider.autoDispose.family<Map<String, dynamic>?, String>((ref, unitId) {
  final repo = ref.read(unitRepositoryProvider);
  return repo.getBoss(unitId);
});

final bossStreamProvider = StreamProvider.autoDispose.family<Map<String, dynamic>?, String>((ref, unitId) {
  final repo = ref.read(unitRepositoryProvider);
  return repo.streamBoss(unitId);
});

final unitProgressProvider = StreamProvider.autoDispose.family<List<UserProgressModel>, String>((ref, unitId) {
  final uid = ref.watch(currentUidProvider);
  if (uid == null) return const Stream.empty();
  return ref.read(userRepositoryProvider).streamUnitProgress(uid, unitId);
});
