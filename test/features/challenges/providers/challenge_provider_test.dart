import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ef_app/core/enums/challenge_type.dart';
import 'package:ef_app/features/challenges/providers/challenge_provider.dart';
import 'package:ef_app/data/models/challenge_model.dart';

void main() {
  group('ChallengeNotifier', () {
    late ChallengeModel challenge;
    late ProviderContainer container;
    late ChallengeNotifier notifier;

    setUp(() {
      challenge = ChallengeModel(
        challengeId: 'ch_test',
        title: 'Test',
        type: ChallengeType.strength,
        goalValue: 20,
        minValue: 10,
        maxValue: 30,
        adaptiveIncrement: 1,
        unitId: 'u1',
        order: 1,
        createdAt: DateTime.now(),
      );
      container = ProviderContainer();
      notifier = container.read(challengeProvider(challenge).notifier);
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is ready', () {
      expect(notifier.state.status, ChallengeStatus.ready);
      expect(notifier.state.adaptedGoal, 20);
    });

    test('setAdaptedGoal updates goal when ready', () {
      notifier.setAdaptedGoal(25);
      expect(notifier.state.adaptedGoal, 25);
    });

    test('setAdaptedGoal does not update when not ready', () {
      notifier.startCountdown();
      notifier.setAdaptedGoal(30);
      expect(notifier.state.adaptedGoal, 20);
    });

    test('startCountdown transitions to countdown', () {
      notifier.startCountdown();
      expect(notifier.state.status, ChallengeStatus.countdown);
    });

    test('complete with zero value gives 0 stars', () {
      notifier.startCountdown();
      notifier.updateValue(0);
      notifier.completeManually();
      expect(notifier.state.status, ChallengeStatus.failed);
      expect(notifier.state.stars, 0);
    });
  });
}
