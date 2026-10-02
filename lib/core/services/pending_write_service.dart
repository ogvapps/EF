import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cache_service.dart';
import 'logger_service.dart';
import '../providers/core_providers.dart';

class PendingWriteService {
  static const _queueKey = 'pending_writes';
  final CacheService _cache;

  PendingWriteService({required CacheService cache}) : _cache = cache;

  Future<void> enqueue(Map<String, dynamic> operation) async {
    final queue = await _getQueue();
    queue.add({
      ...operation,
      'id': '${DateTime.now().millisecondsSinceEpoch}_${queue.length}',
      'createdAt': DateTime.now().toIso8601String(),
    });
    await _saveQueue(queue);
  }

  Future<List<Map<String, dynamic>>> dequeueAll() async {
    final queue = await _getQueue();
    await _saveQueue([]);
    return queue;
  }

  Future<int> getPendingCount() async {
    final queue = await _getQueue();
    return queue.length;
  }

  Future<List<Map<String, dynamic>>> _getQueue() async {
    final data = await _cache.get(_queueKey);
    if (data == null) return [];
    return List<Map<String, dynamic>>.from(data as List);
  }

  Future<void> _saveQueue(List<Map<String, dynamic>> queue) async {
    await _cache.put(_queueKey, queue, ttl: const Duration(days: 7));
  }
}

final pendingWriteServiceProvider = Provider<PendingWriteService>((ref) {
  return PendingWriteService(cache: ref.watch(cacheServiceProvider));
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(
    supabase: ref.watch(supabaseClientProvider),
    pendingWrites: ref.watch(pendingWriteServiceProvider),
    logger: ref.watch(loggerServiceProvider),
  );
  ref.onDispose(() => service.dispose());
  return service;
});

class SyncService {
  final SupabaseClient _supabase;
  final PendingWriteService _pendingWrites;
  final LoggerService? _logger;
  bool _processing = false;

  SyncService({
    required SupabaseClient supabase,
    required PendingWriteService pendingWrites,
    LoggerService? logger,
  })  : _supabase = supabase,
        _pendingWrites = pendingWrites,
        _logger = logger;

  Future<void> processPendingWrites() async {
    if (_processing) return;
    _processing = true;

    final queue = await _pendingWrites.dequeueAll();
    if (queue.isEmpty) {
      _processing = false;
      return;
    }

    _logger?.info('Sincronizando ${queue.length} operaciones pendientes');

    final failed = <Map<String, dynamic>>[];
    for (final op in queue) {
      try {
        await _replay(op);
      } catch (e) {
        _logger?.error('Error al sincronizar operación ${op['id']}', error: e);
        failed.add(op);
      }
    }

    if (failed.isNotEmpty) {
      for (final op in failed) {
        await _pendingWrites.enqueue(op);
      }
      _logger?.warn('${failed.length} operaciones re-encoladas para reintentar');
    }

    _processing = false;
  }

  Future<void> _replay(Map<String, dynamic> op) async {
    final collection = op['collection'] as String;
    final operation = op['operation'] as String? ?? 'set';

    switch (operation) {
      case 'set':
        final data = Map<String, dynamic>.from(op['data'] as Map);
        final docId = op['docId'] as String?;
        if (collection == 'user_progress') {
          await _supabase.from(collection).upsert(data, onConflict: 'user_id, ref_id');
        } else if (collection == 'user_inventory') {
          await _supabase.from(collection).upsert(data, onConflict: 'user_id, item_id');
        } else if (collection == 'user_achievements') {
          await _supabase.from(collection).upsert(data, onConflict: 'user_id, achievement_id');
        } else if (docId != null) {
          await _supabase.from(collection).upsert({...data, 'id': docId});
        } else {
          await _supabase.from(collection).insert(data);
        }
      case 'update':
        final data = Map<String, dynamic>.from(op['data'] as Map);
        final docId = op['docId'] as String;
        final idField = _getIdField(collection);
        await _supabase.from(collection).update(data).eq(idField, docId);
      case 'delete':
        final docId = op['docId'] as String;
        final idField = _getIdField(collection);
        await _supabase.from(collection).delete().eq(idField, docId);
      case 'arrayUnion':
        final docId = op['docId'] as String;
        final field = op['field'] as String;
        final value = op['value'];
        final current = await _supabase
            .from(collection)
            .select(field)
            .eq(_getIdField(collection), docId)
            .single();
        final list = List<dynamic>.from(current[field] ?? [])..add(value);
        await _supabase
            .from(collection)
            .update({field: list})
            .eq(_getIdField(collection), docId);
      case 'increment':
        final docId = op['docId'] as String;
        final field = op['field'] as String;
        final value = op['value'] as num;
        final current = await _supabase
            .from(collection)
            .select(field)
            .eq(_getIdField(collection), docId)
            .single();
        final newVal = (current[field] as num? ?? 0) + value;
        await _supabase
            .from(collection)
            .update({field: newVal})
            .eq(_getIdField(collection), docId);
      case 'incrementFields':
        final docId = op['docId'] as String;
        final fields = Map<String, dynamic>.from(op['fields'] as Map);
        final current = await _supabase
            .from(collection)
            .select()
            .eq(_getIdField(collection), docId)
            .single();
        final updates = <String, dynamic>{};
        fields.forEach((k, v) {
          final parts = k.split('.');
          if (parts.length > 1) {
            final nested = Map<String, dynamic>.from(current[parts[0]] ?? {});
            nested[parts[1]] = (nested[parts[1]] as num? ?? 0) + (v as num);
            updates[parts[0]] = nested;
          } else {
            updates[k] = (current[k] as num? ?? 0) + (v as num);
          }
        });
        await _supabase
            .from(collection)
            .update(updates)
            .eq(_getIdField(collection), docId);
    }

    _logger?.firestore('sync_$operation', collection, docId: op['docId']);
  }

  String _getIdField(String collection) {
    switch (collection) {
      case 'users':
        return 'auth_id';
      case 'user_progress':
      case 'user_achievements':
      case 'user_inventory':
      case 'classes':
        return 'id';
      default:
        return 'id';
    }
  }

  void dispose() {}
}
