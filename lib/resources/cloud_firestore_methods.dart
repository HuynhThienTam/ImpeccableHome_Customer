import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:impeccablehome_customer/model/service_model.dart';
import 'package:impeccablehome_customer/model/user_model.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // Future uploadNameAndImageToDatabase(
  //     {required UserModel user}) async {
  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(firebaseAuth.currentUser!.uid)
  //       .set(user.toMap());
  // }
  // final _servicesCollection = FirebaseFirestore.instance.collection('services');

  // Future<List<ServiceModel>> fetchAllServices() async {
  //   try {
  //     final querySnapshot = await _servicesCollection.get();
  //     return querySnapshot.docs
  //         .map((doc) => ServiceModel.fromMap(doc.data() as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     print('Error fetching services: $e');
  //     return [];
  //   }
  // }

  Future<List<ServiceModel>> fetchServices() async {
    try {
      // Fetch all documents from the 'services' collection
      final querySnapshot =
          await firebaseFirestore.collection('services').get();

      // Map Firestore documents to ServiceModel objects
      return querySnapshot.docs
          .map(
              (doc) => ServiceModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching services: $e');
      return []; // Return an empty list in case of error
    }
  }
}
