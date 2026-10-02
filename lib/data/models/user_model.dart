// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/enums/enums.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'auth_id') required String uid,
    required String email,
    @JsonKey(name: 'display_name') @Default('') String displayName,
    @JsonKey(name: 'photo_url') String? photoURL,
    @JsonKey(fromJson: UserRole.fromJson, toJson: UserRole.toJson)
    @Default(UserRole.alumno) UserRole role,
    @Default('1_eso') String course,
    String? group,
    @JsonKey(name: 'school_year') String? schoolYear,
    @Default(0) int xp,
    @Default(1) int level,
    @Default(0) int streak,
    @JsonKey(name: 'last_active_date', fromJson: _parseDate, toJson: _dateToIso)
    required DateTime lastActiveDate,
    @JsonKey(fromJson: AvatarTier.fromJson, toJson: AvatarTier.toJson)
    @Default(AvatarTier.rookie) AvatarTier avatarTier,
    @JsonKey(name: 'avatar_config')
    @Default({'outfitId': 0, 'accessoryId': -1, 'colorHex': 0xFF4CAF50})
    Map<String, int> avatarConfig,
    @Default({
      'fuerza': 0,
      'resistencia': 0,
      'estrategia': 0,
      'cooperacion': 0,
      'salud': 0,
      'liderazgo': 0,
    })
    Map<String, int> attributes,
    @JsonKey(name: 'current_unit_id') String? currentUnitId,
    @JsonKey(name: 'completed_units') @Default(<String>[]) List<String> completedUnits,
    @JsonKey(name: 'total_lessons_completed') @Default(0) int totalLessonsCompleted,
    @JsonKey(name: 'total_challenges_completed') @Default(0)
    int totalChallengesCompleted,
    @JsonKey(name: 'total_minutes_active') @Default(0) int totalMinutesActive,
    @JsonKey(name: 'total_sessions') @Default(0) int totalSessions,
    @JsonKey(name: 'average_daily_steps') @Default(0) double averageDailySteps,
    @Default(0) int coins,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at', fromJson: _parseDate, toJson: _dateToIso)
    required DateTime createdAt,
    @JsonKey(name: 'updated_at', fromJson: _parseDate, toJson: _dateToIso)
    required DateTime updatedAt,
    @JsonKey(name: 'last_login_at', fromJson: _parseDate, toJson: _dateToIso)
    required DateTime lastLoginAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

DateTime _parseDate(dynamic value) {
  if (value == null) return DateTime.now();
  if (value is DateTime) return value;
  return DateTime.parse(value.toString());
}

String _dateToIso(DateTime d) => d.toIso8601String();
