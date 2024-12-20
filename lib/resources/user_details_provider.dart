import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:impeccablehome_customer/model/user_model.dart';

class UserDetailsProvider with ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  // Fetch user data from Firestore
  Future<void> fetchCurrentUser(String currentUserId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users') // Firestore collection name
          .doc(currentUserId) // Document ID = user ID
          .get();

      if (userDoc.exists) {
        _currentUser = UserModel.fromMap(userDoc.data()!);
        notifyListeners();
      } else {
        debugPrint('User not found in Firestore');
      }
    } catch (e) {
      debugPrint('Error fetching user: $e');
    }
  }
}
