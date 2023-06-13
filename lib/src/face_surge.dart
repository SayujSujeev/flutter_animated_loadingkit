import 'package:flutter/material.dart';

class FaceSurge extends StatefulWidget {
  final double initWidth;
  final double initHeight;
  final double expandedWidth;
  final double expandedHeight;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final Duration speed;

  const FaceSurge({
    Key? key,
    this.initWidth = 30.0,
    this.initHeight = 30.0,
    this.expandedWidth = 70.0,
    this.expandedHeight = 70.0,
    this.borderColor = Colors.black,
    this.borderWidth = 10,
    this.borderRadius = 50,
    this.speed = const Duration(milliseconds: 600),
  }) : super(key: key);

  @override
  State<FaceSurge> createState() => _FaceSurgeState();
}

class _FaceSurgeState extends State<FaceSurge> {
  double? width1, height1, width2, height2, width3, height3;
  Alignment alignment1 = Alignment.topLeft;
  Alignment alignment2 = Alignment.topRight;
  Alignment alignment3 = Alignment.bottomLeft;

  final bool _animating = true;

  @override
  void initState() {
    super.initState();
    width1 = widget.initWidth;
    height1 = widget.initHeight;
    width2 = widget.initWidth;
    height2 = widget.initHeight;
    width3 = widget.expandedWidth;
    height3 = widget.initHeight;

    WidgetsBinding.instance.addPostFrameCallback((_) => _animateLoader());
  }

  void _animateLoader() async {
    while (_animating) {
      for (int i = 0; i < 2; i++) {

        if (!mounted) return;
        setState(() {
          width3 = 30.0;
          alignment3 = Alignment.bottomLeft;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height2 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height2 = 30.0;
          alignment2 = Alignment.bottomRight;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width1 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width1 = 30.0;
          alignment1 = Alignment.topRight;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height3 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height3 = 30.0;
          alignment3 = Alignment.topLeft;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width2 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width2 = 30.0;
          alignment2 = Alignment.bottomLeft;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height1 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height1 = 30.0;
          alignment1 = Alignment.bottomRight;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width3 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width3 = 30.0;
          alignment3 = Alignment.topRight;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height2 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height2 = 30.0;
          alignment2 = Alignment.topLeft;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width1 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width1 = 30.0;
          alignment1 = Alignment.bottomLeft;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height3 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height3 = 30.0;
          alignment3 = Alignment.bottomRight;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width2 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width2 = 30.0;
          alignment2 = Alignment.topRight;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height1 = 70.0;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          height1 = 30.0;
          alignment1 = Alignment.topLeft;
        });
        await Future.delayed(widget.speed);

        if (!mounted) return;
        setState(() {
          width3 = 70.0;
        });
        await Future.delayed(widget.speed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildAnimatedContainer(alignment1, width1!, height1!),
            _buildAnimatedContainer(alignment2, width2!, height2!),
            _buildAnimatedContainer(alignment3, width3!, height3!),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedContainer(Alignment alignment, double width, double height) {
    return SizedBox(
      height: widget.expandedHeight,
      width: widget.expandedWidth,
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