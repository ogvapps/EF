// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChallengeModel _$ChallengeModelFromJson(Map<String, dynamic> json) {
  return _ChallengeModel.fromJson(json);
}

/// @nodoc
mixin _$ChallengeModel {
  @JsonKey(name: 'challenge_id')
  String get challengeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_id')
  String get unitId => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ChallengeType.fromJson, toJson: ChallengeType.toJson)
  ChallengeType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Difficulty.fromJson, toJson: Difficulty.toJson)
  Difficulty get difficulty => throw _privateConstructorUsedError;
  @JsonKey(name: 'goal_type')
  String get goalType => throw _privateConstructorUsedError;
  @JsonKey(name: 'goal_value')
  double get goalValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_value')
  double get minValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_value')
  double get maxValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'adaptive_enabled')
  bool get adaptiveEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'adaptive_base_value')
  double get adaptiveBaseValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'adaptive_increment')
  double get adaptiveIncrement => throw _privateConstructorUsedError;
  @JsonKey(name: 'adaptive_max_value')
  double get adaptiveMaxValue => throw _privateConstructorUsedError;
  @JsonKey(name: 'xp_reward')
  int get xpReward => throw _privateConstructorUsedError;
  @JsonKey(name: 'xp_three_stars')
  int get xpThreeStars => throw _privateConstructorUsedError;
  @JsonKey(name: 'attribute_rewards')
  Map<String, int> get attributeRewards => throw _privateConstructorUsedError;
  @JsonKey(name: 'intro_text')
  String get introText => throw _privateConstructorUsedError;
  @JsonKey(name: 'success_text')
  String get successText => throw _privateConstructorUsedError;
  @JsonKey(name: 'fail_text')
  String get failText => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChallengeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeModelCopyWith<ChallengeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeModelCopyWith<$Res> {
  factory $ChallengeModelCopyWith(
          ChallengeModel value, $Res Function(ChallengeModel) then) =
      _$ChallengeModelCopyWithImpl<$Res, ChallengeModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'challenge_id') String challengeId,
      @JsonKey(name: 'unit_id') String unitId,
      int order,
      @JsonKey(fromJson: ChallengeType.fromJson, toJson: ChallengeType.toJson)
      ChallengeType type,
      String title,
      String description,
      @JsonKey(fromJson: Difficulty.fromJson, toJson: Difficulty.toJson)
      Difficulty difficulty,
      @JsonKey(name: 'goal_type') String goalType,
      @JsonKey(name: 'goal_value') double goalValue,
      @JsonKey(name: 'min_value') double minValue,
      @JsonKey(name: 'max_value') double maxValue,
      @JsonKey(name: 'adaptive_enabled') bool adaptiveEnabled,
      @JsonKey(name: 'adaptive_base_value') double adaptiveBaseValue,
      @JsonKey(name: 'adaptive_increment') double adaptiveIncrement,
      @JsonKey(name: 'adaptive_max_value') double adaptiveMaxValue,
      @JsonKey(name: 'xp_reward') int xpReward,
      @JsonKey(name: 'xp_three_stars') int xpThreeStars,
      @JsonKey(name: 'attribute_rewards') Map<String, int> attributeRewards,
      @JsonKey(name: 'intro_text') String introText,
      @JsonKey(name: 'success_text') String successText,
      @JsonKey(name: 'fail_text') String failText,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
      DateTime createdAt});
}

