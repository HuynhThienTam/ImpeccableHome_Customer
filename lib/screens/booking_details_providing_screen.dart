import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/components/custom_button.dart';
import 'package:impeccablehome_customer/components/custom_text_input.dart';
import 'package:impeccablehome_customer/components/helper_card_widget.dart';
import 'package:impeccablehome_customer/components/note_input.dart';
import 'package:impeccablehome_customer/components/smallProcessWidget.dart';
import 'package:impeccablehome_customer/model/helper_model.dart';
import 'package:impeccablehome_customer/model/service_model.dart';
import 'package:impeccablehome_customer/screens/booking_payment_method_providing_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:impeccablehome_customer/utils/mock.dart';

class BookingDetailsProvidingScreen extends StatefulWidget {
  final ServiceModel service;
  const BookingDetailsProvidingScreen ({super.key, required this.service});

  @override
  State<BookingDetailsProvidingScreen > createState() =>
      _BookingDetailsProvidingScreenState();
}

class _BookingDetailsProvidingScreenState
    extends State<BookingDetailsProvidingScreen > {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController finishedTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final ValueNotifier<HelperModel?> selectedHelperController =
      ValueNotifier<HelperModel?>(null);
  String dbFormat = "";
  @override
  void dispose() {
    dateController.dispose();
    startTimeController.dispose();
    finishedTimeController.dispose();
    locationController.dispose();
    noteController.dispose();
    selectedHelperController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // No earlier than today
      lastDate: DateTime(2100), // Max limit
    );

    if (pickedDate != null) {
      setState(() {
        dbFormat =
            "${pickedDate.toLocal()}".split(' ')[0]; // Format to YYYY-MM-DD
        String displayFormat =
            "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
        dateController.text = displayFormat;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, String timeType) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true, // Optional: 24-hour format
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      // Round minutes to the nearest divisible by 10
      int roundedMinutes = (pickedTime.minute / 10).round() * 10;
      if (roundedMinutes == 60) {
        // Handle overflow, e.g., 12:50 -> 1:00
        roundedMinutes = 0;
      }

      if (timeType == "start") {
        setState(() {
          startTimeController.text =
              "${pickedTime.hour.toString().padLeft(2, '0')}:${roundedMinutes.toString().padLeft(2, '0')}";
        });
      } else {
        setState(() {
          finishedTimeController.text =
              "${pickedTime.hour.toString().padLeft(2, '0')}:${roundedMinutes.toString().padLeft(2, '0')}";
        });
      }
    }
  }

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
              Container(
                height: MediaQuery.of(context).size.width * (2 / 3),
                child: Stack(
                  children: [
                    Image.asset("assets/images/home_header.png"),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width * (1 / 13),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * (1 / 6),
                            ),
                            child: Row(
                              children: [
                                CustomBackButton(color: Colors.white),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      (1 / 5),
                                ),
                                Text(
                                  "Book a service",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.width * (1 / 10),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      (1 / 35),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      (2 / 5),
                                  child: Text(
                                    widget.service.serviceName,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      (1 / 6),
                                ),
                                Text(
                                  '${widget.service.serviceBasePrice}/hour',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * (1 / 3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * (1 / 16),
                  ), // Adjust as needed
                  child: Image.asset(
                    widget.service.colorfulImagePath,
                    fit: BoxFit.cover, // Ensures the image fills the container
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * (1 / 10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: CustomTextInput(
                          hintText: "Select a date",
                          prefixImage: Image.asset(
                            "assets/icons/small_calendar_icon.png",
                            fit: BoxFit.contain,
                          ),
                          title: "Working day",
                          controller: dateController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () => _selectTime(context, "start"),
                      child: AbsorbPointer(
                        child: CustomTextInput(
                          hintText: "Select start time",
                          prefixImage: Image.asset(
                            "assets/icons/small_clock_icon.png",
                            fit: BoxFit.contain,
                          ),
                          title: "Start time",
                          controller: startTimeController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () => _selectTime(context, "finished"),
                      child: AbsorbPointer(
                        child: CustomTextInput(
                          hintText: "Select finished time",
                          prefixImage: Image.asset(
                            "assets/icons/small_clock_icon.png",
                            fit: BoxFit.contain,
                          ),
                          title: "Finished time",
                          controller: finishedTimeController,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CustomTextInput(
                      hintText: "Enter home address",
                      prefixImage: Image.asset(
                        "assets/icons/small_location_icon.png",
                        fit: BoxFit.contain,
                      ),
                      title: "Location",
                      controller: locationController,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    NoteInput(
                        controller: noteController,
                        title: "Note",
                        hintText:
                            "Anything for us to notice?\nEg: Bathroom needs harder clean"),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * (1 / 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Domestic worker",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: screenWidth * (5 / 8),
                child: ValueListenableBuilder<HelperModel?>(
                  valueListenable: selectedHelperController,
                  builder: (context, selectedHelper, child) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: helpers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: (index == 0)
                              ? const EdgeInsets.only(left: 26, right: 12.0)
                              : (index == helpers.length - 1)
                                  ? const EdgeInsets.only(left: 12, right: 26.0)
                                  : const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                          child: HelperCardWidget(
                            helper: helpers[index],
                            gradientColors: lightBlueGradient,
                            controller: selectedHelperController,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // const SizedBox(height: 16),
              // // Selected Helper Info
              // ValueListenableBuilder<HelperModel?>(
              //   valueListenable: selectedHelperController,
              //   builder: (context, selectedHelper, child) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 16),
              //       child: Column(
              //         children: [
              //           Text(
              //             selectedHelper != null
              //                 ? 'Selected: ${selectedHelper.firstName} ${selectedHelper.lastName}'
              //                 : 'No helper selected',
              //             style: const TextStyle(fontSize: 18),
              //           ),
              //           const SizedBox(height: 16),
              //           ElevatedButton(
              //             onPressed: selectedHelper != null
              //                 ? () {
              //                     // Perform action with the selected helper
              //                     print(
              //                         'Proceeding with: ${selectedHelper.firstName}');
              //                   }
              //                 : null,
              //             child: const Text('Proceed'),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
              SizedBox(
                height: 35,
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
                currentProcess: 0,
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
                title: "Next",
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPaymentMethodProvidingScreen(),
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
