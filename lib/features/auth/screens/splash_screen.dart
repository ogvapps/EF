import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/animated_widgets.dart';
import '../../../shared/widgets/rewards_widgets.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scale;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _scale = Tween<double>(begin: 0.3, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _glow = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() => setState(() {}));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (_, state) {
      if (state.status == AuthStatus.authenticated) {
        final route = state.isTeacher ? '/teacher' : '/home';
        context.go(route);
      } else if (state.status == AuthStatus.unauthenticated) {
        Future.delayed(const Duration(milliseconds: 2500), () {
          if (context.mounted) context.go('/auth');
        });
      }
    });

    return Scaffold(
      body: AnimatedGradientBackground(
        colors: AppTheme.bgGradient,
        duration: const Duration(seconds: 6),
        child: Stack(
          children: [
            const FloatingParticles(color: AppTheme.primary, count: 12),
            Center(
              child: FadeTransition(
                opacity: _fadeIn,
                child: ScaleTransition(
                  scale: _scale,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: AppTheme.primaryGradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(36),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primary.withValues(alpha: 0.3 * _glow.value),
                              blurRadius: 40 * _glow.value,
                              spreadRadius: 8 * _glow.value,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'EF',
                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'EF Quest',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const ShimmerText(
                        text: 'Educación Física · LOMLOE',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 48),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.primary.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
