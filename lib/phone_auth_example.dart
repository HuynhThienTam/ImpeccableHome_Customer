import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthExample extends StatefulWidget {
  @override
  _PhoneAuthExampleState createState() => _PhoneAuthExampleState();
}

class _PhoneAuthExampleState extends State<PhoneAuthExample> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? _verificationId;

  Future<void> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-resolve OTP (for certain devices)
        await _auth.signInWithCredential(credential);
        print("Phone number automatically verified and user signed in: ${_auth.currentUser}");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Phone number verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        print("OTP sent to phone");
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> _signInWithOtp() async {
    final otp = _otpController.text.trim();
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );

    try {
      await _auth.signInWithCredential(credential);
      print("Phone number verified and user signed in: ${_auth.currentUser}");
    } catch (e) {
      print("Failed to sign in: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Auth Example")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: Text("Verify Phone Number"),
            ),
            if (_verificationId != null) ...[
              TextField(
                controller: _otpController,
                decoration: InputDecoration(labelText: "OTP"),
              ),
              ElevatedButton(
                onPressed: _signInWithOtp,
                child: Text("Sign in"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
