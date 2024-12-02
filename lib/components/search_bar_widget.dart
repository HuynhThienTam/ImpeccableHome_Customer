import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
class SearchBarWidget extends StatelessWidget {
  // final TextEditingController controller;
  // final VoidCallback? onSearch;

  const SearchBarWidget({
    Key? key,
    // required this.controller,
    // this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: controller,
      // onSubmitted: (_) => onSearch?.call(),
      decoration: InputDecoration(
        filled: true, // Enables background color
        fillColor: Colors.white, // Sets the background color
        hintText: "Find it here",
        hintStyle: const TextStyle(color: skyBlueColor, fontSize: 18), // Hint text color
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14),
          child: Image.asset(
            "assets/icons/search_icon.png", // Replace with your image path
            width: 12,
            height: 12,
            fit: BoxFit.contain,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0), // Slightly rounded corners
          borderSide: BorderSide.none, // No border when idle
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: const BorderSide(color: silverGrayColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: const BorderSide(color: orangeColor, width: 1.5),
        ),
      ),
    );
  }
}
