import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/shop_item_model.dart';
import '../../../data/models/user_inventory_model.dart';
import '../../../core/enums/avatar_tier.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_providers.dart';

final shopItemsProvider = StreamProvider.autoDispose<List<ShopItemModel>>((ref) {
  return ref.read(shopRepositoryProvider).streamShopItems();
});

final inventoryProvider = FutureProvider.autoDispose<List<UserInventoryModel>>((ref) {
  final user = ref.read(authProvider).user;
  if (user == null) return [];
  return ref.read(shopRepositoryProvider).getInventory(user.uid);
});

final equippedItemsProvider = FutureProvider.autoDispose<List<ShopItemModel>>((ref) {
  final user = ref.read(authProvider).user;
  if (user == null) return [];
  return ref.read(shopRepositoryProvider).getEquippedItems(user.uid);
});

final purchaseProvider = FutureProvider.autoDispose.family<bool, String>((ref, itemId) async {
  final user = ref.read(authProvider).user;
  if (user == null) return false;
  return ref.read(shopRepositoryProvider).purchaseItem(user.uid, itemId);
});

final avatarTierProvider = Provider<AvatarTier>((ref) {
  final user = ref.watch(authProvider.select((s) => s.user));
  return AvatarTier.fromLevel(user?.level ?? 1);
});

final nextLevelXPProvider = Provider<int>((ref) {
  final user = ref.watch(authProvider.select((s) => s.user));
  if (user == null) return 500;
  final level = user.level;
  final xp = user.xp;
  final xpForCurrentLevel = (level - 1) * 500;
  final xpInLevel = xp - xpForCurrentLevel;
  return 500 - xpInLevel;
});
