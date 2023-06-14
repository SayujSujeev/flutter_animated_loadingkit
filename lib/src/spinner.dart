import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedLoadingSpinner extends StatefulWidget {
  final Duration speed;
  final Duration delay;
  final double circleRadius;
  final Color circleColor;
  final Size size;

  const AnimatedLoadingSpinner({
    Key? key,
    this.speed = const Duration(seconds: 1),
    this.delay = const Duration(seconds: 1),
    this.circleRadius = 5.0,
    this.circleColor = Colors.black,
    this.size = const Size(50, 50),
  }) : super(key: key);

  @override
  State<AnimatedLoadingSpinner> createState() => _AnimatedLoadingSpinnerState();
}

class _Controller extends AnimationController {
  _Controller({
    required Duration duration,
    required TickerProvider vsync,
  }) : super(duration: duration, vsync: vsync);

  bool isDisposed = false;

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}

class _AnimatedLoadingSpinnerState extends State<AnimatedLoadingSpinner> with SingleTickerProviderStateMixin {
  late _Controller _controller;

  @override
  void initState() {
    super.initState();
    _controller = _Controller(
      duration: widget.speed,
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(widget.delay).then((_) {
          if (_controller.isDisposed) return;
          _controller.reset();
          _controller.forward();
        });
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.rotate(
        angle: _controller.value * 21 * pi / 4,
        child: CustomPaint(
          painter: CirclesPainter(
            circleRadius: widget.circleRadius,
            circleColor: widget.circleColor,
          ),
          child: SizedBox(
            width: widget.size.width,
            height: widget.size.height,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CirclesPainter extends CustomPainter {
  final double circleRadius;
  final Color circleColor;

  CirclesPainter({
    required this.circleRadius,
    required this.circleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.fill;

    List<Offset> points = [
      Offset(circleRadius, circleRadius),
      Offset(size.width - circleRadius, circleRadius),
      Offset(circleRadius, size.height - circleRadius),
      Offset(size.width - circleRadius, size.height - circleRadius),
    ];

    for (var point in points) {
      canvas.drawCircle(point, circleRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
