import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

// ─── Counter with easing ──────────────────────────────────
class AnimatedCounter extends StatefulWidget {
  final int target;
  final Duration duration;
  final TextStyle? style;

  const AnimatedCounter({
    super.key,
    required this.target,
    this.duration = const Duration(milliseconds: 800),
    this.style,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _display = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.addListener(() {
      setState(() {
        _display = (_animation.value * widget.target).round();
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.target != widget.target) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_display', style: widget.style);
  }
}

// ─── Staggered fade-in for column children ────────────────
class StaggeredFadeIn extends StatelessWidget {
  final List<Widget> children;
  final Duration delayPerChild;

  const StaggeredFadeIn({
    super.key,
    required this.children,
    this.delayPerChild = const Duration(milliseconds: 80),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children.asMap().entries.map((entry) {
        final i = entry.key;
        final child = entry.value;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500) + delayPerChild * i,
          curve: Curves.easeOutCubic,
          builder: (_, value, child) => Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 24 * (1 - value)),
              child: child,
            ),
          ),
          child: child,
        );
      }).toList(),
    );
  }
}

// ─── Staggered list for dynamic children ──────────────────
class StaggeredList extends StatelessWidget {
  final int itemCount;
  final Widget Function(int index) itemBuilder;
  final Duration delayPerItem;

  const StaggeredList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.delayPerItem = const Duration(milliseconds: 60),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (i) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 400) + delayPerItem * i,
          curve: Curves.easeOutCubic,
          builder: (_, value, child) => Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: child,
            ),
          ),
          child: itemBuilder(i),
        );
      }),
    );
  }
}

// ─── Scale on press (micro-interaction) ──────────────────
class ScaleOnPress extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double scale;

  const ScaleOnPress({
    super.key,
    required this.child,
    this.onPressed,
    this.scale = 0.94,
  });

  @override
  State<ScaleOnPress> createState() => _ScaleOnPressState();
}

class _ScaleOnPressState extends State<ScaleOnPress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppTheme.fastAnim,
    );
    _animation = Tween<double>(begin: 1.0, end: widget.scale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, child) => Transform.scale(
          scale: _animation.value,
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}

// ─── Pulsing widget (breathing effect) ────────────────────
class PulseWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double scale;

  const PulseWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.scale = 1.05,
  });

  @override
  State<PulseWidget> createState() => _PulseWidgetState();
}

class _PulseWidgetState extends State<PulseWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 1.0, end: widget.scale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) => Transform.scale(
        scale: _animation.value,
        child: child,
      ),
      child: widget.child,
    );
  }
}

// ─── Neon glow container ─────────────────────────────────
class NeonGlow extends StatelessWidget {
  final Widget child;
  final Color color;
  final double blur;

  const NeonGlow({
    super.key,
    required this.child,
    this.color = AppTheme.primary,
    this.blur = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: AppTheme.neonShadow(color, blur: blur),
      ),
      child: child,
    );
  }
}

// ─── Gradient sweep text ─────────────────────────────────
class GradientSweepText extends StatefulWidget {
  final String text;
  final List<Color> colors;
  final TextStyle? style;
  final Duration duration;

  const GradientSweepText({
    super.key,
    required this.text,
    this.colors = AppTheme.primaryGradient,
    this.style,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<GradientSweepText> createState() => _GradientSweepTextState();
}

class _GradientSweepTextState extends State<GradientSweepText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: widget.colors,
              stops: [
                (_controller.value - 0.3).clamp(0.0, 1.0),
                _controller.value.clamp(0.0, 1.0),
                (_controller.value + 0.3).clamp(0.0, 1.0),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: Text(widget.text, style: widget.style),
        );
      },
    );
  }
}

// ─── Animated gradient border ────────────────────────────
class AnimatedGradientBorder extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final double radius;
  final double width;
  final Duration duration;

  const AnimatedGradientBorder({
    super.key,
    required this.child,
    this.colors = AppTheme.primaryGradient,
    this.radius = 16,
    this.width = 1.5,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<AnimatedGradientBorder> createState() => _AnimatedGradientBorderState();
}

class _AnimatedGradientBorderState extends State<AnimatedGradientBorder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(
              color: Color.lerp(
                widget.colors[0],
                widget.colors[1 % widget.colors.length],
                _controller.value,
              )!,
              width: widget.width,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ─── Shimmer loading placeholder ─────────────────────────
class ShimmerContainer extends StatefulWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerContainer({
    super.key,
    this.width = double.infinity,
    this.height = 20,
    this.radius = 8,
  });

  @override
  State<ShimmerContainer> createState() => _ShimmerContainerState();
}

class _ShimmerContainerState extends State<ShimmerContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.04),
                Colors.white.withValues(alpha: 0.10),
                Colors.white.withValues(alpha: 0.04),
              ],
              stops: [
                (_controller.value - 0.3).clamp(0.0, 1.0),
                _controller.value.clamp(0.0, 1.0),
                (_controller.value + 0.3).clamp(0.0, 1.0),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        );
      },
    );
  }
}

// ─── Animated gradient background ────────────────────────
class AnimatedGradientBackground extends StatefulWidget {
  final List<Color> colors;
  final Widget child;
  final Duration duration;

  const AnimatedGradientBackground({
    super.key,
    required this.colors,
    required this.child,
    this.duration = const Duration(seconds: 6),
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final c = widget.colors;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(c[0], c[1 % c.length], _controller.value)!,
                Color.lerp(c[1 % c.length], c[2 % c.length], _controller.value)!,
              ],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ─── Floating particles (cosmic dust) ─────────────────────
class FloatingParticles extends StatefulWidget {
  final Color color;
  final int count;

  const FloatingParticles({
    super.key,
    this.color = AppTheme.primary,
    this.count = 10,
  });

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _particles = <_ParticleData>[];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.count; i++) {
      _particles.add(_ParticleData(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: 1.5 + _random.nextDouble() * 4,
        speed: 0.15 + _random.nextDouble() * 0.5,
        delay: _random.nextDouble(),
        driftX: (_random.nextDouble() - 0.5) * 0.03,
      ));
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => CustomPaint(
        painter: _ParticlePainter(
          particles: _particles,
          progress: _controller.value,
          color: widget.color,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _ParticleData {
  final double x, y, size, speed, delay, driftX;
  const _ParticleData({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.delay,
    this.driftX = 0,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_ParticleData> particles;
  final double progress;
  final Color color;

  _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final phase = (progress * p.speed + p.delay) % 1.0;
      final opacity = (1 - (phase - 0.5).abs() * 2).clamp(0.0, 1.0);
      final y = (p.y + phase * 0.06) % 1.0;
      final x = (p.x + phase * p.driftX + sin(phase * pi * 2) * 0.015) % 1.0;

      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        p.size,
        Paint()..color = color.withValues(alpha: opacity * 0.25),
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}
