import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BossFightPhase {
  final String title;
  final String description;
  final IconData icon;
  final int hp;
  final int damage;

  const BossFightPhase(this.title, this.description, this.icon, this.hp, this.damage);
}

class BossFightState {
  final int currentPhase;
  final int bossHP;
  final bool isCompleted;
  final bool isVictory;

  const BossFightState({
    this.currentPhase = 0,
    this.bossHP = 100,
    this.isCompleted = false,
    this.isVictory = false,
  });

  BossFightState copyWith({
    int? currentPhase,
    int? bossHP,
    bool? isCompleted,
    bool? isVictory,
  }) {
    return BossFightState(
      currentPhase: currentPhase ?? this.currentPhase,
      bossHP: bossHP ?? this.bossHP,
      isCompleted: isCompleted ?? this.isCompleted,
      isVictory: isVictory ?? this.isVictory,
    );
  }
}

class BossFightNotifier extends StateNotifier<BossFightState> {
  final List<BossFightPhase> phases;

  BossFightNotifier(this.phases, BossFightState initialState) : super(initialState);

  void attack() {
    final phase = phases[state.currentPhase];
    final newHP = state.bossHP - phase.damage;
    if (newHP <= 0) {
      state = state.copyWith(bossHP: 0, isCompleted: true, isVictory: true);
    } else if (state.currentPhase < phases.length - 1) {
      state = state.copyWith(bossHP: newHP, currentPhase: state.currentPhase + 1);
    } else {
      state = state.copyWith(bossHP: newHP, isCompleted: true, isVictory: false);
    }
  }
}

final bossFightProvider = StateNotifierProvider.autoDispose.family<BossFightNotifier, BossFightState, List<BossFightPhase>>(
  (ref, phases) {
    final totalHP = phases.fold<int>(0, (sum, p) => sum + p.hp);
    return BossFightNotifier(phases, BossFightState(bossHP: totalHP));
  },
);
