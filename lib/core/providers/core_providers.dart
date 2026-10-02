import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/repositories/repositories.dart';
import '../../data/datasources/datasources.dart';
import '../services/cache_service.dart';
import '../services/logger_service.dart';
import '../services/pending_write_service.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final cacheServiceProvider = Provider<CacheService>((ref) {
  return CacheService();
});

final loggerServiceProvider = Provider<LoggerService>((ref) {
  return LoggerService();
});

final unitRemoteDataSourceProvider = Provider<UnitRemoteDataSource>((ref) {
  return UnitRemoteDataSource(supabase: ref.watch(supabaseClientProvider));
});

final classRemoteDataSourceProvider = Provider<ClassRemoteDataSource>((ref) {
  return ClassRemoteDataSource(supabase: ref.watch(supabaseClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    supabase: ref.watch(supabaseClientProvider),
    logger: ref.watch(loggerServiceProvider),
  );
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(
    supabase: ref.watch(supabaseClientProvider),
    pendingWrites: ref.watch(pendingWriteServiceProvider),
  );
});

final unitRepositoryProvider = Provider<UnitRepository>((ref) {
  return UnitRepository(
    dataSource: ref.watch(unitRemoteDataSourceProvider),
    cache: ref.watch(cacheServiceProvider),
    logger: ref.watch(loggerServiceProvider),
  );
});

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return ProgressRepository(
    supabase: ref.watch(supabaseClientProvider),
    pendingWrites: ref.watch(pendingWriteServiceProvider),
  );
});

final achievementRepositoryProvider = Provider<AchievementRepository>((ref) {
  return AchievementRepository(supabase: ref.watch(supabaseClientProvider));
});

final shopRepositoryProvider = Provider<ShopRepository>((ref) {
  return ShopRepository(
    supabase: ref.watch(supabaseClientProvider),
    pendingWrites: ref.watch(pendingWriteServiceProvider),
  );
});

final classRepositoryProvider = Provider<ClassRepository>((ref) {
  return ClassRepository(
    dataSource: ref.watch(classRemoteDataSourceProvider),
    cache: ref.watch(cacheServiceProvider),
    logger: ref.watch(loggerServiceProvider),
  );
});
