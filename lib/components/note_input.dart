import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class NoteInput extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;

  const NoteInput({
    Key? key,
    required this.controller,
    required this.title,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 2),
        TextField(
          controller: controller,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: silverGrayColor, // silverGrayColor
              fontSize: 16,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: silverGrayColor), // silverGrayColor
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: skyBlueColor), // skyBlueColor
            ),
          ),
        ),
      ],
    );
  }
}
