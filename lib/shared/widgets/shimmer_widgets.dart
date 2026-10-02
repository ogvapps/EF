import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
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
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: LinearGradient(
            begin: Alignment(-_animation.value, 0),
            end: Alignment(_animation.value, 0),
            colors: [
              Colors.white.withValues(alpha: 0.04),
              AppTheme.primary.withValues(alpha: 0.08),
              Colors.white.withValues(alpha: 0.04),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final double spacing;

  const ShimmerList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (i) => Padding(
          padding: EdgeInsets.only(bottom: i < itemCount - 1 ? spacing : 0),
          child: ShimmerLoading(height: itemHeight),
        ),
      ),
    );
  }
}

class GlassCardShimmer extends StatelessWidget {
  final int count;

  const GlassCardShimmer({super.key, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (i) => Padding(
          padding: EdgeInsets.only(bottom: i < count - 1 ? 12 : 0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: const ShimmerLoading(height: 100, borderRadius: 16),
          ),
        ),
      ),
    );
  }
}
