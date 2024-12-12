import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impeccablehome_customer/model/helper_model.dart';
import 'package:impeccablehome_customer/screens/helper_profile_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:flutter/material.dart';

class HelperCardWidget extends StatelessWidget {
  final HelperModel helper;
  final List<Color> gradientColors;
  final ValueNotifier<HelperModel?> controller;

  const HelperCardWidget({
    Key? key,
    required this.helper,
    required this.gradientColors,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<HelperModel?>(
      valueListenable: controller,
      builder: (context, selectedHelper, child) {
        final bool isSelected = selectedHelper == helper;
        return Container(
          width: screenWidth / 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors),
            // borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Checkbox
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.value = controller.value == helper
                          ? null
                          : helper; // Toggle selection
                    },
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: isSelected ? skyBlueColor : lightGrayColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Avatar
              CircleAvatar(
                backgroundImage: NetworkImage(helper.profilePic),
                radius: 40,
              ),
              const SizedBox(height: 8),
              // Name
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      '${helper.firstName} ${helper.lastName}',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Ratings
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${helper.ratings.toStringAsFixed(1)}'),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: orangeColor, size: 20),
                ],
              ),
              const SizedBox(height: 14),
              // View Button
              Container(
                height: 32, // Set the height
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelperProfileScreen(helper: helper,),
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: skyBlueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        );
      },
    );
  }
}
