import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/avatar_providers.dart';
import '../../../data/models/shop_item_model.dart';
import '../../../core/enums/shop_item_type.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_providers.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopAsync = ref.watch(shopItemsProvider);
    final inventoryAsync = ref.watch(inventoryProvider);

    final ownedItemIds = inventoryAsync.valueOrNull?.map((i) => i.itemId).toSet() ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Tienda', style: TextStyle(color: Colors.white)),
      ),
      body: shopAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.store_outlined, size: 48, color: Colors.white.withValues(alpha: 0.2)),
                  const SizedBox(height: 12),
                  Text('No hay artículos disponibles', style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                ],
              ),
            );
          }
          final outfits = items.where((i) => i.type == ShopItemType.outfit).toList();
          final accessories = items.where((i) => i.type == ShopItemType.accessory).toList();
          final powerups = items.where((i) => i.type == ShopItemType.powerup).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Equipamientos'),
                const SizedBox(height: 12),
                ...outfits.map((item) => _ShopItemCard(
                  item: item,
                  owned: ownedItemIds.contains(item.itemId),
                  onBuy: () async {
                    final user = ref.read(authProvider).user;
                    if (user == null) return;
                    try {
                      await ref.read(shopRepositoryProvider).purchaseItem(user.uid, item.itemId);
                      ref.invalidate(inventoryProvider);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item.name} comprado')),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                  },
                )),
                const SizedBox(height: 24),
                const _SectionTitle('Accesorios'),
                const SizedBox(height: 12),
                ...accessories.map((item) => _ShopItemCard(
                  item: item,
                  owned: ownedItemIds.contains(item.itemId),
                  onBuy: () async {
                    final user = ref.read(authProvider).user;
                    if (user == null) return;
                    try {
                      await ref.read(shopRepositoryProvider).purchaseItem(user.uid, item.itemId);
                      ref.invalidate(inventoryProvider);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item.name} comprado')),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                  },
                )),
                const SizedBox(height: 24),
                const _SectionTitle('Power-ups'),
                const SizedBox(height: 12),
                ...powerups.map((item) => _ShopItemCard(
                  item: item,
                  owned: ownedItemIds.contains(item.itemId),
                  onBuy: () async {
                    final user = ref.read(authProvider).user;
                    if (user == null) return;
                    try {
                      await ref.read(shopRepositoryProvider).purchaseItem(user.uid, item.itemId);
                      ref.invalidate(inventoryProvider);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${item.name} comprado')),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                  },
                )),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off, size: 48, color: Colors.white.withValues(alpha: 0.3)),
              const SizedBox(height: 12),
              Text('$e', style: const TextStyle(color: Colors.white54)),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => ref.invalidate(shopItemsProvider),
                icon: const Icon(Icons.refresh, color: Color(0xFF4CAF50)),
                label: const Text('Reintentar', style: TextStyle(color: Color(0xFF4CAF50))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }
}

class _ShopItemCard extends StatelessWidget {
  final ShopItemModel item;
  final bool owned;
  final VoidCallback onBuy;

  const _ShopItemCard({
    required this.item,
    required this.owned,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                item.type == ShopItemType.outfit ? '👔' :
                item.type == ShopItemType.accessory ? '🎒' : '⚡',
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                    Text(
                      item.tier.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                    ),
              ],
            ),
          ),
          if (owned)
            const Text('✔️', style: TextStyle(fontSize: 20))
          else
            GestureDetector(
              onTap: onBuy,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🪙', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 4),
                    Text(
                      '${item.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