/// @nodoc
class _$ChallengeModelCopyWithImpl<$Res, $Val extends ChallengeModel>
    implements $ChallengeModelCopyWith<$Res> {
  _$ChallengeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeId = null,
    Object? unitId = null,
    Object? order = null,
    Object? type = null,
    Object? title = null,
    Object? description = null,
    Object? difficulty = null,
    Object? goalType = null,
    Object? goalValue = null,
    Object? minValue = null,
    Object? maxValue = null,
    Object? adaptiveEnabled = null,
    Object? adaptiveBaseValue = null,
    Object? adaptiveIncrement = null,
    Object? adaptiveMaxValue = null,
    Object? xpReward = null,
    Object? xpThreeStars = null,
    Object? attributeRewards = null,
    Object? introText = null,
    Object? successText = null,
    Object? failText = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String,
      unitId: null == unitId
          ? _value.unitId
          : unitId // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChallengeType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as Difficulty,
      goalType: null == goalType
          ? _value.goalType
          : goalType // ignore: cast_nullable_to_non_nullable
              as String,
      goalValue: null == goalValue
          ? _value.goalValue
          : goalValue // ignore: cast_nullable_to_non_nullable
              as double,
      minValue: null == minValue
          ? _value.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxValue: null == maxValue
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double,
      adaptiveEnabled: null == adaptiveEnabled
          ? _value.adaptiveEnabled
          : adaptiveEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      adaptiveBaseValue: null == adaptiveBaseValue
          ? _value.adaptiveBaseValue
          : adaptiveBaseValue // ignore: cast_nullable_to_non_nullable
              as double,
      adaptiveIncrement: null == adaptiveIncrement
          ? _value.adaptiveIncrement
          : adaptiveIncrement // ignore: cast_nullable_to_non_nullable
              as double,
      adaptiveMaxValue: null == adaptiveMaxValue
          ? _value.adaptiveMaxValue
          : adaptiveMaxValue // ignore: cast_nullable_to_non_nullable
              as double,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      xpThreeStars: null == xpThreeStars
          ? _value.xpThreeStars
          : xpThreeStars // ignore: cast_nullable_to_non_nullable
              as int,
      attributeRewards: null == attributeRewards
          ? _value.attributeRewards
          : attributeRewards // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      introText: null == introText
          ? _value.introText
          : introText // ignore: cast_nullable_to_non_nullable
              as String,
      successText: null == successText
          ? _value.successText
          : successText // ignore: cast_nullable_to_non_nullable
              as String,
      failText: null == failText
          ? _value.failText
          : failText // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeModelImplCopyWith<$Res>
    implements $ChallengeModelCopyWith<$Res> {
  factory _$$ChallengeModelImplCopyWith(_$ChallengeModelImpl value,
          $Res Function(_$ChallengeModelImpl) then) =
      __$$ChallengeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'challenge_id') String challengeId,
      @JsonKey(name: 'unit_id') String unitId,
      int order,
      @JsonKey(fromJson: ChallengeType.fromJson, toJson: ChallengeType.toJson)
      ChallengeType type,
      String title,
      String description,
      @JsonKey(fromJson: Difficulty.fromJson, toJson: Difficulty.toJson)
      Difficulty difficulty,
      @JsonKey(name: 'goal_type') String goalType,
      @JsonKey(name: 'goal_value') double goalValue,
      @JsonKey(name: 'min_value') double minValue,
      @JsonKey(name: 'max_value') double maxValue,
      @JsonKey(name: 'adaptive_enabled') bool adaptiveEnabled,
      @JsonKey(name: 'adaptive_base_value') double adaptiveBaseValue,
      @JsonKey(name: 'adaptive_increment') double adaptiveIncrement,
      @JsonKey(name: 'adaptive_max_value') double adaptiveMaxValue,
      @JsonKey(name: 'xp_reward') int xpReward,
      @JsonKey(name: 'xp_three_stars') int xpThreeStars,
      @JsonKey(name: 'attribute_rewards') Map<String, int> attributeRewards,
      @JsonKey(name: 'intro_text') String introText,
      @JsonKey(name: 'success_text') String successText,
      @JsonKey(name: 'fail_text') String failText,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
      DateTime createdAt});
}

