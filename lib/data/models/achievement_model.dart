import '../../core/enums/achievement_category.dart';
import '../../core/enums/achievement_rarity.dart';

class AchievementModel {
  final String achievementId;
  final String title;
  final String description;
  final String iconURL;
  final AchievementCategory category;
  final AchievementRarity rarity;
  final AchievementCondition condition;
  final int xpReward;
  final int coinReward;
  final Map<String, int> attributeReward;
  final bool isActive;
  final DateTime createdAt;

  AchievementModel({
    required this.achievementId,
    required this.title,
    this.description = '',
    this.iconURL = '',
    this.category = AchievementCategory.special,
    this.rarity = AchievementRarity.comun,
    required this.condition,
    this.xpReward = 100,
    this.coinReward = 25,
    Map<String, int>? attributeReward,
    this.isActive = true,
    required this.createdAt,
  }) : attributeReward = attributeReward ?? {};

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.parse(value.toString());
  }

  factory AchievementModel.fromJson(Map<String, dynamic> data) {
    return AchievementModel(
      achievementId: data['achievement_id'] ?? data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      iconURL: data['icon_url'] ?? '',
      category: AchievementCategory.fromString(data['category'] ?? 'special'),
      rarity: AchievementRarity.fromString(data['rarity'] ?? 'comun'),
      condition: AchievementCondition.fromJson(data['condition'] ?? {}),
      xpReward: data['xp_reward'] ?? 100,
      coinReward: data['coin_reward'] ?? 25,
      attributeReward: Map<String, int>.from(data['attribute_reward'] ?? {}),
      isActive: data['is_active'] ?? true,
      createdAt: _parseDate(data['created_at']),
    );
  }
}

class AchievementCondition {
  final String type;
  final int target;
  final Map<String, dynamic> params;

  AchievementCondition({
    required this.type,
    required this.target,
    Map<String, dynamic>? params,
  }) : params = params ?? {};

  factory AchievementCondition.fromJson(Map<String, dynamic> data) =>
      AchievementCondition(
        type: data['type'] ?? '',
        target: data['target'] ?? 0,
        params: Map<String, dynamic>.from(data['params'] ?? {}),
      );
}
