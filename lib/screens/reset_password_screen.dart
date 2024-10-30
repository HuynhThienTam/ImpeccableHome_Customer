import "package:flutter/material.dart";
import "package:impeccablehome_customer/components/big_text.dart";
import "package:impeccablehome_customer/components/custom_button.dart";
import "package:impeccablehome_customer/components/custom_text_input.dart";
import 'package:country_picker/country_picker.dart';
import "package:impeccablehome_customer/components/small_text.dart";
import "package:impeccablehome_customer/screens/create_password_screen.dart";

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController phoneController = TextEditingController();
  final ValueNotifier<Country> selectedCountryNotifier = ValueNotifier<Country>(
    Country(
      phoneCode: "84",
      countryCode: "VN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Vietnam",
      example: "Vietnam",
      displayName: "Vietnam",
      displayNameNoCountryCode: "VN",
      e164Key: "",
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * (1 / 12),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 75,
                      ),
                      Image.asset(
                        "assets/icons/key_icon.png",
                        height: 62,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BigText(text: "Reset your password"),
                      SizedBox(
                        height: 25,
                      ),
                      SmallText(
                          text:
                              "Please enter your number. We will send a \ncode to your phone to reset your password."),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * (2 / 15),
                  ),
                  child: Column(
                    children: [
                      CustomTextInput(
                        hintText: "Enter your phone number",
                        prefixImage: Image.asset(
                          "assets/icons/small_phone_icon.png",
                          fit: BoxFit.contain,
                        ),
                        title: "Phone number",
                        controller: phoneController,
                        isPhoneNumber: true,
                        paraSelectedCountry: selectedCountryNotifier,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                          title: "Send my code",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreatePasswordScreen()),
                               );
                          }),
                      SizedBox(
                        height: 85,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
