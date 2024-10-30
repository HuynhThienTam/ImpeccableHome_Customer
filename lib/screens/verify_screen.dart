import "package:flutter/material.dart";
import "package:impeccablehome_customer/components/clickable_text.dart";
import "package:impeccablehome_customer/components/custom_button.dart";
import "package:impeccablehome_customer/components/login_header_widget.dart";
import "package:impeccablehome_customer/resources/authentication_method.dart";
import 'package:impeccablehome_customer/utils/color_themes.dart';
import 'package:pinput/pinput.dart';
import "package:provider/provider.dart";

class VerifyScreen extends StatefulWidget {
  final String verificationId;
  final bool? isLoggingIn;
  const VerifyScreen(
      {super.key, required this.verificationId, this.isLoggingIn = false});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String? otpCode;
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
                "assets/icons/phone_icon.png",
                height: 100,
              ),
              title: "   Verify",
              briefDescription: TextSpan(
                text:
                    "Please enter the verification code sent to\nyour phone number",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * (2 / 15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Pinput(
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: silverGrayColor,
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onCompleted: (value) {
                      setState(() {
                        otpCode = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      ClickableText(text: "Resend your code", onTap: () {}),
                      Expanded(child: Container()),
                      ClickableText(text: "Expire after 23s", onTap: () {}),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      title: "Confirm",
                      onTap: () {
                        verifyOtp(context, otpCode!);
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

  void verifyOtp(BuildContext context, String userOtp) {
    final authMethods =
        Provider.of<AuthenticationMethods>(context, listen: false);
    if (widget.isLoggingIn!) {
      authMethods.verifyOtpForLogin(
          context: context,
          verificationId: widget.verificationId,
          userOtp: userOtp);
    } else {
      authMethods.verifyOtpForRegister(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSuccess: () {},
      );
    }
  }
}
