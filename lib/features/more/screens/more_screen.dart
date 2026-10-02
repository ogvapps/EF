import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/providers/auth_providers.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Más',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
              ),
              const SizedBox(height: 24),

              // Profile card
              GestureDetector(
                onTap: () => context.push('/more/perfil'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            user?.displayName.isNotEmpty == true
                                ? user!.displayName[0].toUpperCase()
                                : '?',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF4CAF50)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.displayName ?? 'Explorador',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            Text(
                              'Nivel ${user?.level ?? 1} · ${user?.course.replaceFirst('_', ' ').toUpperCase() ?? ''}',
                              style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.5)),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.white38),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Stats preview
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Text('⚡', style: TextStyle(fontSize: 24)),
                          Text('${user?.xp ?? 0}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                          Text('XP', style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.6))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9800).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Text('🔥', style: TextStyle(fontSize: 24)),
                          Text('${user?.streak ?? 0}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                          Text('Racha', style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.6))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const Text('🪙', style: TextStyle(fontSize: 24)),
                          Text('${user?.coins ?? 0}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                          Text('Monedas', style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.6))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Menu tiles
              _MenuTile(
                icon: '🏆',
                title: 'Clasificación',
                subtitle: 'Compara tu progreso con tus compañeros',
                onTap: () => context.push('/more/leaderboard'),
              ),
              const SizedBox(height: 8),
              _MenuTile(
                icon: '🏅',
                title: 'Logros',
                subtitle: 'Medallas, trofeos y desafíos completados',
                onTap: () => context.push('/more/logros'),
              ),
              const SizedBox(height: 8),
              _MenuTile(
                icon: '⚙️',
                title: 'Ajustes',
                subtitle: 'Notificaciones, sonido, privacidad y cuenta',
                onTap: () => context.push('/more/ajustes'),
              ),
              const SizedBox(height: 8),
              _MenuTile(
                icon: '❓',
                title: 'Ayuda',
                subtitle: 'Preguntas frecuentes y soporte técnico',
                onTap: () {},
              ),

              if (authState.isTeacher) ...[
                const SizedBox(height: 24),
                const Text(
                  'Profesor',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                const SizedBox(height: 12),
                _MenuTile(
                  icon: '📊',
                  title: 'Panel docente',
                  subtitle: 'Gestiona tus clases, alumnado y estadísticas',
                  onTap: () => context.push('/teacher'),
                  isTeacher: true,
                ),
              ],

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _confirmLogout(context, ref),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.withValues(alpha: 0.3)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        title: const Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
        content: const Text('¿Seguro que quieres salir?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Color(0xFF4CAF50))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).signOut();
              context.go('/auth');
            },
            child: const Text('Salir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isTeacher;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isTeacher = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isTeacher
          ? const Color(0xFF4CAF50).withValues(alpha: 0.08)
          : Colors.white.withValues(alpha: 0.03),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                    Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.4))),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white24),
            ],
          ),
        ),
      ),
    );
  }
}
