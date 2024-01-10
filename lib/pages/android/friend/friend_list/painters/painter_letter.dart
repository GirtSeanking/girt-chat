import 'dart:math';

import 'package:flutter/material.dart';
import 'package:girt_chat/common/styles/layout.dart';

class PainterLetter extends CustomPainter {
  final String letter;

  PainterLetter(this.letter);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(-getWidth(3), getHeight(10));
    Paint paint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;

    Path path = Path();
    path.lineTo(0, -size.width);

    path.arcToPoint(Offset(size.width * 1.2, 0), radius: Radius.circular(size.width * 1.2), largeArc: true, clockwise: true,);
    path.close();
    canvas.save();
    canvas.rotate(pi * 1.2);
    canvas.drawPath(path, paint);
    canvas.restore();

    // 绘制文字
    var textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          fontSize: 24,
          foreground: Paint()..style = PaintingStyle.fill ..color = Colors.white,
        )
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    canvas.translate(-35, -53);
    textPainter.paint(canvas, Offset(0, getHeight(43)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}