import 'package:flutter/material.dart';
import 'dart:ui' as ui;

Widget ratingOval(bool isActive, Color endColour) {
  return CustomPaint(
    size: Size.infinite,
    painter: RatingOvalPainter(isActive, endColour),
  );
}

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
        Radius.circular(12),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(RatingOvalPainter oldDelegate) {
    return isActive != oldDelegate.isActive;
  }
}
