import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_animated_loadingkit/painters/infinity_painter.dart';

class AnimatedLoadingInfinitySpin extends StatefulWidget {
  final Duration speed;
  final double strokeWidth;
  final Color color;
  final Size size;

  const AnimatedLoadingInfinitySpin({
    Key? key,
    this.speed = const Duration(seconds: 3),
    this.strokeWidth = 3.0,
    this.color = Colors.black,
    this.size = const Size(70, 70),
  }) : super(key: key);

  @override
  State<AnimatedLoadingInfinitySpin> createState() => _AnimatedLoadingInfinitySpinState();
}

class _AnimatedLoadingInfinitySpinState extends State<AnimatedLoadingInfinitySpin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.speed,
      vsync: this,
    )..repeat();
    _animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 4 * pi)
            .chain(CurveTween(curve: const Interval(0.0, 0.66))),
        weight: 66,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 4 * pi, end: 6 * pi)
            .chain(CurveTween(curve: const Interval(0.66, 1.0))),
        weight: 33,
      ),
    ]).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Transform(
          transform: Matrix4.rotationX(_animation.value),
          alignment: Alignment.center,
          child: CustomPaint(
            painter: InfinityPainter(
              strokeWidth: widget.strokeWidth,
              color: widget.color,
            ),
            child: SizedBox(
              width: widget.size.width,
              height: widget.size.height,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
