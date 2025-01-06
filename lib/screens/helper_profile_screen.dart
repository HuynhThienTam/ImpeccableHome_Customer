import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/components/custom_button.dart';
import 'package:impeccablehome_customer/components/helper_info_widget.dart';
import 'package:impeccablehome_customer/components/review_widget.dart';
import 'package:impeccablehome_customer/components/stars_widget.dart';
import 'package:impeccablehome_customer/components/weekly_working_time_widget.dart';
import 'package:impeccablehome_customer/model/helper_model.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:impeccablehome_customer/utils/mock.dart';

class HelperProfileScreen extends StatefulWidget {
  final HelperModel helper;
  const HelperProfileScreen({super.key, required this.helper});

  @override
  State<HelperProfileScreen> createState() => _HelperProfileScreenState();
}

class _HelperProfileScreenState extends State<HelperProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenWidth * (1 / 6),
                  left: screenWidth * (1 / 13),
                ),
                child: Row(
                  children: [
                    CustomBackButton(color: Colors.blue),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * (2 / 7),
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: HelperInfoWidget(
                  avatarPath: widget.helper.profilePic,
                  workerName:
                      '${widget.helper.firstName} ${widget.helper.lastName}',
                  gender: widget.helper.gender,
                  dateOfBirth: widget.helper.dateOfBirth,
                  location: widget.helper.province,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth / 12, right: screenWidth / 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Specialized in",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: screenWidth * (1 / 7),
                          child: Image.asset(
                            "assets/images/colorful_cleanup_image.png",
                            fit: BoxFit
                                .cover, // Ensures the image fills the container
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.helper.serviceType,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Working time",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth / 8,
                          ),
                          child: WeeklyWorkingTimeWidget(
                              workingTime: helper1WorkingTimes),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 12),
                child: Row(
                  children: [
                    Text(
                      "Average ${widget.helper.ratings}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Image.asset(height: 13, "assets/icons/yellow_star.png"),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: mockReviews
                    .map((review) => Padding(
                          padding: EdgeInsets.only(
                            top: screenWidth / 36,
                            left: screenWidth / 13,
                            right: screenWidth / 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReviewWidget(review: review),
                              SizedBox(
                                height: screenWidth / 36,
                              ),
                              Divider(
                                // Divider between each widget
                                color: orangeColor, // Customize divider color
                                thickness: 1.0, // Customize divider thickness
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: screenWidth / 5,
        decoration: BoxDecoration(
          color: Colors.white, // You can change this to any color you need
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(30), // Top-left border radius
          //   topRight: Radius.circular(30), // Top-right border radius
          // ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(66, 218, 217, 217)
                  .withOpacity(0.4), // Light shadow color
              offset: Offset(
                  0, -2), // Shadow direction (negative Y-axis to go upwards)
              blurRadius: 4, // Spread of the shadow
              spreadRadius: 2, // How far the shadow spreads
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 48,
              width: screenWidth*(3/4),
              child: CustomButton(
                title: "Choose her now",
                onTap: () {},
                backgroundColor: oceanBlueColor,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
