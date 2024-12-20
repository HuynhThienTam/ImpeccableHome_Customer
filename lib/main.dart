import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:impeccablehome_customer/auth/auth.dart';
import 'package:impeccablehome_customer/phone_auth_example.dart';
import 'package:impeccablehome_customer/resources/authentication_method.dart';
import 'package:impeccablehome_customer/resources/user_details_provider.dart';
import 'package:impeccablehome_customer/screens/create_password_screen.dart';
import 'package:impeccablehome_customer/screens/login_screen.dart';
import 'package:impeccablehome_customer/screens/reset_password_screen.dart';
import 'package:impeccablehome_customer/screens/signup_screen.dart';
import 'package:impeccablehome_customer/screens/verify_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    androidProvider:
        AndroidProvider.playIntegrity, // or AndroidProvider.safetyNet
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationMethods()),
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Phone Auth',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: AuthGate(),
      ),
    );
  }
}
