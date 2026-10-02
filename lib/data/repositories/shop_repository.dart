import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/shop_item_model.dart';
import '../models/user_inventory_model.dart';
import '../../core/services/pending_write_service.dart';

class ShopRepository {
  final SupabaseClient _supabase;
  // ignore: unused_field
  final PendingWriteService? _pendingWrites;

  ShopRepository({SupabaseClient? supabase, PendingWriteService? pendingWrites})
      : _supabase = supabase ?? Supabase.instance.client,
        _pendingWrites = pendingWrites;

  Stream<List<ShopItemModel>> streamShopItems() {
    return _supabase
        .from('shop_items')
        .stream(primaryKey: ['id'])
        .eq('is_active', true)
        .map((list) =>
            list.map((json) => ShopItemModel.fromJson(json)).toList());
  }

  Future<List<ShopItemModel>> getShopItems() async {
    final data = await _supabase
        .from('shop_items')
        .select()
        .eq('is_active', true);
    return data.map((json) => ShopItemModel.fromJson(json)).toList();
  }

  Future<List<ShopItemModel>> getShopItemsByType(String type) async {
    final data = await _supabase
        .from('shop_items')
        .select()
        .eq('type', type)
        .eq('is_active', true);
    return data.map((json) => ShopItemModel.fromJson(json)).toList();
  }

  Future<ShopItemModel> getShopItem(String itemId) async {
    final data = await _supabase
        .from('shop_items')
        .select()
        .eq('id', itemId)
        .single();
    return ShopItemModel.fromJson(data);
  }

  Future<bool> purchaseItem(String userId, String itemId) async {
    try {
      try {
        final result = await _supabase.rpc('purchase_shop_item', params: {
          'p_item_id': itemId,
        });
        if (result is bool) return result;
        if (result is Map && result['success'] != null) return result['success'] as bool;
      } catch (_) {
        // Fallback si la función RPC aún no está creada en Supabase
        final existing = await _supabase
            .from('user_inventory')
            .select()
            .eq('user_id', userId)
            .eq('item_id', itemId)
            .maybeSingle();
        if (existing != null) return false;

        final item = await getShopItem(itemId);

        final userData = await _supabase
            .from('users')
            .select('coins')
            .eq('auth_id', userId)
            .single();
        final coins = userData['coins'] as int? ?? 0;

        if (coins < item.price) return false;

        await _supabase.from('users').update({
          'coins': coins - item.price,
          'updated_at': DateTime.now().toIso8601String(),
        }).eq('auth_id', userId);

        await _supabase.from('user_inventory').insert({
          'user_id': userId,
          'item_id': itemId,
          'acquired_at': DateTime.now().toIso8601String(),
          'is_equipped': false,
          'quantity': 1,
        });
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<UserInventoryModel>> streamInventory(String userId) {
    return _supabase
        .from('user_inventory')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .map((list) =>
            list.map((json) => UserInventoryModel.fromJson(json)).toList());
  }

  Future<List<UserInventoryModel>> getInventory(String userId) async {
    final data = await _supabase
        .from('user_inventory')
        .select()
        .eq('user_id', userId);
    return data.map((json) => UserInventoryModel.fromJson(json)).toList();
  }

  Future<List<ShopItemModel>> getOwnedItems(String userId) async {
    final inventory = await getInventory(userId);
    final itemIds = inventory.map((i) => i.itemId).toList();
    if (itemIds.isEmpty) return [];

    final items = await _supabase
        .from('shop_items')
        .select()
        .inFilter('id', itemIds);
    return items.map((json) => ShopItemModel.fromJson(json)).toList();
  }

  Future<List<ShopItemModel>> getEquippedItems(String userId) async {
    final snapshot = await _supabase
        .from('user_inventory')
        .select()
        .eq('user_id', userId)
        .eq('is_equipped', true);
    final itemIds = snapshot.map((d) => d['item_id'] as String).toList();
    if (itemIds.isEmpty) return [];

    final results = await Future.wait(itemIds.map((id) async {
      try {
        return await getShopItem(id);
      } catch (_) {
        return null;
      }
    }));
    return results.whereType<ShopItemModel>().toList();
  }
}
