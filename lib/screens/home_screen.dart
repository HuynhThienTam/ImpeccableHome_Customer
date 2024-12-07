import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/components/big_button.dart';
import 'package:impeccablehome_customer/components/carousel_widget.dart';
import 'package:impeccablehome_customer/components/gradient_container.dart';
import 'package:impeccablehome_customer/components/search_bar_widget.dart';
import 'package:impeccablehome_customer/resources/authentication_method.dart';
import 'package:impeccablehome_customer/screens/booking_details_providing_screen.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:impeccablehome_customer/utils/mock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.purple,
      //   title: const Text("FlutterPhone Auth"),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         AuthenticationMethods().userSignOut();
      //       },
      //       icon: const Icon(Icons.exit_to_app),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                                      "Hi John,",
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
                                Image.asset(
                                  "assets/icons/drawer_icon.png",
                                  height: MediaQuery.of(context).size.width *
                                      (1 / 8),
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 buttons per row
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 5 / 4, // Adjusts height relative to width
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return BigButton(
                      title: service.serviceName,
                      imagePath: service.imagePath,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingDetailsProvidingScreen(service: service,),
                          ),
                        );
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
              CarouselWidget(
                services: services,
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
}
