enum AchievementRarity {
  comun,
  raro,
  epico,
  legendario;

  String get value => name;
  String get displayName {
    switch (this) {
      case AchievementRarity.comun:
        return 'Común';
      case AchievementRarity.raro:
        return 'Raro';
      case AchievementRarity.epico:
        return 'Épico';
      case AchievementRarity.legendario:
        return 'Legendario';
    }
  }

  static AchievementRarity fromString(String s) =>
      AchievementRarity.values.firstWhere((e) => e.name == s);
}
