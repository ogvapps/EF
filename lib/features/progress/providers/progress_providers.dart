import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../core/providers/core_providers.dart';

final courseCompletionProvider = FutureProvider.autoDispose.family<double, String>((ref, courseId) async {
  final user = ref.watch(authProvider.select((s) => s.user));
  if (user == null) return 0.0;

  final supabase = ref.read(supabaseClientProvider);
  final result = await supabase
      .from('units')
      .select('id')
      .eq('course', courseId)
      .eq('is_active', true);

  if (result.isEmpty) return 0.0;
  final totalUnits = result.length;
  final completedUnits = user.completedUnits.length;
  return (completedUnits / totalUnits).clamp(0.0, 1.0);
});

final weeklyXPProvider = FutureProvider.autoDispose<List<double>>((ref) async {
  final uid = ref.watch(currentUidProvider);
  if (uid == null) return List.filled(7, 0.0);
  final repo = ref.read(progressRepositoryProvider);
  final progress = await repo.getUserProgress(uid);

  final today = DateTime.now();
  final weekData = List<double>.filled(7, 0);

  for (final p in progress) {
    if (p.completedAt == null) continue;
    final diff = today.difference(p.completedAt!).inDays;
    if (diff >= 0 && diff < 7 && p.score != null) {
      weekData[6 - diff] += p.score!;
    }
  }
  return weekData;
});

final starsDistributionProvider = FutureProvider.autoDispose<Map<int, int>>((ref) async {
  final uid = ref.watch(currentUidProvider);
  if (uid == null) return {1: 0, 2: 0, 3: 0};
  final repo = ref.read(progressRepositoryProvider);
  final progress = await repo.getUserProgress(uid);

  return {
    1: progress.where((p) => p.stars >= 1).length,
    2: progress.where((p) => p.stars >= 2).length,
    3: progress.where((p) => p.stars >= 3).length,
  };
});
