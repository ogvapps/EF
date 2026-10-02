import '../../core/enums/shop_item_type.dart';
import '../../core/enums/avatar_tier.dart';

class ShopItemModel {
  final String itemId;
  final ShopItemType type;
  final String name;
  final String description;
  final String imageURL;
  final int price;
  final AvatarTier tier;
  final bool isLimited;
  final DateTime? availableUntil;
  final bool isActive;
  final DateTime createdAt;

  ShopItemModel({
    required this.itemId,
    required this.type,
    required this.name,
    this.description = '',
    this.imageURL = '',
    required this.price,
    this.tier = AvatarTier.rookie,
    this.isLimited = false,
    this.availableUntil,
    this.isActive = true,
    required this.createdAt,
  });

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.parse(value.toString());
  }

  factory ShopItemModel.fromJson(Map<String, dynamic> data) {
    return ShopItemModel(
      itemId: data['item_id'] ?? data['id'] ?? '',
      type: ShopItemType.fromString(data['type'] ?? 'outfit'),
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageURL: data['image_url'] ?? '',
      price: data['price'] ?? 0,
      tier: AvatarTier.fromString(data['tier'] ?? 'rookie'),
      isLimited: data['is_limited'] ?? false,
      availableUntil: data['available_until'] != null
          ? _parseDate(data['available_until'])
          : null,
      isActive: data['is_active'] ?? true,
      createdAt: _parseDate(data['created_at']),
    );
  }
}
