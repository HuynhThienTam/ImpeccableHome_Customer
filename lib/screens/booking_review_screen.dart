import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/components/custom_button.dart';
import 'package:impeccablehome_customer/components/edit_button.dart';
import 'package:impeccablehome_customer/components/smallProcessWidget.dart';
import 'package:impeccablehome_customer/screens/booking_success_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class BookingReviewScreen extends StatefulWidget {
  const BookingReviewScreen({super.key});

  @override
  State<BookingReviewScreen> createState() => _BookingReviewScreenState();
}

class _BookingReviewScreenState extends State<BookingReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      width: MediaQuery.of(context).size.width * (1 / 7),
                    ),
                    Text(
                      "Confirm your booking",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: (screenWidth / 12),
                  right: (screenWidth / 12),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: silverGrayColor, // Grey border
                    width: 1, // Border width
                  ),
                  borderRadius: BorderRadius.circular(12), // Roun
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Text(
                            "Booking detail",
                            style: TextStyle(
                                color: oceanBlueColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(child: Container()),
                          EditButton(onTap: () {}),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Working time",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Monday-22 Mar 2021",
                        style: TextStyle(
                            color: oceanBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "12:30",
                        style: TextStyle(
                            color: oceanBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                       SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Room 123, Brooklyn St, Kepler District",
                        style: TextStyle(
                            color: oceanBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                       SizedBox(
                        height: 20,
                      ),
                       Text(
                        "Note",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "No note added",
                        style: TextStyle(
                            color: oceanBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       Text(
                        "Domestic worker",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Janet Kim",
                        style: TextStyle(
                            color: oceanBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: (screenWidth / 12),
                  right: (screenWidth / 12),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: silverGrayColor, // Grey border
                    width: 1, // Border width
                  ),
                  borderRadius: BorderRadius.circular(12), // Roun
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Text(
                            "Payment detail",
                            style: TextStyle(
                                color: oceanBlueColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(child: Container()),
                          EditButton(onTap: () {}),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       Text(
                        "Payment method",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Credit card",
                        style: TextStyle(
                            color: oceanBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       Text(
                        "Cost",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "12.50/1 hour",
                        style: TextStyle(
                            color: oceanBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
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
          children: [
            SizedBox(
              width: 24,
            ),
            Container(
              width: screenWidth* (3/8),
              child: SmallProcessWidget(
                currentProcess: 2,
                numberOfProcesses: 3,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 48,
              width: 160,
              child: CustomButton(
                title: "Book now",
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingSuccessScreen(),
                          ),
                        );
                },
                backgroundColor: neonGreenColor,
                textColor: Colors.black,
              ),
            ),
            SizedBox(
              width: 24,
            ),
          ],
        ),
      ),
    );
  }
}
