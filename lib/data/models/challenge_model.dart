// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/enums/challenge_type.dart';
import '../../core/enums/difficulty.dart';

part 'challenge_model.freezed.dart';
part 'challenge_model.g.dart';

@freezed
class ChallengeModel with _$ChallengeModel {
  const factory ChallengeModel({
    @JsonKey(name: 'challenge_id') required String challengeId,
    @JsonKey(name: 'unit_id') required String unitId,
    required int order,
    @JsonKey(fromJson: ChallengeType.fromJson, toJson: ChallengeType.toJson)
    required ChallengeType type,
    required String title,
    @Default('') String description,
    @JsonKey(fromJson: Difficulty.fromJson, toJson: Difficulty.toJson)
    @Default(Difficulty.medio) Difficulty difficulty,
    @JsonKey(name: 'goal_type') @Default('reps') String goalType,
    @JsonKey(name: 'goal_value') @Default(10) double goalValue,
    @JsonKey(name: 'min_value') @Default(5) double minValue,
    @JsonKey(name: 'max_value') @Default(20) double maxValue,
    @JsonKey(name: 'adaptive_enabled') @Default(true) bool adaptiveEnabled,
    @JsonKey(name: 'adaptive_base_value') @Default(10) double adaptiveBaseValue,
    @JsonKey(name: 'adaptive_increment') @Default(2) double adaptiveIncrement,
    @JsonKey(name: 'adaptive_max_value') @Default(30) double adaptiveMaxValue,
    @JsonKey(name: 'xp_reward') @Default(50) int xpReward,
    @JsonKey(name: 'xp_three_stars') @Default(100) int xpThreeStars,
    @JsonKey(name: 'attribute_rewards') @Default({}) Map<String, int> attributeRewards,
    @JsonKey(name: 'intro_text') @Default('') String introText,
    @JsonKey(name: 'success_text') @Default('') String successText,
    @JsonKey(name: 'fail_text') @Default('') String failText,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
    required DateTime createdAt,
  }) = _ChallengeModel;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$ChallengeModelFromJson(json);
}

DateTime _parseDate(dynamic value) {
  if (value == null) return DateTime.now();
  if (value is DateTime) return value;
  return DateTime.parse(value.toString());
}

String _dateToIso(DateTime d) => d.toIso8601String();
