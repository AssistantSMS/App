import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RatingOvalPainter extends CustomPainter {
  RatingOvalPainter(this.isActive, this.endColour);

  final bool isActive;
  final Color endColour;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    if (isActive) {
      paint.shader = ui.Gradient.linear(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        [
          Colors.yellow,
          endColour,
        ],
      );
    } else {
      paint.color = Colors.black45;
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: 10,
          height: size.height,
        ),
        const Radius.circular(12),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(RatingOvalPainter oldDelegate) {
    return isActive != oldDelegate.isActive;
  }
}
