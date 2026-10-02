import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../models/user_progress_model.dart';
import '../models/user_inventory_model.dart';
import '../../core/services/pending_write_service.dart';

class UserRepository {
  final SupabaseClient _supabase;
  final PendingWriteService? _pendingWrites;

  UserRepository({SupabaseClient? supabase, PendingWriteService? pendingWrites})
      : _supabase = supabase ?? Supabase.instance.client,
        _pendingWrites = pendingWrites;

  Stream<UserModel?> streamUser(String uid) {
    return _supabase
        .from('users')
        .stream(primaryKey: ['auth_id'])
        .eq('auth_id', uid)
        .map((list) => list.isNotEmpty ? UserModel.fromJson(list.first) : null);
  }

  Future<UserModel> getUser(String uid) async {
    final data = await _supabase
        .from('users')
        .select()
        .eq('auth_id', uid)
        .single();
    return UserModel.fromJson(data);
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    data['updated_at'] = DateTime.now().toIso8601String();
    try {
      await _supabase.from('users').update(data).eq('auth_id', uid);
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'users',
        'docId': uid,
        'data': data,
        'operation': 'update',
        'type': 'updateUser',
      });
    }
  }

  Future<void> addXP(String uid, int amount) async {
    try {
      try {
        await _supabase.rpc('increment_user_xp', params: {'p_amount': amount});
        return;
      } catch (_) {}

      final user = await getUser(uid);
      final newXP = user.xp + amount;
      final newLevel = (newXP / 500).floor() + 1;
      await _supabase.from('users').update({
        'xp': newXP,
        'level': newLevel,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('auth_id', uid);
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'users',
        'docId': uid,
        'operation': 'increment',
        'field': 'xp',
        'value': amount,
        'type': 'addXP',
      });
    }
  }

  Future<void> addCoins(String uid, int amount) async {
    try {
      try {
        await _supabase.rpc('increment_user_coins', params: {'p_amount': amount});
        return;
      } catch (_) {}

      final user = await getUser(uid);
      await _supabase.from('users').update({
        'coins': user.coins + amount,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('auth_id', uid);
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'users',
        'docId': uid,
        'operation': 'increment',
        'field': 'coins',
        'value': amount,
        'type': 'addCoins',
      });
    }
  }

  Future<bool> spendCoins(String uid, int amount) async {
    try {
      final user = await getUser(uid);
      if (user.coins < amount) return false;
      await _supabase.from('users').update({
        'coins': user.coins - amount,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('auth_id', uid);
      return true;
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'users',
        'docId': uid,
        'operation': 'increment',
        'field': 'coins',
        'value': -amount,
        'type': 'spendCoins',
      });
      return true;
    }
  }

  Future<void> addAttributes(String uid, Map<String, int> increments) async {
    try {
      final user = await getUser(uid);
      final attrs = Map<String, int>.from(user.attributes);
      increments.forEach((key, value) {
        attrs[key] = (attrs[key] ?? 0) + value;
      });
      await _supabase.from('users').update({
        'attributes': attrs,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('auth_id', uid);
    } catch (e) {
      final fields = <String, dynamic>{};
      increments.forEach((k, v) => fields['attributes.$k'] = v);
      await _pendingWrites?.enqueue({
        'collection': 'users',
        'docId': uid,
        'operation': 'incrementFields',
        'fields': fields,
        'type': 'addAttributes',
      });
    }
  }

  Future<void> updateStreak(String uid) async {
    try {
      final user = await getUser(uid);
      final now = DateTime.now();
      final lastActive = user.lastActiveDate;
      final today = DateTime(now.year, now.month, now.day);
      final lastDay = DateTime(lastActive.year, lastActive.month, lastActive.day);
      final diff = today.difference(lastDay).inDays;

      int newStreak;
      if (diff == 1) {
        newStreak = user.streak + 1;
      } else if (diff == 0) {
        newStreak = user.streak;
      } else {
        newStreak = 1;
      }

      await _supabase.from('users').update({
        'streak': newStreak,
        'last_active_date': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      }).eq('auth_id', uid);
    } catch (e) {
      final now = DateTime.now().toIso8601String();
      await _pendingWrites?.enqueue({
        'collection': 'users',
        'docId': uid,
        'data': {'lastActiveDate': now, 'updatedAt': now},
        'operation': 'update',
        'type': 'updateStreak',
      });
    }
  }

  Stream<List<UserProgressModel>> streamUnitProgress(String uid, String unitId) {
    return _supabase
        .from('user_progress')
        .stream(primaryKey: ['id'])
        .eq('user_id', uid)
        .map((list) => list
            .where((p) => p['unit_id'] == unitId)
            .map((json) => UserProgressModel.fromJson(json))
            .toList());
  }

  Future<void> completeUnit(String uid, String unitId) async {
    try {
      final user = await getUser(uid);
      final updated = List<String>.from(user.completedUnits)..add(unitId);
      await _supabase.from('users').update({
        'completed_units': updated,
        'current_unit_id': null,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('auth_id', uid);
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'users',
        'docId': uid,
        'operation': 'arrayUnion',
        'field': 'completedUnits',
        'value': unitId,
        'type': 'completeUnit',
      });
    }
  }

  Future<void> setCurrentUnit(String uid, String unitId) async {
    try {
      await _supabase.from('users').update({
        'current_unit_id': unitId,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('auth_id', uid);
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'users',
        'docId': uid,
        'data': {'currentUnitId': unitId},
        'operation': 'update',
        'type': 'setCurrentUnit',
      });
    }
  }

  Stream<List<UserAchievementModel>> streamAchievements(String uid) {
    return _supabase
        .from('user_achievements')
        .stream(primaryKey: ['id'])
        .eq('user_id', uid)
        .map((list) =>
            list.map((json) => UserAchievementModel.fromJson(json)).toList());
  }

  Future<void> unlockAchievement(String uid, String achievementId) async {
    final now = DateTime.now().toIso8601String();
    final data = {
      'user_id': uid,
      'achievement_id': achievementId,
      'unlocked_at': now,
      'progress': 100,
      'is_complete': true,
      'claimed': false,
    };

    try {
      final existing = await _supabase
          .from('user_achievements')
          .select()
          .eq('user_id', uid)
          .eq('achievement_id', achievementId)
          .maybeSingle();
      if (existing != null) return;
      await _supabase.from('user_achievements').insert(data);
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'user_achievements',
        'docId': '${uid}_$achievementId',
        'data': data,
        'operation': 'set',
        'merge': false,
        'type': 'unlockAchievement',
      });
    }
  }

  Stream<List<UserInventoryModel>> streamInventory(String uid) {
    return _supabase
        .from('user_inventory')
        .stream(primaryKey: ['id'])
        .eq('user_id', uid)
        .map((list) =>
            list.map((json) => UserInventoryModel.fromJson(json)).toList());
  }

  Future<void> addItemToInventory(String uid, String itemId) async {
    final data = {
      'user_id': uid,
      'item_id': itemId,
      'acquired_at': DateTime.now().toIso8601String(),
      'is_equipped': false,
      'quantity': 1,
    };
    try {
      await _supabase.from('user_inventory').insert(data);
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'user_inventory',
        'docId': '${uid}_$itemId',
        'data': data,
        'operation': 'set',
        'merge': false,
        'type': 'addItemToInventory',
      });
    }
  }

  Future<void> equipItem(String uid, String itemId, bool equipped) async {
    final id = '${uid}_$itemId';
    try {
      if (equipped) {
        final equippedItems = await _supabase
            .from('user_inventory')
            .select()
            .eq('user_id', uid)
            .eq('is_equipped', true);

        for (final item in equippedItems) {
          await _supabase
              .from('user_inventory')
              .update({'is_equipped': false})
              .eq('id', item['id']);
        }
        await _supabase
            .from('user_inventory')
            .update({'is_equipped': true})
            .eq('user_id', uid)
            .eq('item_id', itemId);
      } else {
        await _supabase
            .from('user_inventory')
            .update({'is_equipped': false})
            .eq('user_id', uid)
            .eq('item_id', itemId);
      }
    } catch (e) {
      await _pendingWrites?.enqueue({
        'collection': 'user_inventory',
        'docId': id,
        'data': {'isEquipped': equipped},
        'operation': 'update',
        'type': 'equipItem',
      });
    }
  }

  Stream<List<UserModel>> streamLeaderboard(String course, int limit) {
    return _supabase
        .from('users')
        .stream(primaryKey: ['auth_id'])
        .eq('is_active', true)
        .order('xp', ascending: false)
        .limit(limit)
        .map((list) => list
            .where((u) => u['role'] == 'alumno' && u['course'] == course)
            .map((json) => UserModel.fromJson(json))
            .toList());
  }
}

class UserAchievementModel {
  final String userAchievementId;
  final String userId;
  final String achievementId;
  final DateTime unlockedAt;
  final int progress;
  final bool isComplete;
  final bool claimed;

  UserAchievementModel({
    required this.userAchievementId,
    required this.userId,
    required this.achievementId,
    required this.unlockedAt,
    this.progress = 0,
    this.isComplete = false,
    this.claimed = false,
  });

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.parse(value.toString());
  }

  factory UserAchievementModel.fromJson(Map<String, dynamic> data) {
    return UserAchievementModel(
      userAchievementId: data['id'] ?? '${data['user_id']}_${data['achievement_id']}',
      userId: data['user_id'] ?? '',
      achievementId: data['achievement_id'] ?? '',
      unlockedAt: _parseDate(data['unlocked_at']),
      progress: data['progress'] ?? 0,
      isComplete: data['is_complete'] ?? false,
      claimed: data['claimed'] ?? false,
    );
  }
}