/// @nodoc
class __$$ChallengeModelImplCopyWithImpl<$Res>
    extends _$ChallengeModelCopyWithImpl<$Res, _$ChallengeModelImpl>
    implements _$$ChallengeModelImplCopyWith<$Res> {
  __$$ChallengeModelImplCopyWithImpl(
      _$ChallengeModelImpl _value, $Res Function(_$ChallengeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challengeId = null,
    Object? unitId = null,
    Object? order = null,
    Object? type = null,
    Object? title = null,
    Object? description = null,
    Object? difficulty = null,
    Object? goalType = null,
    Object? goalValue = null,
    Object? minValue = null,
    Object? maxValue = null,
    Object? adaptiveEnabled = null,
    Object? adaptiveBaseValue = null,
    Object? adaptiveIncrement = null,
    Object? adaptiveMaxValue = null,
    Object? xpReward = null,
    Object? xpThreeStars = null,
    Object? attributeRewards = null,
    Object? introText = null,
    Object? successText = null,
    Object? failText = null,
    Object? isActive = null,
    Object? createdAt = null,
  }) {
    return _then(_$ChallengeModelImpl(
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String,
      unitId: null == unitId
          ? _value.unitId
          : unitId // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChallengeType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as Difficulty,
      goalType: null == goalType
          ? _value.goalType
          : goalType // ignore: cast_nullable_to_non_nullable
              as String,
      goalValue: null == goalValue
          ? _value.goalValue
          : goalValue // ignore: cast_nullable_to_non_nullable
              as double,
      minValue: null == minValue
          ? _value.minValue
          : minValue // ignore: cast_nullable_to_non_nullable
              as double,
      maxValue: null == maxValue
          ? _value.maxValue
          : maxValue // ignore: cast_nullable_to_non_nullable
              as double,
      adaptiveEnabled: null == adaptiveEnabled
          ? _value.adaptiveEnabled
          : adaptiveEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      adaptiveBaseValue: null == adaptiveBaseValue
          ? _value.adaptiveBaseValue
          : adaptiveBaseValue // ignore: cast_nullable_to_non_nullable
              as double,
      adaptiveIncrement: null == adaptiveIncrement
          ? _value.adaptiveIncrement
          : adaptiveIncrement // ignore: cast_nullable_to_non_nullable
              as double,
      adaptiveMaxValue: null == adaptiveMaxValue
          ? _value.adaptiveMaxValue
          : adaptiveMaxValue // ignore: cast_nullable_to_non_nullable
              as double,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      xpThreeStars: null == xpThreeStars
          ? _value.xpThreeStars
          : xpThreeStars // ignore: cast_nullable_to_non_nullable
              as int,
      attributeRewards: null == attributeRewards
          ? _value._attributeRewards
          : attributeRewards // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      introText: null == introText
          ? _value.introText
          : introText // ignore: cast_nullable_to_non_nullable
              as String,
      successText: null == successText
          ? _value.successText
          : successText // ignore: cast_nullable_to_non_nullable
              as String,
      failText: null == failText
          ? _value.failText
          : failText // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeModelImpl implements _ChallengeModel {
  const _$ChallengeModelImpl(
      {@JsonKey(name: 'challenge_id') required this.challengeId,
      @JsonKey(name: 'unit_id') required this.unitId,
      required this.order,
      @JsonKey(fromJson: ChallengeType.fromJson, toJson: ChallengeType.toJson)
      required this.type,
      required this.title,
      this.description = '',
      @JsonKey(fromJson: Difficulty.fromJson, toJson: Difficulty.toJson)
      this.difficulty = Difficulty.medio,
      @JsonKey(name: 'goal_type') this.goalType = 'reps',
      @JsonKey(name: 'goal_value') this.goalValue = 10,
      @JsonKey(name: 'min_value') this.minValue = 5,
      @JsonKey(name: 'max_value') this.maxValue = 20,
      @JsonKey(name: 'adaptive_enabled') this.adaptiveEnabled = true,
      @JsonKey(name: 'adaptive_base_value') this.adaptiveBaseValue = 10,
      @JsonKey(name: 'adaptive_increment') this.adaptiveIncrement = 2,
      @JsonKey(name: 'adaptive_max_value') this.adaptiveMaxValue = 30,
      @JsonKey(name: 'xp_reward') this.xpReward = 50,
      @JsonKey(name: 'xp_three_stars') this.xpThreeStars = 100,
      @JsonKey(name: 'attribute_rewards')
      final Map<String, int> attributeRewards = const {},
      @JsonKey(name: 'intro_text') this.introText = '',
      @JsonKey(name: 'success_text') this.successText = '',
      @JsonKey(name: 'fail_text') this.failText = '',
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
      required this.createdAt})
      : _attributeRewards = attributeRewards;

  factory _$ChallengeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeModelImplFromJson(json);

  @override
  @JsonKey(name: 'challenge_id')
  final String challengeId;
  @override
  @JsonKey(name: 'unit_id')
  final String unitId;
  @override
  final int order;
  @override
  @JsonKey(fromJson: ChallengeType.fromJson, toJson: ChallengeType.toJson)
  final ChallengeType type;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(fromJson: Difficulty.fromJson, toJson: Difficulty.toJson)
  final Difficulty difficulty;
  @override
  @JsonKey(name: 'goal_type')
  final String goalType;
  @override
  @JsonKey(name: 'goal_value')
  final double goalValue;
  @override
  @JsonKey(name: 'min_value')
  final double minValue;
  @override
  @JsonKey(name: 'max_value')
  final double maxValue;
  @override
  @JsonKey(name: 'adaptive_enabled')
  final bool adaptiveEnabled;
  @override
  @JsonKey(name: 'adaptive_base_value')
  final double adaptiveBaseValue;
  @override
  @JsonKey(name: 'adaptive_increment')
  final double adaptiveIncrement;
  @override
  @JsonKey(name: 'adaptive_max_value')
  final double adaptiveMaxValue;
  @override
  @JsonKey(name: 'xp_reward')
  final int xpReward;
  @override
  @JsonKey(name: 'xp_three_stars')
  final int xpThreeStars;
  final Map<String, int> _attributeRewards;
  @override
  @JsonKey(name: 'attribute_rewards')
  Map<String, int> get attributeRewards {
    if (_attributeRewards is EqualUnmodifiableMapView) return _attributeRewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributeRewards);
  }

  @override
  @JsonKey(name: 'intro_text')
  final String introText;
  @override
  @JsonKey(name: 'success_text')
  final String successText;
  @override
  @JsonKey(name: 'fail_text')
  final String failText;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
  final DateTime createdAt;

  @override
  String toString() {
    return 'ChallengeModel(challengeId: $challengeId, unitId: $unitId, order: $order, type: $type, title: $title, description: $description, difficulty: $difficulty, goalType: $goalType, goalValue: $goalValue, minValue: $minValue, maxValue: $maxValue, adaptiveEnabled: $adaptiveEnabled, adaptiveBaseValue: $adaptiveBaseValue, adaptiveIncrement: $adaptiveIncrement, adaptiveMaxValue: $adaptiveMaxValue, xpReward: $xpReward, xpThreeStars: $xpThreeStars, attributeRewards: $attributeRewards, introText: $introText, successText: $successText, failText: $failText, isActive: $isActive, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeModelImpl &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.unitId, unitId) || other.unitId == unitId) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.goalType, goalType) ||
                other.goalType == goalType) &&
            (identical(other.goalValue, goalValue) ||
                other.goalValue == goalValue) &&
            (identical(other.minValue, minValue) ||
                other.minValue == minValue) &&
            (identical(other.maxValue, maxValue) ||
                other.maxValue == maxValue) &&
            (identical(other.adaptiveEnabled, adaptiveEnabled) ||
                other.adaptiveEnabled == adaptiveEnabled) &&
            (identical(other.adaptiveBaseValue, adaptiveBaseValue) ||
                other.adaptiveBaseValue == adaptiveBaseValue) &&
            (identical(other.adaptiveIncrement, adaptiveIncrement) ||
                other.adaptiveIncrement == adaptiveIncrement) &&
            (identical(other.adaptiveMaxValue, adaptiveMaxValue) ||
                other.adaptiveMaxValue == adaptiveMaxValue) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.xpThreeStars, xpThreeStars) ||
                other.xpThreeStars == xpThreeStars) &&
            const DeepCollectionEquality()
                .equals(other._attributeRewards, _attributeRewards) &&
            (identical(other.introText, introText) ||
                other.introText == introText) &&
            (identical(other.successText, successText) ||
                other.successText == successText) &&
            (identical(other.failText, failText) ||
                other.failText == failText) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        challengeId,
        unitId,
        order,
        type,
        title,
        description,
        difficulty,
        goalType,
        goalValue,
        minValue,
        maxValue,
        adaptiveEnabled,
        adaptiveBaseValue,
        adaptiveIncrement,
        adaptiveMaxValue,
        xpReward,
        xpThreeStars,
        const DeepCollectionEquality().hash(_attributeRewards),
        introText,
        successText,
        failText,
        isActive,
        createdAt
      ]);

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeModelImplCopyWith<_$ChallengeModelImpl> get copyWith =>
      __$$ChallengeModelImplCopyWithImpl<_$ChallengeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeModelImplToJson(
      this,
    );
  }
}

