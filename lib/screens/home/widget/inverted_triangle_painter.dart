

import 'package:flutter/material.dart';

class InvertedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF99D3EA)
      ..style = PaintingStyle.fill;

    const radius = 2.0;
    const vertex1 = Offset(0, 0);
    final vertex2 = Offset(size.width, 0);
    final vertex3 = Offset(size.width / 2, size.height);

    final path = Path();
    path.moveTo(vertex1.dx + radius , vertex1.dy); // 왼쪽 상단
    path.lineTo(vertex2.dx - radius, vertex2.dy); // 오른쪽 상단
    path.arcToPoint(
      Offset(vertex2.dx, vertex2.dy + radius),
      radius: const Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(vertex3.dx + radius, vertex3.dy - radius); // 아래 중앙
    path.arcToPoint(
      Offset(vertex3.dx - radius, vertex3.dy - radius),
      radius: const Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(vertex1.dx, vertex1.dy + radius);
    path.arcToPoint(
      Offset(vertex1.dx + radius, vertex1.dy),
      radius: const Radius.circular(radius),
      clockwise: true,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}