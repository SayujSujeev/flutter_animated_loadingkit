import 'package:flutter/material.dart';

class AnimatedLoadingJumpingDots extends StatefulWidget {
  final int numberOfDots;
  final Color color;
  final double dotSize;
  final double jumpingHeight;
  final Duration speed;
  final Duration delayBetweenBounces;

  const AnimatedLoadingJumpingDots({
    Key? key,
    this.numberOfDots = 3,
    this.color = Colors.black,
    this.dotSize = 10,
    this.jumpingHeight = 30,
    this.speed = const Duration(milliseconds: 300),
    this.delayBetweenBounces = const Duration(milliseconds: 50),
  }) : super(key: key);

  @override
  State<AnimatedLoadingJumpingDots> createState() => _AnimatedLoadingJumpingDotsState();
}

class _AnimatedLoadingJumpingDotsState extends State<AnimatedLoadingJumpingDots> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List<AnimationController>.generate(
      widget.numberOfDots,
          (i) => AnimationController(
        duration: widget.speed,
        vsync: this,
      )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllers[i].reverse();
        } else if (status == AnimationStatus.dismissed) {
          int nextIndex = (i + 1) % _controllers.length;
          _controllers[nextIndex].forward();
        }
      }),
    );
    _startBouncing();
  }

  void _startBouncing() async {
    for (var i = 0; i < _controllers.length; i++) {
      await Future.delayed(widget.delayBetweenBounces);
      _controllers[i].forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _controllers.map((controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (_, __) => Transform.translate(
            offset: Offset(0, -widget.jumpingHeight * controller.value),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: widget.dotSize,
                height: widget.dotSize,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
