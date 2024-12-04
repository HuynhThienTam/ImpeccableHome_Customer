import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
class SmallProcessWidget extends StatelessWidget {
  final int currentProcess;
  final int numberOfProcesses;

  const SmallProcessWidget({
    Key? key,
    required this.currentProcess,
    required this.numberOfProcesses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row for dots and lines
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            numberOfProcesses * 2 - 1, // Adjust based on the number of processes
            (index) {
              if (index.isEven) {
                // Dot
                int dotIndex = index ~/ 2;
                return Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: dotIndex <= currentProcess ? crimsonRedColor  : silverGrayColor,
                    shape: BoxShape.circle,
                  ),
                );
              } else {
                // Line
                return Expanded(
                  child: Container(
                    height: 1.5,
                    color: index ~/ 2 < currentProcess ? crimsonRedColor  : silverGrayColor,
                  ),
                );
              }
            },
          ),
        ),
        
      ],
    );
  }
}
