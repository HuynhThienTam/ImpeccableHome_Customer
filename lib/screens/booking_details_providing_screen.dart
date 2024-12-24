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
import 'package:impeccablehome_customer/resources/booking_method.dart';
import 'package:impeccablehome_customer/resources/helper_service.dart';
import 'package:impeccablehome_customer/resources/user_services.dart';
import 'package:impeccablehome_customer/screens/booking_payment_method_providing_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:impeccablehome_customer/utils/mock.dart';
import 'package:impeccablehome_customer/utils/utils.dart';
import 'package:provider/provider.dart';

class BookingDetailsProvidingScreen extends StatefulWidget {
  final bool isFromHome;
  final ServiceModel service;
  const BookingDetailsProvidingScreen(
      {super.key, required this.service, required this.isFromHome});

  @override
  State<BookingDetailsProvidingScreen> createState() =>
      _BookingDetailsProvidingScreenState();
}

class _BookingDetailsProvidingScreenState
    extends State<BookingDetailsProvidingScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController finishedTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  DateTime? parsedWorkingDay, parsedStartTime, parsedFinishedTime;
  final ValueNotifier<HelperModel?> selectedHelperController =
      ValueNotifier<HelperModel?>(null);

  String dbFormat = "";
  bool isHelperListLoading = true;
  final HelperService helperService = HelperService();
  List<HelperModel> helperList = [];
  @override
  void dispose() {
    dateController.dispose();
    startTimeController.dispose();
    finishedTimeController.dispose();
    locationController.dispose();
    noteController.dispose();
    selectedHelperController.dispose();
    provinceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Access the provider to initialize bookingModel
    final bookingMethods = Provider.of<BookingMethods>(context, listen: false);

    if (!widget.isFromHome) {
      final tempBookingModel = bookingMethods.bookingModel;
      fetchHelperList(tempBookingModel.province, widget.service.serviceName);
      setState(() {
        // Initialize controllers with values from bookingModel
        parsedWorkingDay = tempBookingModel.workingDay;
        parsedStartTime = tempBookingModel.startTime;
        parsedFinishedTime = tempBookingModel.finishedTime;

        dateController.text = formatDateToDisplay(
            tempBookingModel.workingDay); // Format as needed
        startTimeController.text =
            formatTimeToDisplay(tempBookingModel.startTime);
        finishedTimeController.text =
            formatTimeToDisplay(tempBookingModel.finishedTime);
        locationController.text = tempBookingModel.location;
        provinceController.text = tempBookingModel.province;
        noteController.text = tempBookingModel.note;

        // // Update the selected helper
        // selectedHelperController.value = HelperModel(
        //   helperUid: tempBookingModel.helperUid,
        //   helperName: tempBookingModel.helperName,
        // );
      });
    }
  }

  Future<void> fetchHelperList(String province, String serviceType) async {
    try {
      final fetchedHelperList =
          await helperService.fetchHelpersByProvinceAndServiceType(
              province, serviceType); // Fetch services
      setState(() {
        helperList = fetchedHelperList; // Update the list
        isHelperListLoading = false; // Set loading to false
      });
    } catch (e) {
      print('Error fetching services: $e');
      setState(() {
        isHelperListLoading = false; // Ensure loading is stopped on error
      });
    }
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
        // dbFormat =
        //     "${pickedDate.toLocal()}".split(' ')[0]; // Format to YYYY-MM-DD
        // String displayFormat =
        //     "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
        // dateController.text = displayFormat;
        dateController.text = formatDateToDisplay(pickedDate);
        parsedWorkingDay=pickedDate;
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
          // startTimeController.text =
          //     "${pickedTime.hour.toString().padLeft(2, '0')}:${roundedMinutes.toString().padLeft(2, '0')}";
          startTimeController.text =
              formatTimeToDisplay(convertTimeOfDayToDateTime(pickedTime));
              parsedStartTime=convertTimeOfDayToDateTime(pickedTime);
        });
      } else {
        setState(() {
          // finishedTimeController.text =
          //     "${pickedTime.hour.toString().padLeft(2, '0')}:${roundedMinutes.toString().padLeft(2, '0')}";
          finishedTimeController.text =
              formatTimeToDisplay(convertTimeOfDayToDateTime(pickedTime));
              parsedFinishedTime=convertTimeOfDayToDateTime(pickedTime);
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
                  child: Image.network(
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
                    GestureDetector(
                      onTap: () {
                        _showProvinceDialog(context);
                        // Handle button press
                      },
                      child: AbsorbPointer(
                        child: CustomTextInput(
                          prefixImage: Image.asset(
                            "assets/icons/small_location_icon.png",
                            fit: BoxFit.contain,
                          ),
                          hintText: "Select a province",
                          title: "Province",
                          controller: provinceController,
                        ),
                      ),
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
              isHelperListLoading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Select province to load helpers ...,",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CircularProgressIndicator(),
                      ],
                    )
                  : helperList.isEmpty
                      ? Center(
                          child: Text(
                            "No helpers found, we're sorry!",
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      : SizedBox(
                          height: screenWidth * (5 / 8),
                          child: ValueListenableBuilder<HelperModel?>(
                            valueListenable: selectedHelperController,
                            builder: (context, selectedHelper, child) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: helperList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: (index == 0)
                                        ? const EdgeInsets.only(
                                            left: 26, right: 12.0)
                                        : (index == helperList.length - 1)
                                            ? const EdgeInsets.only(
                                                left: 12, right: 26.0)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                    child: HelperCardWidget(
                                      helper: helperList[index],
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
              width: screenWidth * (3 / 8),
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
                  addDetails();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         BookingPaymentMethodProvidingScreen(),
                  //   ),
                  // );
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

  void _showProvinceDialog(BuildContext context) {
    String? selectedProvince = provinceController
        .text; // Ensure the initial value matches an existing province

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Province"),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: silverGrayColor, // Border color
                  width: 1.0, // Border width
                ),
                borderRadius:
                    BorderRadius.circular(8.0), // Optional: Rounded corners
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0), // Add padding inside the border
              child: DropdownButton<String>(
                value: vietnamProvinces.contains(selectedProvince)
                    ? selectedProvince
                    : null,
                items: vietnamProvinces.map((province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedProvince = newValue;
                  });
                },
                underline: SizedBox(), // Removes the default underline
                isExpanded: true, // Makes the dropdown take the full width
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog without changes
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (selectedProvince != null) {
                setState(() {
                  provinceController.text = selectedProvince!;
                  isHelperListLoading = true;
                  selectedHelperController.value = null;
                });
                //_updateProvince(selectedProvince!);
                fetchHelperList(selectedProvince!, widget.service.serviceName);
              }
              Navigator.of(context).pop(); // Save selection and close dialog
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }
  // Future<void> addDetails() async {
  //    final bookingMethods =
  //       Provider.of<BookingMethods>(context, listen: false);
  //   String date = dateController.text.trim();
  //   String startTime = startTimeController.text.trim();
  //   String finishedTime = finishedTimeController.text.trim();
  //   String location = locationController.text.trim();
  //   String note = noteController.text.trim();
  //   String selectedHelperUid = selectedHelperController.value!.helperUid.trim();
  //   String province = provinceController.text.trim();
  //   if(date ==""){
  //     showSnackBar(context, "Select date!");
  //   }
  //   else if(startTime==""){
  //     showSnackBar(context, "Select startTime!");
  //   }
  //   else if(finishedTime==""){
  //     showSnackBar(context, "Select finishedTime!");
  //   }
  //   else if(location==""){
  //     showSnackBar(context, "Enter location!");
  //   }
  //   else if(province==""){
  //     showSnackBar(context, "Select province!");
  //   }
  //   else if(province==""){
  //     showSnackBar(context, "Select province!");
  //   }
  //   else if (selectedHelperUid=="") {
  //     showSnackBar(context, "Select helper!");
  //   } else {
  //     bookingMethods.addBookingDetails(context, selectedHelperUid, date, startTime, finishedTime, location, province, note)

  //   }

  // }

  Future<void> addDetails() async {
    final bookingMethods = Provider.of<BookingMethods>(context, listen: false);
    String date = dateController.text.trim();
    String startTime = startTimeController.text.trim();
    String finishedTime = finishedTimeController.text.trim();
    String location = locationController.text.trim();
    String note = noteController.text.trim();
    String province = provinceController.text.trim();
    HelperModel? selectedHelper = selectedHelperController.value;

    // Validation checks
    if (date.isEmpty) {
      showSnackBar(context, "Select date!");
    } else if (startTime.isEmpty) {
      showSnackBar(context, "Select start time!");
    } else if (finishedTime.isEmpty) {
      showSnackBar(context, "Select finished time!");
    } else if (location.isEmpty) {
      showSnackBar(context, "Enter location!");
    } else if (province.isEmpty) {
      showSnackBar(context, "Select province!");
    } else if (selectedHelper == null) {
      showSnackBar(context, "Select helper!");
    } else {
      try {
        // Parse date and times to DateTime objects
        // DateTime parsedWorkingDay =
        //     DateTime.parse(date); // Assumes date is in valid format
        // List<String> parts =
        //     date.split('-'); // Split the string into day, month, and year
        // int workingDayDay = int.parse(parts[0]);
        // int workingDayMonth = int.parse(parts[1]);
        // int workingDayYear = int.parse(parts[2]);
        // DateTime parsedWorkingDay =
        //     DateTime(workingDayYear, workingDayMonth, workingDayDay);
        // String startTime = startTimeController.text.trim();
        // List<String> startTimeParts =
        //     startTime.split(':'); // Split the string into hour and minute
        // int startTimeHour = int.parse(startTimeParts[0]);
        // int startTimeMinute = int.parse(startTimeParts[1]);

// Create a DateTime object using the current date and the parsed time
        // DateTime parsedStartTime = DateTime(
        //   DateTime.now().year,
        //   DateTime.now().month,
        //   DateTime.now().day,
        //   startTimeHour,
        //   startTimeMinute,
        // );

        // String finishedTime = finishedTimeController.text.trim();
        // List<String> finishedTimeParts =
        //     finishedTime.split(':'); // Split the string into hour and minute
        // int finishedTimeHour = int.parse(finishedTimeParts[0]);
        // int finishedTimeMinute = int.parse(finishedTimeParts[1]);

// Create a DateTime object using the current date and the parsed time
        // DateTime parsedFinishedTime = DateTime(
        //   DateTime.now().year,
        //   DateTime.now().month,
        //   DateTime.now().day,
        //   finishedTimeHour,
        //   finishedTimeMinute,
        // );

        // Call addBookingDetails from the provider
        bookingMethods.addBookingDetails(
          context,
          widget.service,
          selectedHelper.helperUid,
          parsedWorkingDay!,
          parsedStartTime!,
          parsedFinishedTime!,
          location,
          province,
          note,
          widget.isFromHome, //
        );
      } catch (e) {
        debugPrint('Error parsing dates or times: $e');
        showSnackBar(context, "Select date!");
      }
    }
  }
}
