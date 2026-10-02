import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/avatar_providers.dart';
import '../../../data/models/shop_item_model.dart';
import '../../../core/enums/shop_item_type.dart';
import '../../../core/providers/core_providers.dart';
import '../../../features/auth/providers/auth_providers.dart';

class AvatarCustomizeScreen extends ConsumerWidget {
  const AvatarCustomizeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopAsync = ref.watch(shopItemsProvider);
    final inventoryAsync = ref.watch(inventoryProvider);
    final equippedAsync = ref.watch(equippedItemsProvider);
    final user = ref.watch(authProvider.select((s) => s.user));

    final inventory = inventoryAsync.valueOrNull ?? [];
    final ownedOutfitIds = inventory
        .where((i) {
          final item = shopAsync.valueOrNull?.firstWhere(
            (s) => s.itemId == i.itemId,
            orElse: () => ShopItemModel(
              itemId: '',
              type: ShopItemType.outfit,
              name: '',
              price: 0,
              createdAt: DateTime.now(),
            ),
          );
          return item?.type == ShopItemType.outfit;
        })
        .map((i) => i.itemId)
        .toSet();

    final equipped = equippedAsync.valueOrNull ?? [];
    final equippedIds = equipped.map((e) => e.itemId).toSet();

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Personalizar', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text('👤', style: TextStyle(fontSize: 56)),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Equipado',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 12),
            ...equipped.map((item) => Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 20),
                      const SizedBox(width: 8),
                      Text(item.name, style: const TextStyle(color: Colors.white)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (user != null) {
                            ref.read(userRepositoryProvider).equipItem(user.uid, item.itemId, false);
                            ref.invalidate(equippedItemsProvider);
                          }
                        },
                        child: const Text('Desequipar', style: TextStyle(color: Colors.red, fontSize: 12)),
                      ),
                    ],
                  ),
                )),
            if (equipped.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'No tienes nada equipado',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 24),
            const Text(
              'Tus equipamientos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 12),
            if (ownedOutfitIds.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text('Aún no tienes equipamientos',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => context.push('/avatar/shop'),
                      child:
                          const Text('Ir a la tienda', style: TextStyle(color: Color(0xFF4CAF50))),
                    ),
                  ],
                ),
              )
            else
              ...shopAsync.valueOrNull
                      ?.where((i) => ownedOutfitIds.contains(i.itemId))
                      .map((item) {
                    final isEquipped = equippedIds.contains(item.itemId);
                    return Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Text('👔', style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(item.name, style: const TextStyle(color: Colors.white)),
                          ),
                          if (isEquipped)
                            const Text('Equipado',
                                style: TextStyle(color: Color(0xFF4CAF50), fontSize: 12))
                          else
                            ElevatedButton(
                              onPressed: () {
                                if (user != null) {
                                  ref
                                      .read(userRepositoryProvider)
                                      .equipItem(user.uid, item.itemId, true);
                                  ref.invalidate(equippedItemsProvider);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                                foregroundColor: const Color(0xFF4CAF50),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('Equipar', style: TextStyle(fontSize: 12)),
                            ),
                        ],
                      ),
                    );
                  }).toList() ??
              [],
          ],
        ),
      ),
    );
  }
}
