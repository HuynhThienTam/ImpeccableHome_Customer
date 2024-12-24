import 'package:flutter/cupertino.dart';

class EditButton extends StatefulWidget {
  final VoidCallback onTap;
  const EditButton({super.key, required this.onTap});

  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  @override
  
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconWidth = screenWidth * 1 / 23;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: iconWidth,
        width: iconWidth,
        child:  Image.asset("assets/icons/edit_icon.png"),
      ),
    );
  }
}
