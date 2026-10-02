import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/avatar_providers.dart';
import '../../../core/enums/shop_item_type.dart';
import '../../../data/models/shop_item_model.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopAsync = ref.watch(shopItemsProvider);
    final inventoryAsync = ref.watch(inventoryProvider);

    final shopItems = shopAsync.valueOrNull ?? [];
    final inventory = inventoryAsync.valueOrNull ?? [];

    final ownedIds = inventory.map((i) => i.itemId).toSet();
    final ownedItems = shopItems.where((i) => ownedIds.contains(i.itemId)).toList();

    final outfits = ownedItems.where((i) => i.type == ShopItemType.outfit).toList();
    final accessories = ownedItems.where((i) => i.type == ShopItemType.accessory).toList();
    final powerups = ownedItems.where((i) => i.type == ShopItemType.powerup).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Inventario', style: TextStyle(color: Colors.white)),
      ),
      body: inventoryAsync.when(
        data: (_) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Section('Equipamientos', outfits),
              const SizedBox(height: 20),
              _Section('Accesorios', accessories),
              const SizedBox(height: 20),
              _Section('Power-ups', powerups),
              if (ownedItems.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Center(
                    child: Column(
                      children: [
                        const Text('📦', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text('Inventario vacío',
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                        const SizedBox(height: 4),
                        Text('Compra objetos en la tienda',
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.2), fontSize: 12)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e', style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<ShopItemModel> items;

  const _Section(this.title, this.items);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 12),
        ...items.map((item) => Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(item.type == ShopItemType.outfit ? '👔' : item.type == ShopItemType.accessory ? '🎒' : '⚡',
                      style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Text(item.name, style: const TextStyle(color: Colors.white)),
                ],
              ),
            )),
      ],
    );
  }
}
