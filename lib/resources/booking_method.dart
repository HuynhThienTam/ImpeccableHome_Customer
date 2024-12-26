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
import 'package:impeccablehome_customer/model/booking_model.dart';
import 'package:impeccablehome_customer/model/helper_model.dart';
import 'package:impeccablehome_customer/model/service_model.dart';
import 'package:impeccablehome_customer/model/user_model.dart';
import 'package:impeccablehome_customer/resources/cloud_firestore_methods.dart';
import 'package:impeccablehome_customer/screens/booking_details_providing_screen.dart';
import 'package:impeccablehome_customer/screens/booking_payment_method_providing_screen.dart';
import 'package:impeccablehome_customer/screens/booking_review_screen.dart';
import 'package:impeccablehome_customer/screens/booking_success_screen.dart';
import 'package:impeccablehome_customer/screens/home_screen.dart';
import 'package:impeccablehome_customer/screens/verify_screen.dart';
import 'package:impeccablehome_customer/utils/utils.dart';

class BookingMethods extends ChangeNotifier {
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();
  BookingModel? _bookingModel;
  BookingModel get bookingModel => _bookingModel!;
  void createNewBooking(
    BuildContext context,
    ServiceModel selectedServiceModel,
    String serviceType,
    String customerUid,
  ) async {
    try {
      _bookingModel = BookingModel(
          bookingNumber: "",
          serviceType: serviceType,
          customerUid: customerUid,
          customerName: "",
          helperUid: "",
          helperName: "",
          workingDay: DateTime.now(),
          startTime: DateTime.now(),
          finishedTime: DateTime.now(),
          location: "",
          province: "",
          note: "",
          paymentMethod: "",
          cardName: "",
          cardNumber: "",
          cvv: "",
          status: "");

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookingDetailsProvidingScreen(
                  isFromHome: true, service: selectedServiceModel)));
    } catch (e) {
      debugPrint('Error creating booking: $e');
      return null;
    }
  }

  void addBookingPaymentMethod(
    BuildContext context,
    ServiceModel serviceModel,
    String selectedMethod,
    String cardHolderName,
    String cardNumber,
    String cvv,
    bool isFromHome,
  ) async {
    try {
      bookingModel.paymentMethod = selectedMethod;
      bookingModel.cardName = cardHolderName;
      bookingModel.cardNumber = cardNumber;
      bookingModel.cvv = cvv;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingReviewScreen(
            serviceModel: serviceModel,
            bookingModel: bookingModel,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error providing booking payment: $e');
      return null;
    }
  }

  void addBookingDetails(
    BuildContext context,
    ServiceModel serviceModel,
    String helperUid,
    DateTime workingDay,
    DateTime startTime,
    DateTime finishedTime,
    String location,
    String province,
    String note,
    bool isFromHome,
  ) async {
    try {
      bookingModel.helperUid = helperUid;
      bookingModel.workingDay = workingDay;
      bookingModel.startTime = startTime;
      bookingModel.finishedTime = finishedTime;
      bookingModel.location = location;
      bookingModel.province = province;
      bookingModel.note = note;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookingPaymentMethodProvidingScreen(
                    serviceModel: serviceModel,
                    isFromHome: isFromHome,
                  )));
    } catch (e) {
      debugPrint('Error providing booking details: $e');
      return null;
    }
  }

  Future<List<BookingModel>> fetchBookings() async {
    try {
      // Fetch bookings from Firestore
      final bookingsSnapshot =
          await FirebaseFirestore.instance.collection('bookings').get();

      final List<BookingModel> bookings = [];
      for (var doc in bookingsSnapshot.docs) {
        final data = doc.data();

        // Fetch customer and helper details based on UIDs
        final customerSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(data['customerUid'])
            .get();

        final helperSnapshot = await FirebaseFirestore.instance
            .collection('helpers')
            .doc(data['helperUid'])
            .get();

        // Map the BookingModel
        bookings.add(BookingModel(
          bookingNumber: data['bookingNumber'],
          serviceType: data['serviceType'],
          customerUid: data['customerUid'],
          customerName: customerSnapshot.data()?['name'] ?? 'Unknown',
          helperUid: data['helperUid'],
          helperName: helperSnapshot.data()?['name'] ?? 'Unknown',
          workingDay: (data['workingDay'] as Timestamp).toDate(),
          startTime: (data['startTime'] as Timestamp).toDate(),
          finishedTime: (data['finishedTime'] as Timestamp).toDate(),
          location: data['location'],
          province: data['province'],
          note: data['note'],
          paymentMethod: data['paymentMethod'],
          cardName: data['cardName'],
          cardNumber: data['cardNumber'],
          cvv: data['cvv'],
          status: data['status'],
        ));
      }

      return bookings;
    } catch (e) {
      print('Error fetching bookings: $e');
      return [];
    }
  }

  Future<void> uploadBookingToFirebase(BuildContext context,ServiceModel serviceModel,) async {
    try {
      // Convert the BookingModel to a map
      Map<String, dynamic> bookingData = bookingModel.toMap();

      // Upload the booking to Firestore
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('bookings')
          .add(bookingData);
      // Use the document ID as the bookingNumber and update the document
      await docRef.update({'bookingNumber': docRef.id});
      // Add a notification to the helper's notifications subcollection
    await FirebaseFirestore.instance
        .collection('helpers')
        .doc(bookingModel.helperUid)
        .collection('notifications')
        .add({
      'title': 'New Booking Assigned',
      'image': serviceModel.colorfulImagePath,
      'content': 'You have a new booking on ${bookingModel.workingDay}. Please check out and confirm soon!',
      'createdAt': DateTime.now(),
      'type':"Booking",
      'isRead': false,
    });
      debugPrint('Booking uploaded successfully with ID: ${docRef.id}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BookingSuccessScreen(), // Replace with your actual SuccessScreen widget
        ),
      );
    } catch (e) {
      debugPrint('Error uploading booking: $e');
      showSnackBar(context, "Booking fails");
    }
  }
}
