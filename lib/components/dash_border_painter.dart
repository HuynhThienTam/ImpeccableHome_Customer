import 'package:flutter/cupertino.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashGap;

  DashedBorderPainter({
    required this.color,
    required this.dashWidth,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final dashTotal = dashWidth + dashGap;

    // Draw top border
    for (double i = 0; i < size.width; i += dashTotal) {
      path.moveTo(i, 0);
      path.lineTo(i + dashWidth, 0);
    }

    // Draw right border
    for (double i = 0; i < size.height; i += dashTotal) {
      path.moveTo(size.width, i);
      path.lineTo(size.width, i + dashWidth);
    }

    // Draw bottom border
    for (double i = size.width; i > 0; i -= dashTotal) {
      path.moveTo(i, size.height);
      path.lineTo(i - dashWidth, size.height);
    }

    // Draw left border
    for (double i = size.height; i > 0; i -= dashTotal) {
      path.moveTo(0, i);
      path.lineTo(0, i - dashWidth);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}