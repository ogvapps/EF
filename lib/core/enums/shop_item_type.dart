enum ShopItemType {
  outfit,
  accessory,
  powerup,
  special;

  String get value => name;

  static ShopItemType fromString(String s) =>
      ShopItemType.values.firstWhere((e) => e.name == s);
}
