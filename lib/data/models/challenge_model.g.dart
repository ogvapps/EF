// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeModelImpl _$$ChallengeModelImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeModelImpl(
      challengeId: json['challenge_id'] as String,
      unitId: json['unit_id'] as String,
      order: (json['order'] as num).toInt(),
      type: ChallengeType.fromJson(json['type'] as String),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      difficulty: json['difficulty'] == null
          ? Difficulty.medio
          : Difficulty.fromJson(json['difficulty'] as String),
      goalType: json['goal_type'] as String? ?? 'reps',
      goalValue: (json['goal_value'] as num?)?.toDouble() ?? 10,
      minValue: (json['min_value'] as num?)?.toDouble() ?? 5,
      maxValue: (json['max_value'] as num?)?.toDouble() ?? 20,
      adaptiveEnabled: json['adaptive_enabled'] as bool? ?? true,
      adaptiveBaseValue:
          (json['adaptive_base_value'] as num?)?.toDouble() ?? 10,
      adaptiveIncrement: (json['adaptive_increment'] as num?)?.toDouble() ?? 2,
      adaptiveMaxValue: (json['adaptive_max_value'] as num?)?.toDouble() ?? 30,
      xpReward: (json['xp_reward'] as num?)?.toInt() ?? 50,
      xpThreeStars: (json['xp_three_stars'] as num?)?.toInt() ?? 100,
      attributeRewards:
          (json['attribute_rewards'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const {},
      introText: json['intro_text'] as String? ?? '',
      successText: json['success_text'] as String? ?? '',
      failText: json['fail_text'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      createdAt: _parseDate(json['created_at']),
    );

Map<String, dynamic> _$$ChallengeModelImplToJson(
        _$ChallengeModelImpl instance) =>
    <String, dynamic>{
      'challenge_id': instance.challengeId,
      'unit_id': instance.unitId,
      'order': instance.order,
      'type': ChallengeType.toJson(instance.type),
      'title': instance.title,
      'description': instance.description,
      'difficulty': Difficulty.toJson(instance.difficulty),
      'goal_type': instance.goalType,
      'goal_value': instance.goalValue,
      'min_value': instance.minValue,
      'max_value': instance.maxValue,
      'adaptive_enabled': instance.adaptiveEnabled,
      'adaptive_base_value': instance.adaptiveBaseValue,
      'adaptive_increment': instance.adaptiveIncrement,
      'adaptive_max_value': instance.adaptiveMaxValue,
      'xp_reward': instance.xpReward,
      'xp_three_stars': instance.xpThreeStars,
      'attribute_rewards': instance.attributeRewards,
      'intro_text': instance.introText,
      'success_text': instance.successText,
      'fail_text': instance.failText,
      'is_active': instance.isActive,
      'created_at': _dateToIso(instance.createdAt),
    };
