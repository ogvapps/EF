import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/utils/validators.dart';
import '../../../shared/widgets/animated_widgets.dart';
import '../../../shared/widgets/rewards_widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
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
      body: AnimatedGradientBackground(
        colors: AppTheme.bgGradient,
        duration: const Duration(seconds: 8),
        child: Stack(
          children: [
            const FloatingParticles(color: AppTheme.secondary, count: 8),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 440),
                    child: Form(
                      key: _formKey,
                      child: StaggeredFadeIn(
                        delayPerChild: const Duration(milliseconds: 100),
                        children: [
                          const SizedBox(height: 40),
                          const _Logo(),
                          const SizedBox(height: 32),
                          _buildGlassCard([
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                              validator: Validators.email,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Contrase\u00f1a',
                                prefixIcon: const Icon(Icons.lock_outlined),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white54,
                                  ),
                                  onPressed: () =>
                                      setState(() => _obscurePassword = !_obscurePassword),
                                ),
                              ),
                              validator: Validators.password,
                            ),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => _showResetPasswordDialog(context),
                                child: const Text(
                                  '\u00bfOlvidaste tu contrase\u00f1a?',
                                  style: TextStyle(
                                    color: AppTheme.secondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            if (authState.status == AuthStatus.error && authState.errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppTheme.error.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppTheme.error.withValues(alpha: 0.2)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.error_outline, color: AppTheme.error, size: 18),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          authState.errorMessage!,
                                          style: const TextStyle(color: AppTheme.error, fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8),
                            CustomButton(
                              text: 'Iniciar sesi\u00f3n',
                              isLoading: authState.status == AuthStatus.loading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ref.read(authProvider.notifier).loginWithEmail(
                                        _emailController.text.trim(),
                                        _passwordController.text,
                                      );
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.08))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text('o',
                                      style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                                ),
                                Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.08))),
                              ],
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: _isGoogleLoading
                                  ? null
                                  : () async {
                                      setState(() => _isGoogleLoading = true);
                                      try {
                                        await ref.read(authProvider.notifier).loginWithGoogle();
                                      } finally {
                                        if (mounted) setState(() => _isGoogleLoading = false);
                                      }
                                    },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                backgroundColor: Colors.white.withValues(alpha: 0.03),
                              ),
                              icon: _isGoogleLoading
                                  ? const SizedBox(
                                      width: 20, height: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2, color: Colors.white),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Text('G',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF4285F4),
                                          )),
                                    ),
                              label: Text(
                                _isGoogleLoading
                                    ? 'Iniciando sesi\u00f3n...'
                                    : 'Continuar con Google',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ]),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\u00bfNo tienes cuenta? ',
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                              ),
                              TextButton(
                                onPressed: () => context.go('/auth/register'),
                                child: const Text(
                                  'Reg\u00edstrate',
                                  style: TextStyle(
                                    color: AppTheme.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(children: children),
    );
  }

  void _showResetPasswordDialog(BuildContext context) {
    final emailController = TextEditingController();
    var isLoading = false;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          return AlertDialog(
            title: const Text('Restablecer contraseña'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Introduce tu email y te enviaremos un enlace.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: isLoading ? null : () => Navigator.pop(ctx),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        final email = emailController.text.trim();
                        if (email.isEmpty) return;
                        setDialogState(() => isLoading = true);
                        try {
                          await ref.read(authRepositoryProvider).sendPasswordReset(email);
                          if (ctx.mounted) {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Email enviado. Revisa tu bandeja.')),
                            );
                          }
                        } catch (e) {
                          setDialogState(() => isLoading = false);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        width: 20, height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primary),
                      )
                    : const Text('Enviar', style: TextStyle(color: AppTheme.primary)),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppTheme.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.3),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Center(
            child: Text('EF',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                )),
          ),
        ),
        const SizedBox(height: 12),
        const ShimmerText(
          text: 'Bienvenido',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          'Inicia sesión para continuar',
          style: TextStyle(fontSize: 15, color: Colors.white.withValues(alpha: 0.5)),
        ),
      ],
    );
  }
}
