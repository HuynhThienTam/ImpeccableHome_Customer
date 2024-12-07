import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impeccablehome_customer/components/booking_widget.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/components/process_widget.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:impeccablehome_customer/utils/mock.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      width: MediaQuery.of(context).size.width * (7 / 25),
                    ),
                    Text(
                      "Bookings",
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
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * (1 / 13),
                ),
                child: Text(
                  "Processing",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SingleChildScrollView(
                child: Column(
                  children: List.generate(bookings.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: BookingWidget(booking: bookings[index]),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // TabBar Section
              DefaultTabController(
                length: 2, // Number of tabs
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: silverGrayColor,
                      indicatorColor: skyBlueColor,
                      tabs: const [
                        Tab(
                          child: Text("Completed", style: TextStyle(fontWeight: FontWeight.w500),),
                        ), // First tab
                        Tab(
                          child: Text("Cancel", style: TextStyle(fontWeight: FontWeight.w500),),
                        ), // Second tab
                      ],
                    ),
                    // TabBarView to show different screens
                    SizedBox(
                      height:
                          200, // Limit the height of TabBarView (adjust as needed)
                      child: const TabBarView(
                        children: [
                          Center(child: Text('Screen 1 Content')), // Screen 1
                          Center(child: Text('Screen 2 Content')), // Screen 2
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
