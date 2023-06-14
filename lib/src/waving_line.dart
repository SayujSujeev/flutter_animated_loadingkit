import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedLoadingWavingLine extends StatefulWidget {
  final Duration speed;
  final double height;
  final double width;
  final Color color;
  final double strokeWidth;

  const AnimatedLoadingWavingLine({
    Key? key,
    this.speed = const Duration(seconds: 1),
    this.height = 5.0,
    this.width = 70.0,
    this.color = Colors.black,
    this.strokeWidth = 5.0,
  }) : super(key: key);

  @override
  State<AnimatedLoadingWavingLine> createState() => _AnimatedLoadingWavingLineState();
}

class _AnimatedLoadingWavingLineState extends State<AnimatedLoadingWavingLine> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.speed,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => CustomPaint(
        painter: WavePainter(_controller.value, widget.color, widget.strokeWidth),
        child: SizedBox(
          height: widget.height,
          width: widget.width,
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

class WavePainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  WavePainter(this.progress, this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..quadraticBezierTo(
        size.width / 4,
        size.height / 2 + 20.0 * (math.sin(2 * math.pi * progress) + 1) / 2,
        size.width / 2,
        size.height / 2,
      )
      ..quadraticBezierTo(
        size.width * 3 / 4,
        size.height / 2 - 20.0 * (math.sin(2 * math.pi * progress) + 1) / 2,
        size.width,
        size.height / 2,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
