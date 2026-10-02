import 'package:flutter_test/flutter_test.dart';
import 'package:ef_app/core/enums/challenge_type.dart';
import 'package:ef_app/data/models/challenge_model.dart';

void main() {
  group('ChallengeModel', () {
    test('fromJson parses correctly', () {
      final json = {
        'challenge_id': 'ch_1',
        'title': 'Flexiones',
        'type': 'strength',
        'goal_value': 20,
        'min_value': 10,
        'max_value': 30,
        'adaptive_increment': 0.5,
        'unit_id': 'unit_1',
        'order': 1,
      };

      final c = ChallengeModel.fromJson(json);

      expect(c.challengeId, 'ch_1');
      expect(c.goalValue, 20);
      expect(c.minValue, 10);
      expect(c.adaptiveIncrement, 0.5);
    });

    test('creates with correct type and defaults', () {
      final c = ChallengeModel(
        challengeId: 'ch_2',
        title: 'Carrera',
        type: ChallengeType.cardio,
        goalValue: 100,
        minValue: 50,
        maxValue: 150,
        adaptiveIncrement: 1.0,
        unitId: 'unit_2',
        order: 2,
        createdAt: DateTime.now(),
      );

      expect(c.challengeId, 'ch_2');
      expect(c.type, ChallengeType.cardio);
      expect(c.goalValue, 100);
    });
  });
}
