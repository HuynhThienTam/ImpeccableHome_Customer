import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/components/custom_button.dart';
import 'package:impeccablehome_customer/components/process_widget.dart';
import 'package:impeccablehome_customer/model/booking_model.dart';
import 'package:impeccablehome_customer/model/helper_model.dart';
import 'package:impeccablehome_customer/resources/booking_method.dart';
import 'package:impeccablehome_customer/resources/helper_service.dart';
import 'package:impeccablehome_customer/screens/add_review_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:provider/provider.dart';

class BookingDetailsScreen extends StatefulWidget {
  final BookingModel booking;
  const BookingDetailsScreen({super.key, required this.booking});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  late int statusNumber;
  HelperModel? helperModel;
  bool isLoading = true; // State to track
  final HelperService helperService = HelperService();
  void initState() {
    super.initState();
    // Initialize statusNumber with the booking status when the widget is created
    _fetchHelper();
    statusNumber = int.parse(widget.booking.status);
  }

  Future<void> _fetchHelper() async {
    try {
      final fetchedHelper =
          await helperService.fetchHelperDetails(widget.booking.helperUid);

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
    final bookingMethods = Provider.of<BookingMethods>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    int statusNumber = int.parse(widget.booking.status);
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
                      width: MediaQuery.of(context).size.width * (1 / 12),
                    ),
                    Text(
                      "Booking no \n#${widget.booking.bookingNumber}",
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * (1 / 15),
                ),
                child: ProcessWidget(
                  processes: processesList,
                  doneProcesses: doneProcessesList,
                  currentProcesses: currentProcessesList,
                  currentProcess: statusNumber,
                ),
              ),
              if (statusNumber < 3 && statusNumber >= 0)
                Padding(
                  padding: EdgeInsets.only(
                    top: 25,
                    left: screenWidth / 10,
                    right: screenWidth / 10,
                  ),
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    child: CustomButton(
                      title: "Chat",
                      onTap: () {},
                      textColor: Colors.black,
                      backgroundColor: neonGreenColor,
                      iconImage: 'assets/icons/chat_icon.png',
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
                        width: double.infinity,
                        height: 25,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Booking detail",
                            style: TextStyle(
                                color: oceanBlueColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
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
                        "${widget.booking.workingDay.toLocal().toString().split(' ')[0]}",
                        style: TextStyle(
                            color: oceanBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${widget.booking.startTime.toLocal().hour}:${widget.booking.startTime.toLocal().minute.toString().padLeft(2, '0')} - ${widget.booking.finishedTime.toLocal().hour}:${widget.booking.finishedTime.toLocal().minute.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          color: oceanBlueColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
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
                        widget.booking.location,
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
                        widget.booking.note,
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
                      isLoading
                          ? Container()
                          : Text(
                              "${helperModel!.firstName} ${helperModel!.lastName}",
                              style: TextStyle(
                                  color: oceanBlueColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
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
                        widget.booking.paymentMethod,
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
              (statusNumber == 3)
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: screenWidth / 8),
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            child: CustomButton(
                              title: "Book again",
                              onTap: () {},
                              textColor: Colors.black,
                              backgroundColor: neonGreenColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 48,
                                  width: 130,
                                  child: CustomButton(
                                    title: "Review",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddReviewScreen(userId: widget.booking.customerUid,helperId: widget.booking.helperUid,),
                                        ),
                                      );
                                    },
                                    textColor: Colors.black,
                                    backgroundColor: orangeColor,
                                  ),
                                ),
                                Container(
                                  height: 48,
                                  width: 130,
                                  child: CustomButton(
                                    title: "Report",
                                    onTap: () {},
                                    textColor: Colors.white,
                                    backgroundColor: crimsonRedColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  : (statusNumber == -1 || statusNumber == -2)
                      ? Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth / 8),
                              child: Container(
                                height: 48,
                                width: double.infinity,
                                child: CustomButton(
                                  title: "Report",
                                  onTap: () {},
                                  textColor: Colors.white,
                                  backgroundColor: crimsonRedColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 48,
                                  width: 130,
                                  child: CustomButton(
                                    title: "Cancel",
                                    onTap: () async {
                                      int nextStatus =
                                          -1; // New status for "Cancel"
                                      await bookingMethods.updateBookingStatus(
                                        widget.booking.bookingNumber,
                                        nextStatus.toString(),
                                      );

                                      // Update the local BookingModel instance
                                      setState(() {
                                        statusNumber = nextStatus;
                                        widget.booking.status =
                                            nextStatus.toString();
                                      });
                                    },
                                    textColor: Colors.white,
                                    backgroundColor: silverGrayColor,
                                  ),
                                ),
                                Container(
                                  height: 48,
                                  width: 130,
                                  child: CustomButton(
                                    title: "Report",
                                    onTap: () {},
                                    textColor: Colors.white,
                                    backgroundColor: crimsonRedColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
              const SizedBox(height: 25),
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

final List<String> processesList = [
  'Confirm',
  'Arrive',
  'Finish',
];
final List<String> doneProcessesList = [
  'Confirmed',
  'Arrived',
  'Finished',
];
final List<String> currentProcessesList = [
  'Wait for confirm',
  'Arriving',
  'Doing job',
];
