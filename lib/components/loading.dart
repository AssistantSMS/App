import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/AppImage.dart';

class CustomSpinner extends StatefulWidget {
  final double height;
  final double width;
  final Duration spinDuration;
  CustomSpinner({
    this.height = 50.0,
    this.width = 50.0,
    this.spinDuration = const Duration(seconds: 2),
  });

  @override
  _CustomSpinnerWidget createState() => _CustomSpinnerWidget();
}

class _CustomSpinnerWidget extends State<CustomSpinner>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.spinDuration,
      vsync: this,
    );

    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.repeat();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: SizedBox(
        child: Image(
          image: AssetImage(AppImage.customLoading),
        ),
        height: widget.height,
        width: widget.width,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
