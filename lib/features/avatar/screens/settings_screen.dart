import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _notificationsProvider = StateProvider<bool>((ref) => true);
final _soundProvider = StateProvider<bool>((ref) => true);
final _vibrationProvider = StateProvider<bool>((ref) => true);
final _darkModeProvider = StateProvider<bool>((ref) => true);

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Ajustes', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Preferencias',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white54),
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notificaciones',
            trailing: Switch(
              value: ref.watch(_notificationsProvider),
              onChanged: (v) => ref.read(_notificationsProvider.notifier).state = v,
              activeColor: const Color(0xFF4CAF50),
            ),
          ),
          _SettingsTile(
            icon: Icons.volume_up_outlined,
            title: 'Sonido',
            trailing: Switch(
              value: ref.watch(_soundProvider),
              onChanged: (v) => ref.read(_soundProvider.notifier).state = v,
              activeColor: const Color(0xFF4CAF50),
            ),
          ),
          _SettingsTile(
            icon: Icons.vibration,
            title: 'Vibración',
            trailing: Switch(
              value: ref.watch(_vibrationProvider),
              onChanged: (v) => ref.read(_vibrationProvider.notifier).state = v,
              activeColor: const Color(0xFF4CAF50),
            ),
          ),
          _SettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Modo oscuro',
            trailing: Switch(
              value: ref.watch(_darkModeProvider),
              onChanged: (v) => ref.read(_darkModeProvider.notifier).state = v,
              activeColor: const Color(0xFF4CAF50),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Cuenta',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white54),
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.person_outline,
            title: 'Editar perfil',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.lock_outline,
            title: 'Cambiar contraseña',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.delete_outline,
            title: 'Eliminar cuenta',
            titleColor: Colors.red,
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Text(
            'Información',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white54),
          ),
          const SizedBox(height: 8),
          _SettingsTile(
            icon: Icons.info_outline,
            title: 'Acerca de EF Quest',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.description_outlined,
            title: 'Términos y condiciones',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.shield_outlined,
            title: 'Privacidad',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        leading: Icon(icon, color: titleColor ?? Colors.white54, size: 22),
        title: Text(
          title,
          style: TextStyle(
            color: titleColor ?? Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.3)),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.white.withValues(alpha: 0.03),
      ),
    );
  }
}
