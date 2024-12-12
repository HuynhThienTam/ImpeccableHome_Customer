import 'package:flutter/material.dart';

class RatingsWidget extends StatefulWidget {
  final ValueNotifier<int> controller; // To manage ratings

  const RatingsWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _RatingsWidgetState createState() => _RatingsWidgetState();
}

class _RatingsWidgetState extends State<RatingsWidget> {
  @override
  Widget build(BuildContext context) {
    const totalStars = 5;
    const starSpacing = 7.0; // Space between stars

    return ValueListenableBuilder<int>(
      valueListenable: widget.controller,
      builder: (context, ratings, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(totalStars, (index) {
            return GestureDetector(
              onTap: () {
                widget.controller.value = index + 1; // Update ratings
              },
              child: Row(
                children: [
                  Image.asset(
                    index < ratings
                        ? 'assets/icons/yellow_star.png'
                        : 'assets/icons/gray_star.png',
                    width: 26.0,
                    height: 26.0,
                  ),
                  if (index < totalStars - 1) SizedBox(width: starSpacing),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
