import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> loginUser({
    required String identifier, // Can be email or phone number
    required String password,
  }) async {
    try {
      // Determine if identifier is an email or phone number
      QuerySnapshot userSnapshot;
      if (identifier.contains('@')) {
        // Query by email
        userSnapshot = await _firestore.collection('users')
            .where('email', isEqualTo: identifier)
            .get();
      } else {
        // Query by phone number
        userSnapshot = await _firestore.collection('users')
            .where('completeNumber', isEqualTo: identifier)
            .get();
      }

      // Check if user exists and password matches
      if (userSnapshot.docs.isNotEmpty) {
        final userData = userSnapshot.docs.first.data() as Map<String, dynamic>;
        final storedPassword = userData['password'];

        if (storedPassword == password) {
          // Login successful
          return true;
        } else {
          throw Exception('Password does not match');
        }
      } else {
        throw Exception('User does not exist');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during login: $e');
      }
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserByIdentifier(String identifier) async {
    try {
      // Determine if identifier is an email or phone number
      QuerySnapshot userSnapshot;
      if (identifier.contains('@')) {
        // Query by email
        userSnapshot = await _firestore.collection('users')
            .where('email', isEqualTo: identifier)
            .get();
      } else {
        // Query by phone number
        userSnapshot = await _firestore.collection('users')
            .where('completeNumber', isEqualTo: identifier)
            .get();
      }

      // Check if user exists
      if (userSnapshot.docs.isNotEmpty) {
        final userData = userSnapshot.docs.first.data() as Map<String, dynamic>;
        return userData;
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
      return null;
    }
  }
}
