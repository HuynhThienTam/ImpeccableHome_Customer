import "package:flutter/material.dart";
import "package:impeccablehome_customer/components/custom_button.dart";
import "package:impeccablehome_customer/components/custom_text_input.dart";
import "package:impeccablehome_customer/components/login_header_widget.dart";
import 'package:country_picker/country_picker.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:flutter/gestures.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
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
    ),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginHeaderWidget(
              iconImage: Image.asset(
                              "assets/icons/clean_home_icon.png",
                              height: 75,
                            ), 
              title: "Sign up", 
              briefDescription: TextSpan(
                      text: "Create an account!\nAlready have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white, 
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: "Log in",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: orangeColor, 
                            decoration: TextDecoration.underline, 
                            height: 1.5,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * (2 / 15),
              ),
              child: Column(
                children: [
                  CustomTextInput(
                    hintText: "Enter your name",
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
                    height: 25,
                  ),
                  CustomTextInput(
                    hintText: "Enter password",
                    prefixImage: Image.asset(
                      "assets/icons/small_key_icon.png",
                      fit: BoxFit.contain,
                    ),
                    title: "Password",
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomTextInput(
                    hintText: "Retype password",
                    prefixImage: Image.asset(
                      "assets/icons/small_key_icon.png",
                      fit: BoxFit.contain,
                    ),
                    title: "Retype your password",
                    controller: confirmPasswordController,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(title: "Sign up", onTap: (){}),
                    SizedBox(
                    height: 85,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
