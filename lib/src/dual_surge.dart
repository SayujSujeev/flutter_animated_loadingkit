import 'package:flutter/material.dart';

class AnimatedLoadingDualSurge extends StatefulWidget {
  final double loaderWidth;
  final double loaderHeight;
  final double expandWidth;
  final Color borderColor;
  final double borderWidth;
  final Duration speed;

  const AnimatedLoadingDualSurge({
    Key? key,
    this.loaderWidth = 30.0,
    this.loaderHeight = 30.0,
    this.expandWidth = 70.0,
    this.borderColor = Colors.black,
    this.borderWidth = 10,
    this.speed = const Duration(milliseconds: 600),
  }) : super(key: key);

  @override
  State<AnimatedLoadingDualSurge> createState() => _AnimatedLoadingDualSurgeState();
}

class _AnimatedLoadingDualSurgeState extends State<AnimatedLoadingDualSurge> {
  double? width1, height1, width2, height2;
  Alignment alignment1 = Alignment.topLeft;
  Alignment alignment2 = Alignment.bottomRight;
  bool _animating = true;

  @override
  void initState() {
    super.initState();
    width1 = widget.loaderWidth;
    height1 = widget.loaderHeight;
    width2 = widget.loaderWidth;
    height2 = widget.loaderHeight;

    WidgetsBinding.instance.addPostFrameCallback((_) => _animateLoader());
  }

  void _animateLoader() async {
    while (_animating) {
      if (!mounted) return;

      setState(() {
        width1 = widget.expandWidth;
        width2 = widget.expandWidth;
      });
      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        width1 = widget.loaderWidth;
        alignment1 = Alignment.topRight;
        width2 = widget.loaderWidth;
        alignment2 = Alignment.bottomLeft;
      });
      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        height1 = widget.expandWidth;
        height2 = widget.expandWidth;
      });
      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        height1 = widget.loaderHeight;
        alignment1 = Alignment.bottomRight;
        height2 = widget.loaderHeight;
        alignment2 = Alignment.topLeft;
      });

      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        width1 = widget.expandWidth;
        width2 = widget.expandWidth;
      });

      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        width1 = widget.loaderWidth;
        alignment1 = Alignment.bottomLeft;
        width2 = widget.loaderWidth;
        alignment2 = Alignment.topRight;
      });

      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        height1 = widget.expandWidth;
        height2 = widget.expandWidth;
      });

      await Future.delayed(widget.speed);

      if (!mounted) return;

      setState(() {
        height1 = widget.loaderHeight;
        alignment1 = Alignment.topLeft;
        height2 = widget.loaderHeight;
        alignment2 = Alignment.bottomRight;
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
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _buildAnimatedContainer(alignment1, width1!, height1!),
        _buildAnimatedContainer(alignment2, width2!, height2!),
      ],
    );
  }

  Widget _buildAnimatedContainer(Alignment alignment, double width, double height) {
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
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
