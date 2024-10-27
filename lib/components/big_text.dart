import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color color;

  const BigText({
    Key? key,
    required this.text,
    this.color = Colors.black, // Default color set to black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}
