import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../../data/models/challenge_model.dart';

// ── Dificultad adaptativa para retos ──
final adaptiveDifficultyProvider = FutureProvider.family<int, ChallengeModel>(
  (ref, challenge) async {
    final authState = ref.watch(authProvider);
    final uid = authState.user?.uid;
    if (uid == null) return 5;

    final attributes = ref.watch(userAttributesProvider);
    final avg = attributes.values.isEmpty
        ? 0
        : attributes.values.reduce((a, b) => a + b) ~/ attributes.length;

    if (avg < 20) return 3;
    if (avg < 40) return 5;
    if (avg < 60) return 7;
    return 9;
  },
);

// ── Valor adaptativo del reto ──
final adaptedChallengeValueProvider = Provider.family<double, ChallengeModel>(
  (ref, challenge) {
    final difficulty = ref.watch(adaptiveDifficultyProvider(challenge)).valueOrNull ?? 5;
    final base = challenge.goalValue;
    return base + (difficulty - 5) * challenge.adaptiveIncrement;
  },
);
