import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedLoadingStarBurst extends StatefulWidget {
  final double radius;
  final Duration speed;
  final Color color;
  final double size;
  final double particleBorderRadius;

  const AnimatedLoadingStarBurst({
    Key? key,
    this.radius = 100.0,
    this.speed = const Duration(seconds: 1),
    this.color = Colors.black,
    this.size = 10.0,
    this.particleBorderRadius = 10.0,
  }) : super(key: key);

  @override
  State<AnimatedLoadingStarBurst> createState() => _AnimatedLoadingStarBurstState();
}

class _AnimatedLoadingStarBurstState extends State<AnimatedLoadingStarBurst>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.speed,
      vsync: this,
    );

    _animations = List.generate(12, (index) {
      return Tween<double>(begin: widget.radius, end: 0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index % 2 == 0 ? 0.5 : 0,
            1,
            curve: Curves.easeInOut,
          ),
        ),
      )..addListener(() {
        setState(() {});
      });
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
            (index * (pi / 3)).toDouble(),
            _animations[index].value,
          ),
          child: Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.particleBorderRadius),
            ),
          ),
        );
      }),
    );
  }
}
