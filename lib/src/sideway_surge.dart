import 'package:flutter/material.dart';

class AnimatedLoadingSideWaySurge extends StatefulWidget {
  final double initWidth;
  final double initHeight;
  final double expandWidth;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Duration speed;

  const AnimatedLoadingSideWaySurge({
    Key? key,
    this.initWidth = 30.0,
    this.initHeight = 30.0,
    this.expandWidth = 70.0,
    this.borderColor = Colors.black,
    this.borderWidth = 10,
    this.borderRadius = 50,
    this.speed = const Duration(milliseconds: 600),
  }) : super(key: key);

  @override
  State<AnimatedLoadingSideWaySurge> createState() => _AnimatedLoadingSideWaySurgeState();
}

class _AnimatedLoadingSideWaySurgeState extends State<AnimatedLoadingSideWaySurge> {
  double? width;
  double? height;
  Alignment alignment = Alignment.centerLeft;
  bool _animating = true;

  @override
  void initState() {
    super.initState();
    width = widget.initWidth;
    height = widget.initHeight;

    WidgetsBinding.instance.addPostFrameCallback((_) => _animateLoader());
  }

  void _animateLoader() async {
    while (_animating) {
      // expand to the right
      setState(() {
        width = widget.expandWidth;
      });
      await Future.delayed(widget.speed);

      // Then, contract from the left
      setState(() {
        width = widget.initWidth;
        alignment = Alignment.centerRight;
      });
      await Future.delayed(widget.speed);

      // expand to the left
      setState(() {
        width = widget.expandWidth;
      });
      await Future.delayed(widget.speed);

      // contract from the right
      setState(() {
        width = widget.initWidth;
        alignment = Alignment.centerLeft;
      });

      await Future.delayed(widget.speed);
    }
  }

  @override
  void dispose() {
    _animating = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.expandWidth,
        width: widget.expandWidth,
        child: Align(
          alignment: alignment,
          child: AnimatedContainer(
            duration: widget.speed,
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: widget.borderColor, width: widget.borderWidth),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}
