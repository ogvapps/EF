// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['auth_id'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String? ?? '',
      photoURL: json['photo_url'] as String?,
      role: json['role'] == null
          ? UserRole.alumno
          : UserRole.fromJson(json['role'] as String),
      course: json['course'] as String? ?? '1_eso',
      group: json['group'] as String?,
      schoolYear: json['school_year'] as String?,
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 1,
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      lastActiveDate: _parseDate(json['last_active_date']),
      avatarTier: json['avatarTier'] == null
          ? AvatarTier.rookie
          : AvatarTier.fromJson(json['avatarTier'] as String),
      avatarConfig: (json['avatar_config'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {'outfitId': 0, 'accessoryId': -1, 'colorHex': 0xFF4CAF50},
      attributes: (json['attributes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {
            'fuerza': 0,
            'resistencia': 0,
            'estrategia': 0,
            'cooperacion': 0,
            'salud': 0,
            'liderazgo': 0
          },
      currentUnitId: json['current_unit_id'] as String?,
      completedUnits: (json['completed_units'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      totalLessonsCompleted:
          (json['total_lessons_completed'] as num?)?.toInt() ?? 0,
      totalChallengesCompleted:
          (json['total_challenges_completed'] as num?)?.toInt() ?? 0,
      totalMinutesActive: (json['total_minutes_active'] as num?)?.toInt() ?? 0,
      totalSessions: (json['total_sessions'] as num?)?.toInt() ?? 0,
      averageDailySteps: (json['average_daily_steps'] as num?)?.toDouble() ?? 0,
      coins: (json['coins'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
      lastLoginAt: _parseDate(json['last_login_at']),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'auth_id': instance.uid,
      'email': instance.email,
      'display_name': instance.displayName,
      'photo_url': instance.photoURL,
      'role': UserRole.toJson(instance.role),
      'course': instance.course,
      'group': instance.group,
      'school_year': instance.schoolYear,
      'xp': instance.xp,
      'level': instance.level,
      'streak': instance.streak,
      'last_active_date': _dateToIso(instance.lastActiveDate),
      'avatarTier': AvatarTier.toJson(instance.avatarTier),
      'avatar_config': instance.avatarConfig,
      'attributes': instance.attributes,
      'current_unit_id': instance.currentUnitId,
      'completed_units': instance.completedUnits,
      'total_lessons_completed': instance.totalLessonsCompleted,
      'total_challenges_completed': instance.totalChallengesCompleted,
      'total_minutes_active': instance.totalMinutesActive,
      'total_sessions': instance.totalSessions,
      'average_daily_steps': instance.averageDailySteps,
      'coins': instance.coins,
      'is_active': instance.isActive,
      'created_at': _dateToIso(instance.createdAt),
      'updated_at': _dateToIso(instance.updatedAt),
      'last_login_at': _dateToIso(instance.lastLoginAt),
    };
