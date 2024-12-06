import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/components/custom_button.dart';
import 'package:impeccablehome_customer/components/custom_text_input.dart';
import 'package:impeccablehome_customer/components/smallProcessWidget.dart';
import 'package:impeccablehome_customer/screens/booking_review_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class StepTwoBookingProcessScreen extends StatefulWidget {
  const StepTwoBookingProcessScreen({super.key});

  @override
  State<StepTwoBookingProcessScreen> createState() =>
      _StepTwoBookingProcessScreenState();
}

class _StepTwoBookingProcessScreenState
    extends State<StepTwoBookingProcessScreen> {
  final List<String> paymentMethods = ["Credit card", "Paypal", "Cash"];
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  String? selectedMethod; // Holds the currently selected payment method
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
                      width: MediaQuery.of(context).size.width * (1 / 5),
                    ),
                    Text(
                      "Pay for booking",
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
                  horizontal: MediaQuery.of(context).size.width * (1 / 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Choose a payment method",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * (1 / 12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String method in paymentMethods)
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 0.0), // Reduce padding around ListTile
                        horizontalTitleGap:
                            0, // Reduce space between Radio and text
                        title: Text(
                          method,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        leading: Radio<String>(
                          value: method,
                          groupValue: selectedMethod,
                          activeColor:
                              oceanBlueColor, // Selected color for the radio button
                          onChanged: (String? value) {
                            setState(() {
                              selectedMethod = value;
                            });
                          },
                        ),
                      ),
                    // const SizedBox(height: 20),
                    // Center(
                    //   child: ElevatedButton(
                    //     onPressed: selectedMethod != null
                    //         ? () {
                    //             // Handle the selected payment method
                    //             ScaffoldMessenger.of(context).showSnackBar(
                    //               SnackBar(
                    //                   content:
                    //                       Text('Selected: $selectedMethod')),
                    //             );
                    //           }
                    //         : null, // Disable button if no method is selected
                    //     style: ElevatedButton.styleFrom(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 32, vertical: 12),
                    //     ),
                    //     child: const Text('Confirm Payment Method'),
                    //   ),
                    // ),

                    if (selectedMethod == "Credit card")
                      Container(
                        margin:  const EdgeInsets.only(top:16),
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
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              CustomTextInput(
                                  hintText: "John Smith",
                                  title: "Card holder's name",
                                  controller: cardHolderNameController),
                              SizedBox(
                                height: 25,
                              ),
                              CustomTextInput(
                                  hintText: "Enter card number",
                                  title: "Card number",
                                  controller: cardNumberController),
                              SizedBox(
                                height: 25,
                              ),
                              CustomTextInput(
                                  hintText: "Enter CVV",
                                  title: "CVV",
                                  controller: cvvController),
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
                currentProcess: 1,
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
                            builder: (context) => BookingReviewScreen(),
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
