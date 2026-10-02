import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/core_providers.dart';
import '../../../data/models/unit_model.dart';

final unitMapProvider = FutureProvider.autoDispose.family<List<UnitModel>, String>((ref, course) {
  final repo = ref.read(unitRepositoryProvider);
  return repo.getUnits(course);
});

final unitDetailProvider = FutureProvider.autoDispose.family<UnitModel, String>((ref, unitId) {
  final repo = ref.read(unitRepositoryProvider);
  return repo.getUnit(unitId);
});
