import 'package:flutter/material.dart';

class AnimatedLoadingCircleSurge extends StatefulWidget {
  final double loaderWidth;
  final double loaderHeight;
  final double expandWidth;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Duration speed;

  const AnimatedLoadingCircleSurge({
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
  State<AnimatedLoadingCircleSurge> createState() => _AnimatedLoadingCircleSurgeState();
}

class _AnimatedLoadingCircleSurgeState extends State<AnimatedLoadingCircleSurge> {
  double width = 30.0;
  double height = 30.0;
  Alignment alignment = Alignment.topLeft;
  bool _animating = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _animateLoader());
  }

  void _animateLoader() async {
    while (_animating) {
      if (!mounted) return;

      setState(() {
        width = widget.expandWidth;
      });
      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        width = widget.loaderWidth;
        alignment = Alignment.topRight;
      });
      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        height = widget.expandWidth;
      });
      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        height = widget.loaderHeight;
        alignment = Alignment.bottomRight;
      });

      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        width = widget.expandWidth;
      });

      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        width = widget.loaderWidth;
        alignment = Alignment.bottomLeft;
      });

      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        height = widget.expandWidth;
      });

      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        height = widget.loaderHeight;
        alignment = Alignment.topLeft;
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
    return SizedBox(
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
    );
  }
}
