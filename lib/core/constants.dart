class AppConstants {
  AppConstants._();

  // Game mechanics
  static const int xpPerLevel = 500;
  static const int xpDailyChallenge = 150;
  static const int maxStreakDays = 365;
  static const int coinsPerLesson = 10;
  static const int coinsPerUnitComplete = 50;

  // Limits
  static const int maxLevel = 100;
  static const int maxAttributes = 100;
  static const int inventoryMaxItems = 50;

  // Timings
  static const int challengeCountdownSeconds = 3;
  static const int bossPhaseDurationSeconds = 30;
  static const int cacheTtlMinutes = 15;
}
