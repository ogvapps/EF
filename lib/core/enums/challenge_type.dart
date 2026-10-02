import 'package:freezed_annotation/freezed_annotation.dart';

enum ChallengeType {
  @JsonValue('steps')
  steps,
  @JsonValue('mobility')
  mobility,
  @JsonValue('cardio')
  cardio,
  @JsonValue('strength')
  strength,
  @JsonValue('coordination')
  coordination,
  @JsonValue('tactical')
  tactical,
  @JsonValue('heartRate')
  heartRate;

  String get value => name;

  static ChallengeType fromString(String s) =>
      ChallengeType.values.firstWhere((e) => e.name == s);

  static ChallengeType fromJson(String s) => fromString(s);
  static String toJson(ChallengeType t) => t.name;
}
