import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final String title;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    this.backgroundColor,
    required this.title,
    required this.onTap,
    this.textColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.0, ),
        decoration: BoxDecoration(
          color: backgroundColor??oceanBlueColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor?? Colors.white, // Button text color
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
