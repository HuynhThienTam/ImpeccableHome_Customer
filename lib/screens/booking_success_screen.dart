import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/components/custom_button.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:impeccablehome_customer/layout/screen_layout.dart';

class BookingSuccessScreen extends StatefulWidget {
  const BookingSuccessScreen({super.key});

  @override
  State<BookingSuccessScreen> createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 7 / 10;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenWidth / 4,
                width: double.infinity,
              ),
              Container(
                width: imageWidth,
                child: Image.asset("assets/images/success_image.png"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Success!",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Now you can track your booking or \ngo back to home screen",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 48,
                    width: 160,
                    child: CustomButton(
                      title: "Home",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScreenLayout(), // 1 is the index for Bookings
                          ),
                        );
                      },
                      textColor: Colors.black,
                      backgroundColor: orangeColor,
                    ),
                  ),
                  Container(
                    height: 48,
                    width: 160,
                    child: CustomButton(
                      title: "Track",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenLayout(
                                initialIndex: 1), // 1 is the index for Bookings
                          ),
                        );
                      },
                      textColor: Colors.black,
                      backgroundColor: neonGreenColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
