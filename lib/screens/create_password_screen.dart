import "package:flutter/material.dart";
import "package:impeccablehome_customer/components/big_text.dart";
import "package:impeccablehome_customer/components/custom_button.dart";
import "package:impeccablehome_customer/components/custom_text_input.dart";
import "package:impeccablehome_customer/components/small_text.dart";
import 'package:impeccablehome_customer/utils/color_themes.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                      BigText(text: "Create new password"),
                      SizedBox(
                        height: 25,
                      ),
                      SmallText(text: "Please set a new and strong password."),
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
                      CustomButton(title: "Confirm", onTap: () {}),
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
