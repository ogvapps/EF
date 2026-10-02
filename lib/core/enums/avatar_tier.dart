import 'package:freezed_annotation/freezed_annotation.dart';

enum AvatarTier {
  @JsonValue('rookie')
  rookie,
  @JsonValue('amateur')
  amateur,
  @JsonValue('competidor')
  competidor,
  @JsonValue('capitan')
  capitan,
  @JsonValue('elite')
  elite;

  String get value => name;
  String get displayName {
    switch (this) {
      case AvatarTier.rookie:
        return 'Rookie';
      case AvatarTier.amateur:
        return 'Amateur';
      case AvatarTier.competidor:
        return 'Competidor';
      case AvatarTier.capitan:
        return 'Capitán';
      case AvatarTier.elite:
        return 'Élite';
    }
  }

  static AvatarTier fromString(String s) =>
      AvatarTier.values.firstWhere((e) => e.name == s);

  static AvatarTier fromLevel(int level) {
    if (level >= 70) return AvatarTier.elite;
    if (level >= 45) return AvatarTier.capitan;
    if (level >= 25) return AvatarTier.competidor;
    if (level >= 10) return AvatarTier.amateur;
    return AvatarTier.rookie;
  }

  static AvatarTier fromJson(String s) => fromString(s);
  static String toJson(AvatarTier t) => t.name;
}
