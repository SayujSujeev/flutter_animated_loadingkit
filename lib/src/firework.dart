import 'package:flutter/material.dart';
import 'dart:math';

class Firework extends StatefulWidget {
  final Duration speed;
  final Color color;
  final double thickness;
  final int numberOfLines;

  const Firework({
    Key? key,
    this.speed = const Duration(seconds: 2),
    this.color = Colors.black,
    this.thickness = 3.0,
    this.numberOfLines = 16,
  }) : super(key: key);

  @override
  State<Firework> createState() => _FireworkState();
}

class _FireworkState extends State<Firework> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.speed,
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.rotate(
        angle: _controller.value * 2 * pi,
        child: Transform.scale(
          scale: _controller.value,
          child: CustomPaint(
            painter: LinesPainter(
              color: widget.color,
              thickness: widget.thickness,
              numberOfLines: widget.numberOfLines,
            ),
            child: const SizedBox(
              width: 150,
              height: 150,
            ),
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

class LinesPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final int numberOfLines;

  LinesPainter({
    required this.color,
    required this.thickness,
    required this.numberOfLines,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    for (int i = 0; i < numberOfLines; i++) {
      final startAngle = 2 * pi / numberOfLines * i;
      final startPoint = Offset(size.width / 2 * (1 + cos(startAngle)), size.height / 2 * (1 + sin(startAngle)));
      final endPoint = Offset(size.width / 2 * (1 - cos(startAngle)), size.height / 2 * (1 - sin(startAngle)));
      canvas.drawLine(startPoint, endPoint, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
