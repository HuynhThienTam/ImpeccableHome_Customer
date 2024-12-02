import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/components/gradient_container.dart';
import 'package:impeccablehome_customer/model/service_model.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class CarouselWidget extends StatefulWidget {
  final List<ServiceModel> services;

  const CarouselWidget({Key? key, required this.services}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Color> _getGradientForIndex(int index) {
    if (index % 3 == 0) {
      return redGradient; // Items 1, 4, 7,...
    } else if (index % 3 == 1) {
      return orangeGradient; // Items 2, 5, 8,...
    } else {
      return darkBlueGradient; // Items 3, 6, 9,...
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (widget.services.length / 2).ceil();
    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: totalPages,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            }, // Each page contains 2 items
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * 2;
              final endIndex = (startIndex + 2)
                  .clamp(0, widget.services.length); // Clamp endIndex

              final pageItems = widget.services.sublist(startIndex, endIndex);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: pageItems.asMap().entries.map((entry) {
                    final itemIndex = startIndex + entry.key;
                    final service = entry.value;

                    return Flexible(
                      child: GradientContainer(
                        gradientColors: _getGradientForIndex(itemIndex),
                        imagePath: service.colorfulImagePath.isNotEmpty
                            ? service.colorfulImagePath
                            : 'assets/images/default_image.png', // Fallback
                        title: service.serviceName,
                        onTap: () {
                          // Handle button tap
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
        // Back Button
        if (_currentPage > 0)
          Positioned(
            left: 0,
            top: 85,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              iconSize: 30,
              padding: const EdgeInsets.all(0),
              constraints: const BoxConstraints(),
              color: Colors.black,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  CircleBorder(),
                ),
                backgroundColor: MaterialStateProperty.all(lightGrayColor),
              ), // BG shape icon alignment fixed)
            ),
          ),
        // Next Button
        if (_currentPage < totalPages - 1)
          Positioned(
            right: 0,
            top: 85,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              iconSize: 30,
               padding: const EdgeInsets.all(0),
              constraints: const BoxConstraints(),
              color: Colors.black,
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  CircleBorder(),
                ),
                backgroundColor: MaterialStateProperty.all(lightGrayColor),
              ), // BG shape icon alignment fix
            ),
          ),
      ],
    );
  }
}
