enum AchievementCategory {
  streak,
  units,
  attributes,
  social,
  special;

  String get value => name;

  static AchievementCategory fromString(String s) =>
      AchievementCategory.values.firstWhere((e) => e.name == s);
}
