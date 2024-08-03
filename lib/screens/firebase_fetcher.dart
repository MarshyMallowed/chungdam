import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method to fetch user data by phone number
  Future<Map<String, dynamic>?> getUserByPhoneNumber(String phoneNumber) async {
    try {
      // Query the 'users' collection where 'phoneNumber' matches the provided phone number
      QuerySnapshot querySnapshot = await _db
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1) // Fetch at most one document
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        DocumentSnapshot document = querySnapshot.docs.first;

        // Return the entire document data as a map
        return document.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
    return null;
  }
}
