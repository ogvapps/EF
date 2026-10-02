import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../../../core/enums/user_role.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/utils/validators.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _course = '1_eso';
  UserRole _role = UserRole.alumno;
  bool _obscurePassword = true;

  final _courses = [
    ('1_eso', '1º ESO'),
    ('2_eso', '2º ESO'),
    ('3_eso', '3º ESO'),
    ('4_eso', '4º ESO'),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (_, state) {
      if (state.status == AuthStatus.authenticated) {
        context.go(state.isTeacher ? '/teacher' : '/home');
      }
    });

    return Scaffold(
      backgroundColor: AppTheme.deepNavy,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.go('/auth'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Crear cuenta',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                // Nombre
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _decoration('Nombre completo', Icons.person_outline),
                  validator: Validators.name,
                ),
                const SizedBox(height: 16),
                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: _decoration('Email', Icons.email_outlined),
                  validator: Validators.email,
                ),
                const SizedBox(height: 16),
                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: _decoration('Contraseña', Icons.lock_outlined).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white54,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: Validators.password,
                ),
                const SizedBox(height: 16),
                // Curso
                DropdownButtonFormField<String>(
                  value: _course,
                  items: _courses.map((c) => DropdownMenuItem(
                    value: c.$1,
                    child: Text(c.$2, style: const TextStyle(color: Colors.white)),
                  )).toList(),
                  onChanged: (v) => setState(() => _course = v!),
                  dropdownColor: AppTheme.surface,
                  style: const TextStyle(color: Colors.white),
                  decoration: _decoration('Curso', Icons.school_outlined),
                ),
                const SizedBox(height: 16),
                // Rol
                Row(
                  children: [
                    Expanded(
                      child: _RoleCard(
                        icon: '🎒',
                        label: 'Alumno',
                        selected: _role == UserRole.alumno,
                        onTap: () => setState(() => _role = UserRole.alumno),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _RoleCard(
                        icon: '👨‍🏫',
                        label: 'Profesor',
                        selected: _role == UserRole.profesor,
                        onTap: () => setState(() => _role = UserRole.profesor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (authState.status == AuthStatus.error)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            authState.errorMessage ?? 'Error',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Crear cuenta',
                  isLoading: authState.status == AuthStatus.loading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(authProvider.notifier).register(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                            displayName: _nameController.text.trim(),
                            course: _course,
                            role: _role,
                          );
                    }
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('¿Ya tienes cuenta? ',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.6))),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Inicia sesión',
                          style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
      prefixIcon: Icon(icon, color: Colors.white54),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.08),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppTheme.primary),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primary.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppTheme.primary : Colors.white.withValues(alpha: 0.1),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: selected ? AppTheme.primary : Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
