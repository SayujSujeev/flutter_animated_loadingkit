import 'package:flutter/material.dart';

class AnimatedLoadingHeartBeat extends StatefulWidget {
  final Duration speed;
  final Color color;
  final double strokeWidth;
  final Size size;
  final double lineWidth;

  const AnimatedLoadingHeartBeat({
    Key? key,
    this.speed = const Duration(seconds: 2),
    this.color = Colors.black,
    this.strokeWidth = 3.0,
    this.size = const Size(70, 70),
    this.lineWidth = 20.0,
  }) : super(key: key);

  @override
  State<AnimatedLoadingHeartBeat> createState() => _AnimatedLoadingHeartBeatState();
}

class _AnimatedLoadingHeartBeatState extends State<AnimatedLoadingHeartBeat> with SingleTickerProviderStateMixin {
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
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          painter: HeartbeatPainter(
            color: Colors.transparent,
            strokeWidth: widget.strokeWidth,
            lineWidth: widget.lineWidth,
          ),
          child: SizedBox(
            height: widget.size.height,
            width: widget.size.width,
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => ClipRect(
            clipper: ProgressClipper(_controller.value),
            child: CustomPaint(
              painter: HeartbeatPainter(
                color: widget.color,
                strokeWidth: widget.strokeWidth,
                lineWidth: widget.lineWidth,
              ),
              child: SizedBox(
                height: widget.size.height,
                width: widget.size.width,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HeartbeatPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double lineWidth;

  HeartbeatPainter({
    this.color = Colors.transparent,
    this.strokeWidth = 3.0,
    this.lineWidth = 20.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width / 4, size.height / 2)
      ..lineTo(size.width / 3, size.height / 2 - lineWidth)
      ..lineTo(size.width / 2, size.height / 2 + lineWidth)
      ..lineTo(2 * size.width / 3, size.height / 2 - lineWidth)
      ..lineTo(3 * size.width / 4, size.height / 2)
      ..lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ProgressClipper extends CustomClipper<Rect> {
  final double progress;

  ProgressClipper(this.progress);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * progress, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
