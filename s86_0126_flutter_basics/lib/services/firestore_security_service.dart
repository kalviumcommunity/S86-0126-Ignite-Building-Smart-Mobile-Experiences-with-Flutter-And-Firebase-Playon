import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreSecurityService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get current user ID
  static String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  /// Get current user email
  static String? getCurrentUserEmail() {
    return _auth.currentUser?.email;
  }

  /// Check if user is authenticated
  static bool isAuthenticated() {
    return _auth.currentUser != null;
  }

  /// Update user profile with security rules
  /// Only allows authenticated users to update their own document
  static Future<void> updateUserProfile({
    required String name,
    required String bio,
    required String role,
  }) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not authenticated");
      }

      debugPrint(
          "🔒 [SECURITY] Updating user profile for UID: $uid");

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': _auth.currentUser?.email,
        'name': name,
        'bio': bio,
        'role': role,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      debugPrint(
          "✅ [SECURITY] User profile updated successfully");
    } catch (e) {
      debugPrint("❌ [SECURITY] Error updating profile: $e");
      rethrow;
    }
  }

  /// Read user's own profile (restricted by rules)
  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not authenticated");
      }

      debugPrint(
          "🔒 [SECURITY] Reading user profile for UID: $uid");

      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        debugPrint(
            "✅ [SECURITY] User profile retrieved successfully");
        return doc.data();
      }
      return null;
    } catch (e) {
      debugPrint("❌ [SECURITY] Error reading profile: $e");
      rethrow;
    }
  }

  /// Add tournament result (only for authenticated users)
  static Future<String> addTournamentResult({
    required String teamName,
    required int score,
    required int wins,
    required int draws,
    required int losses,
  }) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not authenticated");
      }

      debugPrint(
          "🔒 [SECURITY] Adding tournament result for user: $uid");

      final doc = await _firestore
          .collection('users')
          .doc(uid)
          .collection('tournamentResults')
          .add({
        'teamName': teamName,
        'score': score,
        'wins': wins,
        'draws': draws,
        'losses': losses,
        'createdBy': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      debugPrint(
          "✅ [SECURITY] Tournament result added: ${doc.id}");
      return doc.id;
    } catch (e) {
      debugPrint("❌ [SECURITY] Error adding tournament result: $e");
      rethrow;
    }
  }

  /// Get user's tournament results (only their own)
  static Future<List<Map<String, dynamic>>> getTournamentResults() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not authenticated");
      }

      debugPrint(
          "🔒 [SECURITY] Fetching tournament results for user: $uid");

      final snapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('tournamentResults')
          .orderBy('createdAt', descending: true)
          .get();

      debugPrint(
          "✅ [SECURITY] Retrieved ${snapshot.docs.length} tournament results");
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      debugPrint("❌ [SECURITY] Error fetching results: $e");
      rethrow;
    }
  }

  /// Delete user's own tournament result
  static Future<void> deleteTournamentResult(String resultId) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not authenticated");
      }

      debugPrint(
          "🔒 [SECURITY] Deleting tournament result: $resultId for user: $uid");

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('tournamentResults')
          .doc(resultId)
          .delete();

      debugPrint(
          "✅ [SECURITY] Tournament result deleted successfully");
    } catch (e) {
      debugPrint("❌ [SECURITY] Error deleting result: $e");
      rethrow;
    }
  }
}
