import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/model/service_model.dart';
import 'package:impeccablehome_customer/utils/mock.dart';

class StepOneBookingProcessScreen extends StatefulWidget {
  final ServiceModel service;
  const StepOneBookingProcessScreen({super.key, required this.service});

  @override
  State<StepOneBookingProcessScreen> createState() =>
      _StepOneBookingProcessScreenState();
}

class _StepOneBookingProcessScreenState
    extends State<StepOneBookingProcessScreen> {
  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ),
    );
  }
}
