import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/components/custom_button.dart';
import 'package:impeccablehome_customer/components/edit_button.dart';
import 'package:impeccablehome_customer/components/smallProcessWidget.dart';
import 'package:impeccablehome_customer/model/booking_model.dart';
import 'package:impeccablehome_customer/model/helper_model.dart';
import 'package:impeccablehome_customer/model/service_model.dart';
import 'package:impeccablehome_customer/resources/booking_method.dart';
import 'package:impeccablehome_customer/resources/helper_service.dart';
import 'package:impeccablehome_customer/screens/booking_details_providing_screen.dart';
import 'package:impeccablehome_customer/screens/booking_payment_method_providing_screen.dart';
import 'package:impeccablehome_customer/screens/booking_success_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:impeccablehome_customer/utils/utils.dart';
import 'package:provider/provider.dart';

class BookingReviewScreen extends StatefulWidget {
  final BookingModel bookingModel;
  final ServiceModel serviceModel;
  const BookingReviewScreen(
      {super.key, required this.bookingModel, required this.serviceModel});

  @override
  State<BookingReviewScreen> createState() => _BookingReviewScreenState();
}

class _BookingReviewScreenState extends State<BookingReviewScreen> {
  bool isLoading = true; // State to track loading
  HelperModel? helperModel;
  final HelperService helperService = HelperService();
  String? workingDay;
  String? startTime;
  String? finishedTime;
  @override
  void initState() {
    super.initState();
    _fetchHelper();
    setState(() {
      workingDay = formatWorkingTime(widget.bookingModel.workingDay);
      DateTime tempStartTime = widget.bookingModel.startTime;
      DateTime tempFinishedTime = widget.bookingModel.finishedTime;
      startTime =
          "${tempStartTime.hour.toString().padLeft(2, '0')}:${tempStartTime.minute.toString().padLeft(2, '0')}";
      finishedTime =
          "${tempFinishedTime.hour.toString().padLeft(2, '0')}:${tempFinishedTime.minute.toString().padLeft(2, '0')}";
    });
  }

  Future<void> _fetchHelper() async {
    try {
      final fetchedHelper =
          await helperService.fetchHelperDetails(widget.bookingModel.helperUid);

      if (fetchedHelper != null) {
        setState(() {
          helperModel = fetchedHelper;
        });
      }
    } catch (e) {
      // Handle errors (optional)
      print('Error fetching helper: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading once data is fetched
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Show loading indicator
            )
          : SafeArea(
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
                                EditButton(onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingDetailsProvidingScreen(
                                                service: widget.serviceModel,
                                                isFromHome: false),
                                      ));
                                }),
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
                              workingDay!,
                              style: TextStyle(
                                  color: oceanBlueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "$startTime - $finishedTime",
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
                              widget.bookingModel.location,
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
                              widget.bookingModel.note,
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
                              "${helperModel!.firstName} ${helperModel!.lastName}",
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
                                EditButton(onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingPaymentMethodProvidingScreen(
                                                isFromHome: false,
                                                serviceModel:
                                                    widget.serviceModel),
                                      ));
                                }),
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
                              widget.bookingModel.paymentMethod,
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
                              "${widget.serviceModel.serviceBasePrice}/1 hour",
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
              width: screenWidth * (3 / 8),
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
                  upLoadBooking();
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

  Future<void> upLoadBooking() async {
    final bookingMethods = Provider.of<BookingMethods>(context, listen: false);
    bookingMethods.uploadBookingToFirebase(context, widget.serviceModel);
  }
}
