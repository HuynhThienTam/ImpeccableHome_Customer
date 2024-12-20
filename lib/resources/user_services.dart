import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/model/user_model.dart';

class UserService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Future<UserModel?> fetchUserDetails(String userId) async {
    try {
      // Fetch user details from Firestore
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        // Retrieve profile picture URL from Firebase Storage
        // final profilePicUrl = await FirebaseStorage.instance
        //     .ref('userProfilePic/$userId')
        //     .getDownloadURL();
        String? profilePicUrl;
        try {
          // Try to retrieve profile picture URL from Firebase Storage
          profilePicUrl = await FirebaseStorage.instance
              .ref('userProfilePic/$userId')
              .getDownloadURL();
        } catch (e) {
          if (e.toString().contains('object-not-found')) {
            debugPrint('Profile picture not found in Storage for user $userId');
          } else {
            debugPrint('Error fetching profile picture: $e');
          }
        }
        final data = doc.data()!;
        data['profilePicUrl'] = profilePicUrl; // Add profile pic to data
        return UserModel.fromMap(data);
      } else {
        debugPrint('User not found in Firestore');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching user details: $e');
      return null;
    }
  }

  Future<void> uploadPhoto(String userId, String filePath) async {
    String profilePicUrl = "";

    try {
      // Upload file to Firebase Storage and get the download URL
      profilePicUrl =
          await storeFileToStorage("userProfilePic/$userId", File(filePath));

      // Update the `profilePicUrl` in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'profilePic': profilePicUrl,
      });

      debugPrint("Photo updated successfully in Firestore");
    } catch (e) {
      debugPrint("Error uploading photo: $e");
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
