import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    const Gradient gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        Color.fromRGBO(227, 0, 20, 1),
        Color.fromRGBO(191, 0, 10, 1)
      ],
    );

    var paint = Paint();
    paint.shader =
        gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height - 30);
    path.cubicTo(size.width / 4, size.height - 60, size.width / 2, size.height,
        size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}