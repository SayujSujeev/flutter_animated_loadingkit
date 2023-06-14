import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_animated_loadingkit/painters/infinity_painter.dart';

class AnimatedLoadingTango extends StatefulWidget {
  final Duration speed;
  final double strokeWidth;
  final Color color;
  final Size size;

  const AnimatedLoadingTango({
    Key? key,
    this.speed = const Duration(seconds: 2),
    this.strokeWidth = 3.0,
    this.color = Colors.black,
    this.size = const Size(70, 70),
  }) : super(key: key);

  @override
  State<AnimatedLoadingTango> createState() => _AnimatedLoadingTangoState();
}

class _AnimatedLoadingTangoState extends State<AnimatedLoadingTango> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.speed,
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.rotate(
          angle: _controller.value * 5 * pi,
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


