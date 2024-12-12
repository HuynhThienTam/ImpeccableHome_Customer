import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impeccablehome_customer/components/custom_back_button.dart';
import 'package:impeccablehome_customer/components/avatar_widget.dart';
import 'package:impeccablehome_customer/components/custom_button.dart';
import 'package:impeccablehome_customer/components/custom_text_input.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();

    // Set the initial value of the TextEditingController
    nameController.text = "Lisa Hsu";
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
                height: screenWidth * (21 / 25),
                child: Stack(
                  children: [
                    // Background image
                    Image.asset("assets/images/home_header.png",
                        fit: BoxFit.cover),

                    // Column for the title and back button
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * (1 / 13)),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: screenWidth * (1 / 6)),
                            child: Row(
                              children: [
                                CustomBackButton(color: Colors.white),
                                SizedBox(width: screenWidth * (3 / 13)),
                                Text(
                                  "Your profile",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Avatar widget positioned correctly
                    Positioned(
                      top: screenWidth *
                          13 /
                          32, // Adjust the position as needed
                      left: screenWidth / 2 -
                          (screenWidth * 2 / 5) /
                              2, // Center avatar horizontally
                      child: AvatarWidget(
                        imageUrl: 'https://picsum.photos/201',
                        size: screenWidth * 2 / 5,
                        onPressed: () {
                          print('Camera icon pressed!');
                        },
                      ),
                    ),
                  ],
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
                      height: 20,
                    ),
                    CustomTextInput(
                      hintText: "Enter new name here",
                      prefixImage: Image.asset(
                        "assets/icons/small_person_icon.png",
                        fit: BoxFit.contain,
                      ),
                      title: "Your mame",
                      controller: nameController,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    CustomTextInput(
                      hintText: "Enter your current phone number",
                      prefixImage: Image.asset(
                        "assets/icons/small_phone_icon.png",
                        fit: BoxFit.contain,
                      ),
                      title: "Phone number",
                      controller: phoneController,
                    ),
                     SizedBox(
                      height: 25,
                    ),
                    CustomTextInput(
                      hintText: "Enter your email",
                      prefixImage: Image.asset(
                        "assets/icons/email_icon.png",
                        fit: BoxFit.contain,
                      ),
                      title: "Email",
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    CustomButton(title: "Change password", onTap: (){}, textColor: Colors.white, backgroundColor: orangeColor,),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(title: "Save", onTap: (){}, textColor: Colors.white, backgroundColor: oceanBlueColor,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
