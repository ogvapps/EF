import 'package:freezed_annotation/freezed_annotation.dart';

enum Difficulty {
  @JsonValue('facil')
  facil,
  @JsonValue('medio')
  medio,
  @JsonValue('dificil')
  dificil;

  String get value => name;
  int get level {
    switch (this) {
      case Difficulty.facil:
        return 1;
      case Difficulty.medio:
        return 2;
      case Difficulty.dificil:
        return 3;
    }
  }

  static Difficulty fromString(String s) =>
      Difficulty.values.firstWhere((e) => e.name == s);

  static Difficulty fromLevel(int level) {
    switch (level) {
      case 1:
        return Difficulty.facil;
      case 2:
        return Difficulty.medio;
      default:
        return Difficulty.dificil;
    }
  }

  static Difficulty fromJson(String s) => fromString(s);
  static String toJson(Difficulty d) => d.name;
}
