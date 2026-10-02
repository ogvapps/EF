import 'package:flutter_test/flutter_test.dart';
import 'package:ef_app/core/enums/enums.dart';
import 'package:ef_app/data/models/user_model.dart';

void main() {
  final now = DateTime.now();

  group('UserModel fromJson', () {
    test('parses valid JSON correctly', () {
      final json = {
        'auth_id': 'test-uid',
        'email': 'test@test.com',
        'display_name': 'Test User',
        'course': '1_eso',
        'role': 'alumno',
        'xp': 150,
        'level': 3,
        'coins': 200,
        'streak': 5,
        'completed_units': ['unit_1', 'unit_2'],
        'last_active_date': '2024-01-01T00:00:00.000',
        'created_at': '2024-01-01T00:00:00.000',
        'updated_at': '2024-01-01T00:00:00.000',
        'last_login_at': '2024-01-01T00:00:00.000',
      };

      final user = UserModel.fromJson(json);

      expect(user.uid, 'test-uid');
      expect(user.email, 'test@test.com');
      expect(user.displayName, 'Test User');
      expect(user.course, '1_eso');
      expect(user.role, UserRole.alumno);
      expect(user.xp, 150);
      expect(user.level, 3);
      expect(user.coins, 200);
      expect(user.streak, 5);
      expect(user.completedUnits, ['unit_1', 'unit_2']);
    });

    test('parses minimal JSON with defaults', () {
      final json = {
        'auth_id': 'minimal-uid',
        'email': 'min@test.com',
        'last_active_date': '2024-01-01T00:00:00.000',
        'created_at': '2024-01-01T00:00:00.000',
        'updated_at': '2024-01-01T00:00:00.000',
        'last_login_at': '2024-01-01T00:00:00.000',
      };

      final user = UserModel.fromJson(json);

      expect(user.uid, 'minimal-uid');
      expect(user.displayName, '');
      expect(user.role, UserRole.alumno);
      expect(user.xp, 0);
      expect(user.level, 1);
    });
  });

  group('UserModel toJson', () {
    test('serializes correctly', () {
      final user = UserModel(
        uid: 'uid-1',
        email: 'a@b.com',
        displayName: 'Alice',
        role: UserRole.profesor,
        xp: 500,
        level: 5,
        lastActiveDate: now,
        createdAt: now,
        updatedAt: now,
        lastLoginAt: now,
      );

      final json = user.toJson();

      expect(json['auth_id'], 'uid-1');
      expect(json['email'], 'a@b.com');
      expect(json['display_name'], 'Alice');
      expect(json['role'], 'profesor');
    });
  });

  group('UserModel copyWith', () {
    test('preserves unset fields', () {
      final a = UserModel(
        uid: '1',
        email: 'a@b.com',
        displayName: '',
        lastActiveDate: now,
        createdAt: now,
        updatedAt: now,
        lastLoginAt: now,
      );
      final b = a.copyWith(displayName: 'Bob');

      expect(b.uid, '1');
      expect(b.email, 'a@b.com');
      expect(b.displayName, 'Bob');
    });
  });
}
