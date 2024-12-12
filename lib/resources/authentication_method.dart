import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impeccablehome_customer/layout/screen_layout.dart';
import 'package:impeccablehome_customer/model/user_model.dart';
import 'package:impeccablehome_customer/resources/cloud_firestore_methods.dart';
import 'package:impeccablehome_customer/screens/home_screen.dart';
import 'package:impeccablehome_customer/screens/verify_screen.dart';
import 'package:impeccablehome_customer/utils/utils.dart';

class AuthenticationMethods extends ChangeNotifier {
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();
  Duration timeoutDuration = const Duration(seconds: 60);
  void verifyPhoneNumberForRegister(
    BuildContext context,
    String phoneNumber,
    String userName,
    String passWord,
  ) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: timeoutDuration,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            _userModel = UserModel(
                name: userName,
                bio: "",
                passWord: passWord,
                profilePic: "",
                phoneNumber: phoneNumber,
                uid: "",
                email: "",
                createdAt: "",
                lastLogOutAt: "",
                status: "");
                
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VerifyScreen(verificationId: verificationId)),
                      (route) => false
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtpForRegister({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      final userCred = await firebaseAuth.signInWithCredential(creds);
      userModel.uid = userCred.user!.uid;
      userModel.status = "onl";
      userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      await CloudFirestoreClass()
          .firebaseFirestore
          .collection('users')
          .doc(userCred.user?.uid)
          .set(userModel.toMap());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ScreenLayout(initialIndex: 0,)),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future userSignOut() async {
    String now = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .update({
      'status': 'off',
      'lastLogOutAt': now,
    });
    await firebaseAuth.signOut();
  }

void signIn({
  required BuildContext context,
  required String phoneNumber,
  required String passWord,
}) async {
  try {
    // Search for user by phone number
    final query = await CloudFirestoreClass()
        .firebaseFirestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    if (!context.mounted) return; // Ensure context is still valid

    if (query.docs.isEmpty) {
      showSnackBar(context, "User not found.");
      return;
    }

    // Check password
    final userDoc = query.docs.first;
    if (userDoc['passWord'] == passWord) {
      if (!context.mounted) return; // Double-check context before navigation
      signInWithPhone(context, phoneNumber);
    } else {
      if (!context.mounted) return; // Check context before showing a snackbar
      showSnackBar(context, "Incorrect password");
    }
  } catch (e) {
    if (context.mounted) {
      // showSnackBar(context, "An error occurred: $e");
      debugPrint("An error occurred: $e"); // Logs the error to the terminal
    }
  }
}


  void signInWithPhone(BuildContext context, String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: timeoutDuration,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-signs the user in with the provided credential
        await firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => VerifyScreen(
                  verificationId: verificationId, isLoggingIn: true)),
                  (route) => false
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOtpForLogin({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
  }) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      firebaseAuth.signInWithCredential(creds);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'status': 'onl',
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ScreenLayout(initialIndex: 0,)),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      // notifyListeners();
    }
  }
  Future<bool> isPhoneNumberUsed(String phoneNumber) async {
  try {
    // Query Firestore for the phone number
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    // Check if any documents were returned
    return snapshot.docs.isNotEmpty;
  } catch (e) {
    print("Error checking phone number: $e");
    return false; // Consider it unused if an error occurs
  }
}
}
