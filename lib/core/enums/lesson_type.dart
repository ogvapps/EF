enum LessonType {
  video,
  quiz,
  flashcard,
  reading,
  challengePrep;

  String get value => name;

  static LessonType fromString(String s) =>
      LessonType.values.firstWhere((e) => e.name == s);
}
