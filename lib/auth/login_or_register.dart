import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/screens/login_screen.dart';
import 'package:impeccablehome_customer/screens/signup_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage=true;
  void togglePages(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LogInScreen(goToSignUpScreen: togglePages);
    }else{
      return SignUpScreen(goToLogInScreen: togglePages);
    }
  }
}