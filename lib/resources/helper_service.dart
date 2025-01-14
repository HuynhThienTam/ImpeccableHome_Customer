import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:impeccablehome_customer/model/helper_model.dart';

class HelperService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch helper details by `helperUid`
  Future<HelperModel?> fetchHelperDetails(String helperUid) async {
    try {
      final doc = await _firestore.collection('helpers').doc(helperUid).get();

      if (doc.exists) {
        final data = doc.data()!;
        return HelperModel(
          firstName: data['firstName'] ?? '',
          lastName: data['lastName'] ?? '',
          email: data['email'] ?? '',
          province: data['province'] ?? '',
          serviceType: data['serviceType'] ?? '',
          phoneNumber: data['phoneNumber'] ?? '',
          helperUid: data['helperUid'] ?? '',
          lastLogOutAt: data['lastLogOutAt'] ?? '',
          status: data['status'] ?? '',
          profilePic: data['profilePic'] ?? '',
          isApproved: data['isApproved'] ?? '',
          ratings: double.tryParse(data['ratings']?.toString() ?? '0.0') ?? 0.0,
          gender: data['gender'] ?? '',
          dateOfBirth: data['dateOfBirth'] ?? '',
          createdAt: '',
          idCardFront: '',
          idCardBack: '',
          idCardNumber: '',
          houseAddress: '',
          emergencyContactName: '',
          emergencyContactRelationship: '',
          emergencyContactAddress: '',
          emergencyContactPhoneNumber: '',
        );
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching helper details: $e');
      return null;
    }
  }

  /// Fetch a list of helpers by `province` and `serviceType`
  Future<List<HelperModel>> fetchHelpersByProvinceAndServiceType(
      String province, String serviceType) async {
    try {
      final querySnapshot = await _firestore
          .collection('helpers')
          .where('province', isEqualTo: province)
          .where('serviceType', isEqualTo: serviceType)
          .get();
      if (querySnapshot.docs.isEmpty) {
        debugPrint(
            'No helpers found for province: $province and serviceType: $serviceType');
        return [];
      }
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return HelperModel(
          firstName: data['firstName'] ?? '',
          lastName: data['lastName'] ?? '',
          email: data['email'] ?? '',
          province: data['province'] ?? '',
          serviceType: data['serviceType'] ?? '',
          phoneNumber: data['phoneNumber'] ?? '',
          helperUid: data['helperUid'] ?? '',
          lastLogOutAt: data['lastLogOutAt'] ?? '',
          status: data['status'] ?? '',
          profilePic: data['profilePic'] ?? '',
          isApproved: data['isApproved'] ?? '',
          ratings: double.tryParse(data['ratings']?.toString() ?? '0.0') ?? 0.0,
          gender: data['gender'] ?? '',
          dateOfBirth: data['dateOfBirth'] ?? '',
          createdAt: '',
          idCardFront: '',
          idCardBack: '',
          idCardNumber: '',
          houseAddress: '',
          emergencyContactName: '',
          emergencyContactRelationship: '',
          emergencyContactAddress: '',
          emergencyContactPhoneNumber: '',
        );
      }).toList();
    } catch (e) {
      debugPrint('Error fetching helpers: $e');
      return [];
    }
  }
}