abstract class _ChallengeModel implements ChallengeModel {
  const factory _ChallengeModel(
      {@JsonKey(name: 'challenge_id') required final String challengeId,
      @JsonKey(name: 'unit_id') required final String unitId,
      required final int order,
      @JsonKey(fromJson: ChallengeType.fromJson, toJson: ChallengeType.toJson)
      required final ChallengeType type,
      required final String title,
      final String description,
      @JsonKey(fromJson: Difficulty.fromJson, toJson: Difficulty.toJson)
      final Difficulty difficulty,
      @JsonKey(name: 'goal_type') final String goalType,
      @JsonKey(name: 'goal_value') final double goalValue,
      @JsonKey(name: 'min_value') final double minValue,
      @JsonKey(name: 'max_value') final double maxValue,
      @JsonKey(name: 'adaptive_enabled') final bool adaptiveEnabled,
      @JsonKey(name: 'adaptive_base_value') final double adaptiveBaseValue,
      @JsonKey(name: 'adaptive_increment') final double adaptiveIncrement,
      @JsonKey(name: 'adaptive_max_value') final double adaptiveMaxValue,
      @JsonKey(name: 'xp_reward') final int xpReward,
      @JsonKey(name: 'xp_three_stars') final int xpThreeStars,
      @JsonKey(name: 'attribute_rewards')
      final Map<String, int> attributeRewards,
      @JsonKey(name: 'intro_text') final String introText,
      @JsonKey(name: 'success_text') final String successText,
      @JsonKey(name: 'fail_text') final String failText,
      @JsonKey(name: 'is_active') final bool isActive,
      @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
      required final DateTime createdAt}) = _$ChallengeModelImpl;

