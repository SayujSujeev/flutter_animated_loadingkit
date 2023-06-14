import 'package:flutter/material.dart';
import 'dart:math';

class InfinityPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;

  InfinityPainter({
    this.strokeWidth = 3.0,
    this.color = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    var path = Path();

    var firstCircleCenter = Offset(size.width / 4, size.height / 2);
    var secondCircleCenter = Offset(3 * size.width / 4, size.height / 2);

    path.addArc(Rect.fromCircle(center: firstCircleCenter, radius: size.width / 4), 0, 2 * pi);
    path.addArc(Rect.fromCircle(center: secondCircleCenter, radius: size.width / 4), 0, 2 * pi);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}