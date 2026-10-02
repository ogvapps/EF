import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final _pages = const [
    _PageData(
      emoji: '🏃',
      title: 'Tu cuerpo en acción',
      desc: 'Aprende Educación Física de forma divertida con retos, juegos y misiones.',
      gradient: [Color(0xFF7C4DFF), Color(0xFF448AFF)],
      features: ['Retos físicos diarios', 'Seguimiento de actividad', 'Rutinas personalizadas'],
    ),
    _PageData(
      emoji: '🎮',
      title: 'Juega y progresa',
      desc: 'Gana XP completando lecciones y retos. Sube de nivel y desbloquea logros.',
      gradient: [Color(0xFFFF6B9D), Color(0xFFFF8A65)],
      features: ['Sistema de niveles y XP', 'Avatares personalizables', 'Logros y medallas'],
    ),
    _PageData(
      emoji: '🤖',
      title: 'IA adaptativa',
      desc: 'La app se adapta a tu nivel con retos ajustados a tu rendimiento.',
      gradient: [Color(0xFF00D4FF), Color(0xFF7C4DFF)],
      features: ['Dificultad adaptativa', 'Feedback inteligente', 'Recomendaciones a medida'],
    ),
    _PageData(
      emoji: '📊',
      title: 'Tu progreso visible',
      desc: 'Sigue tu evolución en seis atributos. ¡Conviértete en un estudiante Élite!',
      gradient: [Color(0xFF00E676), Color(0xFF00BCD4)],
      features: ['Gráficos de progreso', 'Comparativa con tu clase', 'Racha de días activos'],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _pageController.hasClients
            ? _pageController.position as Listenable
            : Listenable.merge([]),
        builder: (_, __) {
          final page = _pages[_currentPage];
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: page.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () => context.go('/auth'),
                      child: const Text('Saltar',
                          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (i) => setState(() => _currentPage = i),
                      itemCount: _pages.length,
                      itemBuilder: (_, i) => _OnboardingPage(data: _pages[i]),
                    ),
                  ),
                  _buildDots(),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage < _pages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOutCubic,
                            );
                          } else {
                            context.go('/auth');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: page.gradient.first,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: Colors.black.withValues(alpha: 0.2),
                        ),
                        child: Text(
                          _currentPage < _pages.length - 1 ? 'Siguiente' : '¡Empezar!',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (i) => GestureDetector(
          onTap: () => _pageController.animateToPage(
            i,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: _currentPage == i ? 28 : 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: _currentPage == i ? 1 : 0.35),
              borderRadius: BorderRadius.circular(5),
              boxShadow: _currentPage == i
                  ? [BoxShadow(
                      color: Colors.white.withValues(alpha: 0.3),
                      blurRadius: 8,
                    )]
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _PageData {
  final String emoji;
  final String title;
  final String desc;
  final List<Color> gradient;
  final List<String> features;
  const _PageData({
    required this.emoji,
    required this.title,
    required this.desc,
    required this.gradient,
    required this.features,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _PageData data;
  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            builder: (_, scale, __) => Transform.scale(
              scale: scale,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                ),
                child: Center(
                  child: Text(data.emoji, style: const TextStyle(fontSize: 60)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            data.desc,
            style: TextStyle(
              fontSize: 16, color: Colors.white.withValues(alpha: 0.85), height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          ...data.features.map((f) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 14),
                ),
                const SizedBox(width: 10),
                Text(f, style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 15)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