  factory _ChallengeModel.fromJson(Map<String, dynamic> json) =
      _$ChallengeModelImpl.fromJson;

  @override
  @JsonKey(name: 'challenge_id')
  String get challengeId;
  @override
  @JsonKey(name: 'unit_id')
  String get unitId;
  @override
  int get order;
  @override
  @JsonKey(fromJson: ChallengeType.fromJson, toJson: ChallengeType.toJson)
  ChallengeType get type;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(fromJson: Difficulty.fromJson, toJson: Difficulty.toJson)
  Difficulty get difficulty;
  @override
  @JsonKey(name: 'goal_type')
  String get goalType;
  @override
  @JsonKey(name: 'goal_value')
  double get goalValue;
  @override
  @JsonKey(name: 'min_value')
  double get minValue;
  @override
  @JsonKey(name: 'max_value')
  double get maxValue;
  @override
  @JsonKey(name: 'adaptive_enabled')
  bool get adaptiveEnabled;
  @override
  @JsonKey(name: 'adaptive_base_value')
  double get adaptiveBaseValue;
  @override
  @JsonKey(name: 'adaptive_increment')
  double get adaptiveIncrement;
  @override
  @JsonKey(name: 'adaptive_max_value')
  double get adaptiveMaxValue;
  @override
  @JsonKey(name: 'xp_reward')
  int get xpReward;
  @override
  @JsonKey(name: 'xp_three_stars')
  int get xpThreeStars;
  @override
  @JsonKey(name: 'attribute_rewards')
  Map<String, int> get attributeRewards;
  @override
  @JsonKey(name: 'intro_text')
  String get introText;
  @override
  @JsonKey(name: 'success_text')
  String get successText;
  @override
  @JsonKey(name: 'fail_text')
  String get failText;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
  DateTime get createdAt;

  /// Create a copy of ChallengeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeModelImplCopyWith<_$ChallengeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
