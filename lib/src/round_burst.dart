import 'package:flutter/material.dart';
import 'dart:math';


class AnimatedLoadingRoundBurst extends StatefulWidget {
  final double radius;
  final Duration speed;
  final Color color;
  final double size;
  final double particleBorderRadius;

  const AnimatedLoadingRoundBurst({
    Key? key,
    this.radius = 100.0,
    this.speed = const Duration(seconds: 1),
    this.color = Colors.black,
    this.size = 10.0,
    this.particleBorderRadius = 0,
  }) : super(key: key);

  @override
  State<AnimatedLoadingRoundBurst> createState() => _AnimatedLoadingRoundBurstState();
}

class _AnimatedLoadingRoundBurstState extends State<AnimatedLoadingRoundBurst> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.speed,
      vsync: this,
    );

    _animation = Tween<double>(begin: widget.radius, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(12, (index) {
        return Transform.translate(
          offset: Offset.fromDirection(
            (index * (pi / 6)).toDouble(),
            _animation.value,
          ),
          child: Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(widget.particleBorderRadius)
            ),
          ),
        );
      }),
    );
  }
}
