export 'auth_provider.dart';
import 'auth_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/class_model.dart';
import '../../../core/providers/core_providers.dart';

final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authProvider.select((s) => s.user));
});

final currentUidProvider = Provider<String?>((ref) {
  return ref.watch(authProvider.select((s) => s.user?.uid));
});

final leaderboardProvider = StreamProvider<List<UserModel>>((ref) {
  final user = ref.watch(authProvider.select((s) => s.user));
  if (user == null) return Stream<List<UserModel>>.value([]);
  return ref.read(userRepositoryProvider).streamLeaderboard(user.course, 50);
});

final teacherClassesProvider = StreamProvider<List<ClassModel>>((ref) {
  final user = ref.watch(authProvider.select((s) => s.user));
  if (user == null) return Stream<List<ClassModel>>.value([]);
  return ref.read(classRepositoryProvider).streamTeacherClasses(user.uid);
});

final userAttributesProvider = Provider<Map<String, int>>((ref) {
  final user = ref.watch(authProvider.select((s) => s.user));
  return user?.attributes ?? {};
});
