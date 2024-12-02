import "package:flutter/material.dart";
import "package:impeccablehome_customer/components/custom_button.dart";
import "package:impeccablehome_customer/components/custom_text_input.dart";
import "package:impeccablehome_customer/components/login_header_widget.dart";
import 'package:country_picker/country_picker.dart';
import "package:impeccablehome_customer/resources/authentication_method.dart";
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:flutter/gestures.dart';
import "package:impeccablehome_customer/utils/utils.dart";
import "package:provider/provider.dart";

class SignUpScreen extends StatefulWidget {
  final Function()? goToLogInScreen;
  const SignUpScreen({super.key, required this.goToLogInScreen});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.goToLogInScreen,
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
                  CustomButton(
                      title: "Sign up",
                      onTap: () {
                        sendPhoneNumber();
                      }),
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

  Future<void> sendPhoneNumber() async {
    final authMethods =
        Provider.of<AuthenticationMethods>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    String passWord = passwordController.text.trim();
    String confirmPassWord = confirmPasswordController.text.trim();
    String userName = nameController.text.trim();
    bool isUsed = await authMethods.isPhoneNumberUsed("+${selectedCountryNotifier.value.phoneCode}$phoneNumber");
    if(userName==""){
      showSnackBar(context, "Enter user name!");
    }
    else if(phoneNumber==""){
      showSnackBar(context, "Enter phone number!");
    }
    else if(passWord==""){
      showSnackBar(context, "Enter password!");
    }
    else if(confirmPassWord==""){
      showSnackBar(context, "Retype password!");
    }
    else if (isUsed) {
      showSnackBar(context, "Phone number is already used.");
    } else {
      print("Phone number is available.");
      if (passWord == confirmPassWord) {
      authMethods.verifyPhoneNumberForRegister(
        context,
        "+${selectedCountryNotifier.value.phoneCode}$phoneNumber",
        userName,
        passWord,
      );
    } else {
      showSnackBar(context, "Passwords do not match");
    }
    }
    
  }
}
