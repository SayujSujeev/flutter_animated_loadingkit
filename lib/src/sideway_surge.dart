import 'package:flutter/material.dart';

class AnimatedLoadingSideWaySurge extends StatefulWidget {
  final double loaderWidth;
  final double loaderHeight;
  final double expandWidth;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Duration speed;

  const AnimatedLoadingSideWaySurge({
    Key? key,
    this.loaderWidth = 30.0,
    this.loaderHeight = 30.0,
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
    width = widget.loaderWidth;
    height = widget.loaderHeight;

    WidgetsBinding.instance.addPostFrameCallback((_) => _animateLoader());
  }

  void _animateLoader() async {
    while (_animating) {
      setState(() {
        width = widget.expandWidth;
      });
      await Future.delayed(widget.speed);

      setState(() {
        width = widget.loaderWidth;
        alignment = Alignment.centerRight;
      });
      await Future.delayed(widget.speed);

      setState(() {
        width = widget.expandWidth;
      });
      await Future.delayed(widget.speed);

      setState(() {
        width = widget.loaderWidth;
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
