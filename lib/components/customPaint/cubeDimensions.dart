import 'package:flutter/material.dart';

Widget cubeDimension() {
  return CustomPaint(
    size: Size.infinite,
    painter: CubeDimensionPainter(color: Colors.red),
  );
}

class CubeDimensionPainter extends CustomPainter {
  CubeDimensionPainter({@required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.strokeWidth = 2;

    var cubeWidth = size.width * 0.75;
    var cubeHeight = size.height * 0.75;

    var topTopLeft = Offset(size.width - cubeWidth, 0);
    var topRight = Offset(size.width, 0);
    var bottomRight = Offset(size.width, cubeHeight);
    var bottomBottomRight = Offset(cubeWidth, size.height);
    var bottomLeft = Offset(0, size.height);
    var topLeft = Offset(0, size.height - cubeHeight);

    var middle = Offset(cubeWidth, size.height - cubeHeight);

    canvas.drawLine(topTopLeft, topRight, paint);
    canvas.drawLine(topRight, bottomRight, paint);
    canvas.drawLine(bottomRight, bottomBottomRight, paint);
    canvas.drawLine(bottomBottomRight, bottomLeft, paint);
    canvas.drawLine(bottomLeft, topLeft, paint);
    canvas.drawLine(topLeft, topTopLeft, paint);

    canvas.drawLine(middle, topLeft, paint);
    canvas.drawLine(middle, topRight, paint);
    canvas.drawLine(middle, bottomBottomRight, paint);
  }

  @override
  bool shouldRepaint(CubeDimensionPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
