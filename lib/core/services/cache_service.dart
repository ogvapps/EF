import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService {
  final FlutterSecureStorage _storage;
  final Map<String, _CacheEntry> _memoryCache = {};

  CacheService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> put(String key, dynamic data, {Duration ttl = const Duration(minutes: 30)}) async {
    final entry = _CacheEntry(
      data: data,
      expiresAt: DateTime.now().add(ttl),
    );
    _memoryCache[key] = entry;
    await _storage.write(key: 'cache_$key', value: jsonEncode({
      'data': data,
      'expiresAt': entry.expiresAt.toIso8601String(),
    }));
  }

  Future<dynamic> get(String key) async {
    final memEntry = _memoryCache[key];
    if (memEntry != null && !memEntry.isExpired) {
      return memEntry.data;
    }

    try {
      final raw = await _storage.read(key: 'cache_$key');
      if (raw == null) return null;

      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final expiresAt = DateTime.parse(decoded['expiresAt'] as String);
      if (DateTime.now().isAfter(expiresAt)) {
        await _storage.delete(key: 'cache_$key');
        _memoryCache.remove(key);
        return null;
      }

      final data = decoded['data'];
      _memoryCache[key] = _CacheEntry(data: data, expiresAt: expiresAt);
      return data;
    } catch (_) {
      return null;
    }
  }

  Future<void> invalidate(String key) async {
    _memoryCache.remove(key);
    await _storage.delete(key: 'cache_$key');
  }

  Future<void> clearAll() async {
    _memoryCache.clear();
    await _storage.deleteAll();
  }
}

class _CacheEntry {
  final dynamic data;
  final DateTime expiresAt;

  _CacheEntry({required this.data, required this.expiresAt});

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
