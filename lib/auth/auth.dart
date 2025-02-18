import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:impeccablehome_customer/auth/login_or_register.dart';
import 'package:impeccablehome_customer/layout/screen_layout.dart';
import 'package:impeccablehome_customer/resources/cloud_firestore_methods.dart';
import 'package:impeccablehome_customer/screens/add_user_detail_screen.dart';
import 'package:impeccablehome_customer/screens/home_screen.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading state
          }
          else if (snapshot.hasData) {
            return ScreenLayout();
            //return const ScreenLayout();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
