import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../services/haptic_service.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool fullWidth;
  final List<Color>? gradient;
  final Color? textColor;
  final IconData? icon;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.fullWidth = true,
    this.gradient,
    this.textColor,
    this.icon,
    this.height = 56,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _iconAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppTheme.fastAnim);
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _iconAnim = Tween<double>(begin: 1.0, end: 1.15).animate(
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
    final btn = AnimatedBuilder(
      animation: _scaleAnim,
      builder: (_, child) => Transform.scale(
        scale: _scaleAnim.value,
        child: child,
      ),
      child: GestureDetector(
        onTapDown: widget.onPressed == null
            ? null
            : (_) {
                HapticService.tap();
                _controller.forward();
              },
        onTapUp: widget.onPressed == null
            ? null
            : (_) {
                _controller.reverse();
                widget.onPressed?.call();
              },
        onTapCancel: () => _controller.reverse(),
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: widget.gradient ?? AppTheme.primaryGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: AppTheme.neonShadow(
              (widget.gradient ?? AppTheme.primaryGradient).first,
              blur: 16,
            ),
          ),
          child: Center(
            child: widget.isLoading
                ? const _LoadingDots()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        AnimatedBuilder(
                          animation: _iconAnim,
                          builder: (_, child) => Transform.scale(
                            scale: _iconAnim.value,
                            child: child,
                          ),
                          child: Icon(
                            widget.icon,
                            color: widget.textColor ?? Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      Text(widget.text, style: AppTheme.button),
                    ],
                  ),
          ),
        ),
      ),
    );

    if (widget.fullWidth) return SizedBox(width: double.infinity, child: btn);
    return btn;
  }
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final phase = (_controller.value + i * 0.25) % 1.0;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: switch (i) {
              0 => 3,
              1 => 3,
              _ => 3,
            }),
            child: Transform.translate(
              offset: Offset(0, -sin(phase * pi * 2) * 4),
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class GlassButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool fullWidth;

  const GlassButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final btn = Container(
      decoration: AppTheme.glassmorphism(radius: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                ],
                Text(text, style: AppTheme.button),
              ],
            ),
          ),
        ),
      ),
    );

    if (fullWidth) return SizedBox(width: double.infinity, child: btn);
    return btn;
  }
}
