class MinigameModel {
  final String minigameId;
  final String unitId;
  final int order;
  final String type;
  final String title;
  final String description;
  final MinigameConfig config;
  final List<MinigameLevel> levels;
  final int xpReward;
  final int coinReward;
  final bool isActive;
  final DateTime createdAt;

  MinigameModel({
    required this.minigameId,
    required this.unitId,
    required this.order,
    required this.type,
    required this.title,
    this.description = '',
    required this.config,
    List<MinigameLevel>? levels,
    this.xpReward = 30,
    this.coinReward = 8,
    this.isActive = true,
    required this.createdAt,
  }) : levels = levels ?? [];

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.parse(value.toString());
  }

  factory MinigameModel.fromJson(Map<String, dynamic> data) {
    return MinigameModel(
      minigameId: data['minigame_id'] ?? data['id'] ?? '',
      unitId: data['unit_id'] ?? '',
      order: data['order'] ?? 0,
      type: data['type'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      config: MinigameConfig.fromJson(data['config'] ?? {}),
      levels: (data['levels'] as List? ?? [])
          .map((l) => MinigameLevel.fromJson(l))
          .toList(),
      xpReward: data['xp_reward'] ?? 30,
      coinReward: data['coin_reward'] ?? 8,
      isActive: data['is_active'] ?? true,
      createdAt: _parseDate(data['created_at']),
    );
  }
}

class MinigameConfig {
  final int rounds;
  final int timePerRound;
  final int difficultyLevels;
  final String? imageURL;
  final String? soundURL;

  MinigameConfig({
    this.rounds = 5,
    this.timePerRound = 15,
    this.difficultyLevels = 3,
    this.imageURL,
    this.soundURL,
  });

  factory MinigameConfig.fromJson(Map<String, dynamic> data) =>
      MinigameConfig(
        rounds: data['rounds'] ?? 5,
        timePerRound: data['timePerRound'] ?? 15,
        difficultyLevels: data['difficultyLevels'] ?? 3,
        imageURL: data['imageURL'],
        soundURL: data['soundURL'],
      );
}

class MinigameLevel {
  final int level;
  final int passScore;
  final int threeStarScore;
  final Map<String, dynamic> params;

  MinigameLevel({
    required this.level,
    this.passScore = 50,
    this.threeStarScore = 90,
    Map<String, dynamic>? params,
  }) : params = params ?? {};

  factory MinigameLevel.fromJson(Map<String, dynamic> data) =>
      MinigameLevel(
        level: data['level'] ?? 1,
        passScore: data['passScore'] ?? 50,
        threeStarScore: data['threeStarScore'] ?? 90,
        params: Map<String, dynamic>.from(data['params'] ?? {}),
      );
}
