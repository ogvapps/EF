class UserInventoryModel {
  final String inventoryId;
  final String userId;
  final String itemId;
  final DateTime acquiredAt;
  final bool isEquipped;
  final int quantity;

  UserInventoryModel({
    required this.inventoryId,
    required this.userId,
    required this.itemId,
    required this.acquiredAt,
    this.isEquipped = false,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'item_id': itemId,
        'acquired_at': acquiredAt.toIso8601String(),
        'is_equipped': isEquipped,
        'quantity': quantity,
      };

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.parse(value.toString());
  }

  factory UserInventoryModel.fromJson(Map<String, dynamic> data) {
    return UserInventoryModel(
      inventoryId: data['inventory_id'] ?? '${data['user_id']}_${data['item_id']}',
      userId: data['user_id'] ?? '',
      itemId: data['item_id'] ?? '',
      acquiredAt: _parseDate(data['acquired_at']),
      isEquipped: data['is_equipped'] ?? false,
      quantity: data['quantity'] ?? 1,
    );
  }

  UserInventoryModel copyWith({
    bool? isEquipped,
    int? quantity,
  }) =>
      UserInventoryModel(
        inventoryId: inventoryId,
        userId: userId,
        itemId: itemId,
        acquiredAt: acquiredAt,
        isEquipped: isEquipped ?? this.isEquipped,
        quantity: quantity ?? this.quantity,
      );
}
