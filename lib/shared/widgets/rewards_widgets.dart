import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'custom_button.dart';

class XpRewardPopup extends StatelessWidget {
  final int xp;
  final int coins;
  final VoidCallback onComplete;

  const XpRewardPopup({
    super.key,
    required this.xp,
    this.coins = 0,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.elasticOut,
        builder: (_, scale, __) => Transform.scale(
          scale: scale,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1F35), Color(0xFF141829)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppTheme.primary.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.15),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppTheme.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withValues(alpha: 0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Text('🎉', style: TextStyle(fontSize: 32)),
                ),
                const SizedBox(height: 20),
                const ShimmerText(
                  text: '¡Bien hecho!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                const SizedBox(height: 20),
                _RewardLine(
                  emoji: '⚡',
                  label: 'XP ganados',
                  value: '+$xp',
                  color: AppTheme.accent,
                ),
                if (coins > 0) ...[
                  const SizedBox(height: 8),
                  _RewardLine(
                    emoji: '🪙',
                    label: 'Monedas',
                    value: '+$coins',
                    color: AppTheme.gold,
                  ),
                ],
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Continuar',
                  onPressed: onComplete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ShimmerText({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white70, Colors.white, Colors.white70],
        stops: [0.0, 0.5, 1.0],
      ).createShader(bounds),
      child: Text(text, style: style),
    );
  }
}

class _RewardLine extends StatelessWidget {
  final String emoji;
  final String label;
  final String value;
  final Color color;

  const _RewardLine({
    required this.emoji,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.6))),
          const Spacer(),
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: int.parse(value.replaceAll('+', ''))),
            duration: const Duration(milliseconds: 600),
            builder: (_, val, __) => Text(
              '+$val',
              style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int stars;
  final int maxStars;
  final double size;

  const StarRating({
    super.key,
    required this.stars,
    this.maxStars = 3,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (i) {
        final filled = i < stars;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: filled ? 1.0 : 0.0),
          duration: Duration(milliseconds: 300 + (i * 200)),
          curve: Curves.elasticOut,
          builder: (_, scale, __) => Transform.scale(
            scale: scale,
            child: Icon(
              filled ? Icons.star : Icons.star_border,
              color: filled ? AppTheme.gold : Colors.white24,
              size: size,
            ),
          ),
        );
      }),
    );
  }
}
