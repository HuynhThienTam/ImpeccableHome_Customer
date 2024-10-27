import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool? isLink;

  const ClickableText({
    Key? key,
    required this.text,
    required this.onTap,
    this.isLink = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
            color: oceanBlueColor,
            decoration: isLink! ? TextDecoration.underline:TextDecoration.none,
            decorationColor: oceanBlueColor,
            fontSize: 14,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
