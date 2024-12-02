import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class GradientContainer extends StatelessWidget {
  final List<Color> gradientColors;
  final String imagePath;
  final String title;
  final VoidCallback onTap;
  const GradientContainer({
    Key? key,
    required this.gradientColors,
    required this.imagePath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 1 / 3;
    final buttonHeight = buttonWidth * 2 / 3;
    final iconWidth = screenWidth * 1 / 5;
    final iconHeight = screenWidth * 2 / 15;

    return Container(
      width: buttonWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft, // Starting point of the gradient
          end: Alignment.bottomRight, // Ending point of the gradient
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: buttonHeight / 4,
          ),
          Container(
            width: iconWidth,
            child: imagePath.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                        iconHeight / 9), // Adjust as needed
                    child: Image.asset(
                      imagePath,
                      fit:
                          BoxFit.cover, // Ensures the image fills the container
                    ),
                  )
                : const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.white,
                  ), // Fallback if imagePath is empty
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(
                  title.isNotEmpty
                      ? title
                      : 'No Title', // Fallback for empty title
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
            ),
          ),
          SizedBox(
            height: buttonHeight / 10,
          ),
        ],
      ),
    );
  }
}
