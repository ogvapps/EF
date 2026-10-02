import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((s) => s.user));

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Perfil', style: TextStyle(color: Colors.white)),
      ),
      body: user == null
          ? const Center(child: Text('Usuario no encontrado', style: TextStyle(color: Colors.white54)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(child: Text('👤', style: TextStyle(fontSize: 48))),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.displayName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatItem(emoji: '⭐', label: 'Nivel', value: '${user.level}'),
                        _StatItem(emoji: '⚡', label: 'XP', value: '${user.xp}'),
                        _StatItem(emoji: '🪙', label: 'Monedas', value: '${user.coins}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Text('📚', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Curso', style: TextStyle(color: Colors.white54, fontSize: 12)),
                            Text(user.course, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => ref.read(authProvider.notifier).signOut(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withValues(alpha: 0.1),
                        foregroundColor: Colors.red,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Cerrar sesión'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;

  const _StatItem({required this.emoji, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
      ],
    );
  }
}
