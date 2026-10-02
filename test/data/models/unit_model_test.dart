import 'package:flutter_test/flutter_test.dart';
import 'package:ef_app/data/models/unit_model.dart';

void main() {
  final now = DateTime.now();

  group('UnitModel fromJson', () {
    test('parses valid JSON correctly', () {
      final json = {
        'unit_id': 'unit_1',
        'title': 'Calentamiento',
        'order': 1,
        'course': '1_eso',
        'color_hex': '#FF6B35',
        'total_xp': 500,
        'description': 'Unidad de prueba',
        'icon': 'fire',
        'created_at': '2024-01-01T00:00:00.000',
      };

      final unit = UnitModel.fromJson(json);

      expect(unit.unitId, 'unit_1');
      expect(unit.title, 'Calentamiento');
      expect(unit.order, 1);
      expect(unit.course, '1_eso');
      expect(unit.colorHex, '#FF6B35');
      expect(unit.totalXP, 500);
    });
  });

  group('UnitModel toJson', () {
    test('serializes correctly', () {
      final unit = UnitModel(
        unitId: 'u1',
        title: 'Test',
        order: 2,
        course: '2_eso',
        trimester: 1,
        colorHex: '#00D4FF',
        totalXP: 300,
        createdAt: now,
        updatedAt: now,
      );

      final json = unit.toJson();

      expect(json['id'], 'u1');
      expect(json['total_xp'], 300);
    });
  });
}
