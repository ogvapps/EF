import 'package:freezed_annotation/freezed_annotation.dart';

enum UserRole {
  @JsonValue('alumno')
  alumno,
  @JsonValue('profesor')
  profesor,
  @JsonValue('admin')
  admin;

  String get value {
    switch (this) {
      case UserRole.alumno:
        return 'alumno';
      case UserRole.profesor:
        return 'profesor';
      case UserRole.admin:
        return 'admin';
    }
  }

  static UserRole fromString(String value) {
    switch (value) {
      case 'alumno':
        return UserRole.alumno;
      case 'profesor':
        return UserRole.profesor;
      case 'admin':
        return UserRole.admin;
      default:
        throw ArgumentError('Invalid UserRole: $value');
    }
  }

  static UserRole fromJson(String s) => fromString(s);
  static String toJson(UserRole r) => r.value;
}
