// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  @JsonKey(name: 'auth_id')
  String get uid => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'photo_url')
  String? get photoURL => throw _privateConstructorUsedError;
  @JsonKey(fromJson: UserRole.fromJson, toJson: UserRole.toJson)
  UserRole get role => throw _privateConstructorUsedError;
  String get course => throw _privateConstructorUsedError;
  String? get group => throw _privateConstructorUsedError;
  @JsonKey(name: 'school_year')
  String? get schoolYear => throw _privateConstructorUsedError;
  int get xp => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get streak => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_active_date', fromJson: _parseDate, toJson: _dateToIso)
  DateTime get lastActiveDate => throw _privateConstructorUsedError;
  @JsonKey(fromJson: AvatarTier.fromJson, toJson: AvatarTier.toJson)
  AvatarTier get avatarTier => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_config')
  Map<String, int> get avatarConfig => throw _privateConstructorUsedError;
  Map<String, int> get attributes => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_unit_id')
  String? get currentUnitId => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_units')
  List<String> get completedUnits => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_lessons_completed')
  int get totalLessonsCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_challenges_completed')
  int get totalChallengesCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_minutes_active')
  int get totalMinutesActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_sessions')
  int get totalSessions => throw _privateConstructorUsedError;
  @JsonKey(name: 'average_daily_steps')
  double get averageDailySteps => throw _privateConstructorUsedError;
  int get coins => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at', fromJson: _parseDate, toJson: _dateToIso)
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_login_at', fromJson: _parseDate, toJson: _dateToIso)
  DateTime get lastLoginAt => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'auth_id') String uid,
      String email,
      @JsonKey(name: 'display_name') String displayName,
      @JsonKey(name: 'photo_url') String? photoURL,
      @JsonKey(fromJson: UserRole.fromJson, toJson: UserRole.toJson)
      UserRole role,
      String course,
      String? group,
      @JsonKey(name: 'school_year') String? schoolYear,
      int xp,
      int level,
      int streak,
      @JsonKey(
          name: 'last_active_date', fromJson: _parseDate, toJson: _dateToIso)
      DateTime lastActiveDate,
      @JsonKey(fromJson: AvatarTier.fromJson, toJson: AvatarTier.toJson)
      AvatarTier avatarTier,
      @JsonKey(name: 'avatar_config') Map<String, int> avatarConfig,
      Map<String, int> attributes,
      @JsonKey(name: 'current_unit_id') String? currentUnitId,
      @JsonKey(name: 'completed_units') List<String> completedUnits,
      @JsonKey(name: 'total_lessons_completed') int totalLessonsCompleted,
      @JsonKey(name: 'total_challenges_completed') int totalChallengesCompleted,
      @JsonKey(name: 'total_minutes_active') int totalMinutesActive,
      @JsonKey(name: 'total_sessions') int totalSessions,
      @JsonKey(name: 'average_daily_steps') double averageDailySteps,
      int coins,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
      DateTime createdAt,
      @JsonKey(name: 'updated_at', fromJson: _parseDate, toJson: _dateToIso)
      DateTime updatedAt,
      @JsonKey(name: 'last_login_at', fromJson: _parseDate, toJson: _dateToIso)
      DateTime lastLoginAt});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = null,
    Object? photoURL = freezed,
    Object? role = null,
    Object? course = null,
    Object? group = freezed,
    Object? schoolYear = freezed,
    Object? xp = null,
    Object? level = null,
    Object? streak = null,
    Object? lastActiveDate = null,
    Object? avatarTier = null,
    Object? avatarConfig = null,
    Object? attributes = null,
    Object? currentUnitId = freezed,
    Object? completedUnits = null,
    Object? totalLessonsCompleted = null,
    Object? totalChallengesCompleted = null,
    Object? totalMinutesActive = null,
    Object? totalSessions = null,
    Object? averageDailySteps = null,
    Object? coins = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastLoginAt = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      course: null == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as String,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      schoolYear: freezed == schoolYear
          ? _value.schoolYear
          : schoolYear // ignore: cast_nullable_to_non_nullable
              as String?,
      xp: null == xp
          ? _value.xp
          : xp // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      streak: null == streak
          ? _value.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      lastActiveDate: null == lastActiveDate
          ? _value.lastActiveDate
          : lastActiveDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      avatarTier: null == avatarTier
          ? _value.avatarTier
          : avatarTier // ignore: cast_nullable_to_non_nullable
              as AvatarTier,
      avatarConfig: null == avatarConfig
          ? _value.avatarConfig
          : avatarConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      attributes: null == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      currentUnitId: freezed == currentUnitId
          ? _value.currentUnitId
          : currentUnitId // ignore: cast_nullable_to_non_nullable
              as String?,
      completedUnits: null == completedUnits
          ? _value.completedUnits
          : completedUnits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalLessonsCompleted: null == totalLessonsCompleted
          ? _value.totalLessonsCompleted
          : totalLessonsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      totalChallengesCompleted: null == totalChallengesCompleted
          ? _value.totalChallengesCompleted
          : totalChallengesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      totalMinutesActive: null == totalMinutesActive
          ? _value.totalMinutesActive
          : totalMinutesActive // ignore: cast_nullable_to_non_nullable
              as int,
      totalSessions: null == totalSessions
          ? _value.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      averageDailySteps: null == averageDailySteps
          ? _value.averageDailySteps
          : averageDailySteps // ignore: cast_nullable_to_non_nullable
              as double,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLoginAt: null == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'auth_id') String uid,
      String email,
      @JsonKey(name: 'display_name') String displayName,
      @JsonKey(name: 'photo_url') String? photoURL,
      @JsonKey(fromJson: UserRole.fromJson, toJson: UserRole.toJson)
      UserRole role,
      String course,
      String? group,
      @JsonKey(name: 'school_year') String? schoolYear,
      int xp,
      int level,
      int streak,
      @JsonKey(
          name: 'last_active_date', fromJson: _parseDate, toJson: _dateToIso)
      DateTime lastActiveDate,
      @JsonKey(fromJson: AvatarTier.fromJson, toJson: AvatarTier.toJson)
      AvatarTier avatarTier,
      @JsonKey(name: 'avatar_config') Map<String, int> avatarConfig,
      Map<String, int> attributes,
      @JsonKey(name: 'current_unit_id') String? currentUnitId,
      @JsonKey(name: 'completed_units') List<String> completedUnits,
      @JsonKey(name: 'total_lessons_completed') int totalLessonsCompleted,
      @JsonKey(name: 'total_challenges_completed') int totalChallengesCompleted,
      @JsonKey(name: 'total_minutes_active') int totalMinutesActive,
      @JsonKey(name: 'total_sessions') int totalSessions,
      @JsonKey(name: 'average_daily_steps') double averageDailySteps,
      int coins,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
      DateTime createdAt,
      @JsonKey(name: 'updated_at', fromJson: _parseDate, toJson: _dateToIso)
      DateTime updatedAt,
      @JsonKey(name: 'last_login_at', fromJson: _parseDate, toJson: _dateToIso)
      DateTime lastLoginAt});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? displayName = null,
    Object? photoURL = freezed,
    Object? role = null,
    Object? course = null,
    Object? group = freezed,
    Object? schoolYear = freezed,
    Object? xp = null,
    Object? level = null,
    Object? streak = null,
    Object? lastActiveDate = null,
    Object? avatarTier = null,
    Object? avatarConfig = null,
    Object? attributes = null,
    Object? currentUnitId = freezed,
    Object? completedUnits = null,
    Object? totalLessonsCompleted = null,
    Object? totalChallengesCompleted = null,
    Object? totalMinutesActive = null,
    Object? totalSessions = null,
    Object? averageDailySteps = null,
    Object? coins = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastLoginAt = null,
  }) {
    return _then(_$UserModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      photoURL: freezed == photoURL
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      course: null == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as String,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
      schoolYear: freezed == schoolYear
          ? _value.schoolYear
          : schoolYear // ignore: cast_nullable_to_non_nullable
              as String?,
      xp: null == xp
          ? _value.xp
          : xp // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      streak: null == streak
          ? _value.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      lastActiveDate: null == lastActiveDate
          ? _value.lastActiveDate
          : lastActiveDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      avatarTier: null == avatarTier
          ? _value.avatarTier
          : avatarTier // ignore: cast_nullable_to_non_nullable
              as AvatarTier,
      avatarConfig: null == avatarConfig
          ? _value._avatarConfig
          : avatarConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      attributes: null == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      currentUnitId: freezed == currentUnitId
          ? _value.currentUnitId
          : currentUnitId // ignore: cast_nullable_to_non_nullable
              as String?,
      completedUnits: null == completedUnits
          ? _value._completedUnits
          : completedUnits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalLessonsCompleted: null == totalLessonsCompleted
          ? _value.totalLessonsCompleted
          : totalLessonsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      totalChallengesCompleted: null == totalChallengesCompleted
          ? _value.totalChallengesCompleted
          : totalChallengesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      totalMinutesActive: null == totalMinutesActive
          ? _value.totalMinutesActive
          : totalMinutesActive // ignore: cast_nullable_to_non_nullable
              as int,
      totalSessions: null == totalSessions
          ? _value.totalSessions
          : totalSessions // ignore: cast_nullable_to_non_nullable
              as int,
      averageDailySteps: null == averageDailySteps
          ? _value.averageDailySteps
          : averageDailySteps // ignore: cast_nullable_to_non_nullable
              as double,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLoginAt: null == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {@JsonKey(name: 'auth_id') required this.uid,
      required this.email,
      @JsonKey(name: 'display_name') this.displayName = '',
      @JsonKey(name: 'photo_url') this.photoURL,
      @JsonKey(fromJson: UserRole.fromJson, toJson: UserRole.toJson)
      this.role = UserRole.alumno,
      this.course = '1_eso',
      this.group,
      @JsonKey(name: 'school_year') this.schoolYear,
      this.xp = 0,
      this.level = 1,
      this.streak = 0,
      @JsonKey(
          name: 'last_active_date', fromJson: _parseDate, toJson: _dateToIso)
      required this.lastActiveDate,
      @JsonKey(fromJson: AvatarTier.fromJson, toJson: AvatarTier.toJson)
      this.avatarTier = AvatarTier.rookie,
      @JsonKey(name: 'avatar_config') final Map<String, int> avatarConfig =
          const {'outfitId': 0, 'accessoryId': -1, 'colorHex': 0xFF4CAF50},
      final Map<String, int> attributes = const {
        'fuerza': 0,
        'resistencia': 0,
        'estrategia': 0,
        'cooperacion': 0,
        'salud': 0,
        'liderazgo': 0
      },
      @JsonKey(name: 'current_unit_id') this.currentUnitId,
      @JsonKey(name: 'completed_units')
      final List<String> completedUnits = const <String>[],
      @JsonKey(name: 'total_lessons_completed') this.totalLessonsCompleted = 0,
      @JsonKey(name: 'total_challenges_completed')
      this.totalChallengesCompleted = 0,
      @JsonKey(name: 'total_minutes_active') this.totalMinutesActive = 0,
      @JsonKey(name: 'total_sessions') this.totalSessions = 0,
      @JsonKey(name: 'average_daily_steps') this.averageDailySteps = 0,
      this.coins = 0,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
      required this.createdAt,
      @JsonKey(name: 'updated_at', fromJson: _parseDate, toJson: _dateToIso)
      required this.updatedAt,
      @JsonKey(name: 'last_login_at', fromJson: _parseDate, toJson: _dateToIso)
      required this.lastLoginAt})
      : _avatarConfig = avatarConfig,
        _attributes = attributes,
        _completedUnits = completedUnits;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @JsonKey(name: 'auth_id')
  final String uid;
  @override
  final String email;
  @override
  @JsonKey(name: 'display_name')
  final String displayName;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoURL;
  @override
  @JsonKey(fromJson: UserRole.fromJson, toJson: UserRole.toJson)
  final UserRole role;
  @override
  @JsonKey()
  final String course;
  @override
  final String? group;
  @override
  @JsonKey(name: 'school_year')
  final String? schoolYear;
  @override
  @JsonKey()
  final int xp;
  @override
  @JsonKey()
  final int level;
  @override
  @JsonKey()
  final int streak;
  @override
  @JsonKey(name: 'last_active_date', fromJson: _parseDate, toJson: _dateToIso)
  final DateTime lastActiveDate;
  @override
  @JsonKey(fromJson: AvatarTier.fromJson, toJson: AvatarTier.toJson)
  final AvatarTier avatarTier;
  final Map<String, int> _avatarConfig;
  @override
  @JsonKey(name: 'avatar_config')
  Map<String, int> get avatarConfig {
    if (_avatarConfig is EqualUnmodifiableMapView) return _avatarConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_avatarConfig);
  }

  final Map<String, int> _attributes;
  @override
  @JsonKey()
  Map<String, int> get attributes {
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributes);
  }

  @override
  @JsonKey(name: 'current_unit_id')
  final String? currentUnitId;
  final List<String> _completedUnits;
  @override
  @JsonKey(name: 'completed_units')
  List<String> get completedUnits {
    if (_completedUnits is EqualUnmodifiableListView) return _completedUnits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedUnits);
  }

  @override
  @JsonKey(name: 'total_lessons_completed')
  final int totalLessonsCompleted;
  @override
  @JsonKey(name: 'total_challenges_completed')
  final int totalChallengesCompleted;
  @override
  @JsonKey(name: 'total_minutes_active')
  final int totalMinutesActive;
  @override
  @JsonKey(name: 'total_sessions')
  final int totalSessions;
  @override
  @JsonKey(name: 'average_daily_steps')
  final double averageDailySteps;
  @override
  @JsonKey()
  final int coins;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at', fromJson: _parseDate, toJson: _dateToIso)
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'last_login_at', fromJson: _parseDate, toJson: _dateToIso)
  final DateTime lastLoginAt;

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, displayName: $displayName, photoURL: $photoURL, role: $role, course: $course, group: $group, schoolYear: $schoolYear, xp: $xp, level: $level, streak: $streak, lastActiveDate: $lastActiveDate, avatarTier: $avatarTier, avatarConfig: $avatarConfig, attributes: $attributes, currentUnitId: $currentUnitId, completedUnits: $completedUnits, totalLessonsCompleted: $totalLessonsCompleted, totalChallengesCompleted: $totalChallengesCompleted, totalMinutesActive: $totalMinutesActive, totalSessions: $totalSessions, averageDailySteps: $averageDailySteps, coins: $coins, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.photoURL, photoURL) ||
                other.photoURL == photoURL) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.course, course) || other.course == course) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.schoolYear, schoolYear) ||
                other.schoolYear == schoolYear) &&
            (identical(other.xp, xp) || other.xp == xp) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            (identical(other.lastActiveDate, lastActiveDate) ||
                other.lastActiveDate == lastActiveDate) &&
            (identical(other.avatarTier, avatarTier) ||
                other.avatarTier == avatarTier) &&
            const DeepCollectionEquality()
                .equals(other._avatarConfig, _avatarConfig) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes) &&
            (identical(other.currentUnitId, currentUnitId) ||
                other.currentUnitId == currentUnitId) &&
            const DeepCollectionEquality()
                .equals(other._completedUnits, _completedUnits) &&
            (identical(other.totalLessonsCompleted, totalLessonsCompleted) ||
                other.totalLessonsCompleted == totalLessonsCompleted) &&
            (identical(
                    other.totalChallengesCompleted, totalChallengesCompleted) ||
                other.totalChallengesCompleted == totalChallengesCompleted) &&
            (identical(other.totalMinutesActive, totalMinutesActive) ||
                other.totalMinutesActive == totalMinutesActive) &&
            (identical(other.totalSessions, totalSessions) ||
                other.totalSessions == totalSessions) &&
            (identical(other.averageDailySteps, averageDailySteps) ||
                other.averageDailySteps == averageDailySteps) &&
            (identical(other.coins, coins) || other.coins == coins) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        uid,
        email,
        displayName,
        photoURL,
        role,
        course,
        group,
        schoolYear,
        xp,
        level,
        streak,
        lastActiveDate,
        avatarTier,
        const DeepCollectionEquality().hash(_avatarConfig),
        const DeepCollectionEquality().hash(_attributes),
        currentUnitId,
        const DeepCollectionEquality().hash(_completedUnits),
        totalLessonsCompleted,
        totalChallengesCompleted,
        totalMinutesActive,
        totalSessions,
        averageDailySteps,
        coins,
        isActive,
        createdAt,
        updatedAt,
        lastLoginAt
      ]);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {@JsonKey(name: 'auth_id') required final String uid,
      required final String email,
      @JsonKey(name: 'display_name') final String displayName,
      @JsonKey(name: 'photo_url') final String? photoURL,
      @JsonKey(fromJson: UserRole.fromJson, toJson: UserRole.toJson)
      final UserRole role,
      final String course,
      final String? group,
      @JsonKey(name: 'school_year') final String? schoolYear,
      final int xp,
      final int level,
      final int streak,
      @JsonKey(
          name: 'last_active_date', fromJson: _parseDate, toJson: _dateToIso)
      required final DateTime lastActiveDate,
      @JsonKey(fromJson: AvatarTier.fromJson, toJson: AvatarTier.toJson)
      final AvatarTier avatarTier,
      @JsonKey(name: 'avatar_config') final Map<String, int> avatarConfig,
      final Map<String, int> attributes,
      @JsonKey(name: 'current_unit_id') final String? currentUnitId,
      @JsonKey(name: 'completed_units') final List<String> completedUnits,
      @JsonKey(name: 'total_lessons_completed') final int totalLessonsCompleted,
      @JsonKey(name: 'total_challenges_completed')
      final int totalChallengesCompleted,
      @JsonKey(name: 'total_minutes_active') final int totalMinutesActive,
      @JsonKey(name: 'total_sessions') final int totalSessions,
      @JsonKey(name: 'average_daily_steps') final double averageDailySteps,
      final int coins,
      @JsonKey(name: 'is_active') final bool isActive,
      @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
      required final DateTime createdAt,
      @JsonKey(name: 'updated_at', fromJson: _parseDate, toJson: _dateToIso)
      required final DateTime updatedAt,
      @JsonKey(name: 'last_login_at', fromJson: _parseDate, toJson: _dateToIso)
      required final DateTime lastLoginAt}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  @JsonKey(name: 'auth_id')
  String get uid;
  @override
  String get email;
  @override
  @JsonKey(name: 'display_name')
  String get displayName;
  @override
  @JsonKey(name: 'photo_url')
  String? get photoURL;
  @override
  @JsonKey(fromJson: UserRole.fromJson, toJson: UserRole.toJson)
  UserRole get role;
  @override
  String get course;
  @override
  String? get group;
  @override
  @JsonKey(name: 'school_year')
  String? get schoolYear;
  @override
  int get xp;
  @override
  int get level;
  @override
  int get streak;
  @override
  @JsonKey(name: 'last_active_date', fromJson: _parseDate, toJson: _dateToIso)
  DateTime get lastActiveDate;
  @override
  @JsonKey(fromJson: AvatarTier.fromJson, toJson: AvatarTier.toJson)
  AvatarTier get avatarTier;
  @override
  @JsonKey(name: 'avatar_config')
  Map<String, int> get avatarConfig;
  @override
  Map<String, int> get attributes;
  @override
  @JsonKey(name: 'current_unit_id')
  String? get currentUnitId;
  @override
  @JsonKey(name: 'completed_units')
  List<String> get completedUnits;
  @override
  @JsonKey(name: 'total_lessons_completed')
  int get totalLessonsCompleted;
  @override
  @JsonKey(name: 'total_challenges_completed')
  int get totalChallengesCompleted;
  @override
  @JsonKey(name: 'total_minutes_active')
  int get totalMinutesActive;
  @override
  @JsonKey(name: 'total_sessions')
  int get totalSessions;
  @override
  @JsonKey(name: 'average_daily_steps')
  double get averageDailySteps;
  @override
  int get coins;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at', fromJson: _parseDate, toJson: _dateToIso)
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'last_login_at', fromJson: _parseDate, toJson: _dateToIso)
  DateTime get lastLoginAt;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
