import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
class BigButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const BigButton({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 2 / 5;
    // final buttonHeight = buttonWidth * 5 / 6;
    final iconWidth = screenWidth * 1 / 5;
    final iconHeight=screenWidth * 2 / 15;
    final spaceHeight=screenWidth * 1 / 18;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth,
        // height: buttonHeight,
        decoration: BoxDecoration(
          color: Colors.white, // Background color of the button
          borderRadius: BorderRadius.circular(12), // Slightly rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Subtle shadow
              blurRadius: 1,
              offset: Offset(2, 4,),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height:spaceHeight,
            ),
            Container(
              height: iconHeight,
              width: iconWidth,
              child: Image.network(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: silverGrayColor,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2, // Limit to 2 lines
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
