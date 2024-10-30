import "package:flutter/material.dart";
import "package:impeccablehome_customer/components/clickable_text.dart";
import "package:impeccablehome_customer/components/custom_button.dart";
import "package:impeccablehome_customer/components/custom_text_input.dart";
import "package:impeccablehome_customer/components/login_header_widget.dart";
import 'package:country_picker/country_picker.dart';
import "package:impeccablehome_customer/resources/authentication_method.dart";
import "package:impeccablehome_customer/resources/cloud_firestore_methods.dart";
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:flutter/gestures.dart';
import "package:impeccablehome_customer/utils/utils.dart";
import "package:provider/provider.dart";

class LogInScreen extends StatefulWidget {
  final Function()? goToSignUpScreen;
  const LogInScreen({super.key, required this.goToSignUpScreen});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController passwordController = TextEditingController();
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
              title: "  Log in",
              briefDescription: TextSpan(
                text: "Welcome back!\nDon’t have an account? ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: "Sign up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: orangeColor,
                      decoration: TextDecoration.underline,
                      height: 1.5,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.goToSignUpScreen,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * (2 / 15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  ClickableText(
                      text: "Forgot you password?", isLink: true, onTap: () {}),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      title: "Log in",
                      onTap: () {signIn();
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
  void signIn(){
    final authMethods= Provider.of<AuthenticationMethods>(context,listen: false);
    String phoneNumber=phoneController.text.trim();
    String passWord=passwordController.text.trim();
    authMethods.signIn(context: context, phoneNumber: "+${selectedCountryNotifier.value.phoneCode}$phoneNumber", passWord: passWord);
  }
}
