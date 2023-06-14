import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedLoadingSpiralLines extends StatefulWidget {
  final int numberOfLines;
  final double baseRadius;
  final Color color;
  final double strokeWidth;

  const AnimatedLoadingSpiralLines({
    Key? key,
    this.numberOfLines = 5,
    this.baseRadius = 10.0,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
  }) : super(key: key);

  @override
  State<AnimatedLoadingSpiralLines> createState() => _AnimatedLoadingSpiralLinesState();
}

class _AnimatedLoadingSpiralLinesState extends State<AnimatedLoadingSpiralLines> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.numberOfLines,
          (index) => AnimationController(
        duration: Duration(seconds: 1 + index),
        vsync: this,
      )..repeat(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: List.generate(
        _controllers.length,
            (index) => AnimatedBuilder(
          animation: _controllers[index],
          builder: (_, __) => Transform.rotate(
            angle: _controllers[index].value * 2 * pi,
            child: CustomPaint(
              painter: SemiCirclePainter(
                radius: widget.baseRadius * (index + 1),
                color: widget.color,
                strokeWidth: widget.strokeWidth,
              ),
            ),
          ),
        ),
      ),
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

class SemiCirclePainter extends CustomPainter {
  final double radius;
  final Color color;
  final double strokeWidth;

  SemiCirclePainter({
    required this.radius,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(rect, 0, pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
