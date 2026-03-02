import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lsm_legends/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<UserModel?> register({required UserModel user}) async {
    try {
      // 1. Create user in Firebase Auth
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      if (credential.user != null) {
        // 2. Prepare user data for Firestore
        UserModel newUser = UserModel(
          uId: credential.user!.uid,
          fullName: user.fullName,
          email: user.email,
          username: user.username,
          role: 'student', // Default role
        );

        // 3. Save to Firestore (with error handling for offline/unavailable)
        try {
          await _firestore
              .collection('users')
              .doc(credential.user!.uid)
              .set(newUser.toJson())
              .timeout(
                const Duration(seconds: 10),
              ); // Reduced timeout for better UX
        } catch (firestoreError) {
          // If Firestore times out or fails (e.g. due to rules, network, or persistence issues),
          // we still want the registration to succeed because the Auth user was created.
          print(
            'Firestore Save Warning: $firestoreError. Proceeding with Auth creation only.',
          );
        }

        // Send Verification Email
        try {
          await credential.user!.sendEmailVerification();
        } catch (e) {
          print('Error sending verification email: $e');
        }

        // 4. Save to SharedPreferences for local persistence
        // final pref = await SharedPreferences.getInstance();
        // pref.setString('user', jsonEncode(newUser.toJson())); // Do not auto-login

        return newUser;
      }
      return null;
    } catch (e) {
      print('Firebase Register Exception: $e');
      return null;
    }
  }

  static Future<UserModel?> login({required UserModel user}) async {
    try {
      // 1. Sign in with Firebase Auth
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      if (credential.user != null) {
        if (!credential.user!.emailVerified) {
          throw FirebaseAuthException(
            code: 'email-unverified',
            message: 'Please verify your email address to continue.',
          );
        }
        try {
          // 2. Fetch user details from Firestore
          final uid = credential.user!.uid;
          print('DEBUG: Starting Firestore Request for UID: "$uid"');

          DocumentSnapshot? doc;
          int retryCount = 0;
          const maxRetries = 2;

          while (retryCount <= maxRetries) {
            try {
              doc = await _firestore
                  .collection('users')
                  .doc(uid)
                  .get()
                  .timeout(const Duration(seconds: 35));
              break; // Success!
            } catch (e) {
              if (e.toString().contains('unavailable') &&
                  retryCount < maxRetries) {
                print(
                  'DEBUG: Firestore temporary unavailable. Retrying... (${retryCount + 1})',
                );
                retryCount++;
                await Future.delayed(const Duration(seconds: 2));
              } else {
                rethrow;
              }
            }
          }

          if (doc != null && doc.exists) {
            UserModel authenticatedUser = UserModel.fromJson(
              doc.data() as Map<String, dynamic>,
            );

            // 3. Save to SharedPreferences
            final pref = await SharedPreferences.getInstance();
            pref.setString('user', jsonEncode(authenticatedUser.toJson()));

            return authenticatedUser;
          } else {
            print(
              'User exists in Auth but not Firestore. Using default profile.',
            );
            return await _getFallbackUser(credential.user!, user.email);
          }
        } catch (firestoreError, stack) {
          print(
            '---------------------- FIRESTORE ERROR ----------------------',
          );
          print('Error: $firestoreError');
          print('Stacktrace: $stack');
          print(
            '-------------------------------------------------------------',
          );
          // If Firestore is unreachable but Auth succeeded, we let them in as student
          return await _getFallbackUser(credential.user!, user.email);
        }
      }
      return null;
    } catch (e) {
      print('Firebase Login Exception: $e');
      return null;
    }
  }

  static Future<UserModel> _getFallbackUser(
    User firebaseUser,
    String? email,
  ) async {
    UserModel fallbackUser = UserModel(
      uId: firebaseUser.uid,
      email: firebaseUser.email ?? email,
      fullName:
          firebaseUser.displayName ??
          (firebaseUser.email?.split('@')[0] ?? 'Demo User'),
      role: 'student',
    );

    final pref = await SharedPreferences.getInstance();
    pref.setString('user', jsonEncode(fallbackUser.toJson()));
    return fallbackUser;
  }

  static Future<void> sendEmailVerification() async {
    try {
      if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
      }
    } catch (e) {
      print('Firebase sendEmailVerification Exception: $e');
      rethrow;
    }
  }

  static Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Firebase resetPassword Exception: $e');
      rethrow;
    }
  }
}
