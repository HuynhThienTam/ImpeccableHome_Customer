import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/components/big_button.dart';
import 'package:impeccablehome_customer/components/carousel_widget.dart';
import 'package:impeccablehome_customer/components/custom_drawer.dart';
import 'package:impeccablehome_customer/components/gradient_container.dart';
import 'package:impeccablehome_customer/components/search_bar_widget.dart';
import 'package:impeccablehome_customer/model/service_model.dart';
import 'package:impeccablehome_customer/model/user_model.dart';
import 'package:impeccablehome_customer/resources/authentication_method.dart';
import 'package:impeccablehome_customer/resources/booking_method.dart';
import 'package:impeccablehome_customer/resources/cloud_firestore_methods.dart';
import 'package:impeccablehome_customer/resources/user_services.dart';
import 'package:impeccablehome_customer/screens/booking_details_providing_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:impeccablehome_customer/utils/mock.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback openEndDrawer;
  final String userName;
  const HomeScreen({super.key, required this.openEndDrawer, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();
  List<ServiceModel> servicesList = []; // Declare the list of services
  final currentuser = FirebaseAuth.instance.currentUser;
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    fetchServiceData();
    setState(() {
        isLoading = false; // Stop loading once data is fetched
      });
  }

  Future<void> fetchServiceData() async {
    try {
      final fetchedServices =
          await cloudFirestoreClass.fetchServices(); // Fetch services
      setState(() {
        servicesList = fetchedServices; // Update the list
      });
    } catch (e) {
      print('Error fetching services: $e');
      setState(() {
        isLoading = false; // Ensure loading is stopped on error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child:isLoading?Center(child: CircularProgressIndicator(),): Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                              top: MediaQuery.of(context).size.width * (3 / 16),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hi ${widget.userName},",
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Need some help today?",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                                Expanded(child: Container()),
                                Builder(
                                  builder: (BuildContext context) {
                                    return GestureDetector(
                                      onTap: widget.openEndDrawer,
                                      child: Image.asset(
                                        "assets/icons/drawer_icon.png",
                                        height:
                                            MediaQuery.of(context).size.width *
                                                (1 / 8),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * (1 / 12),
                            ),
                            child: SearchBarWidget(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(), // Show loading indicator
                    )
                  : services.isEmpty
                      ? const Center(child: Text('No services available.'))
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 2 buttons per row
                              mainAxisSpacing: 16.0,
                              crossAxisSpacing: 16.0,
                              childAspectRatio:
                                  5 / 4, // Adjusts height relative to width
                            ),
                            itemCount: servicesList.length,
                            itemBuilder: (context, index) {
                              final service = servicesList[index];
                              return BigButton(
                                title: service.serviceName,
                                imagePath: service.imagePath,
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         BookingDetailsProvidingScreen(
                                  //       service: service,
                                  //     ),
                                  //   ),
                                  // );
                                  initBooking(service, service.serviceId, currentuser!.uid);
                                },
                              );
                            },
                          ),
                        ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * (1 / 13),
                ),
                child: Text(
                  'Top pick',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(), // Show loading indicator
                    )
                  : CarouselWidget(
                      services: servicesList,
                    ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
    Future<void> initBooking(ServiceModel selectedServiceModel,String serviceType, String customerUid) async {
    final bookingMethods =
        Provider.of<BookingMethods>(context, listen: false);
        bookingMethods.createNewBooking(context, selectedServiceModel, serviceType, customerUid);
    
    
  }
}
