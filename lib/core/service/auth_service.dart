import 'package:firebase_auth/firebase_auth.dart';
import 'package:loyality_craft/core/app_locator.dart';

import '../app_router.gr.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final _router = locator<AppRouter>();

  Future<bool> checkAuthStatus() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signInWithAccessToken(
      {required String accessToken, required String idToken}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(GoogleAuthProvider.credential(
              accessToken: accessToken, idToken: idToken));
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Stream<User?> checkAuthStatusStream() {
    try {
      return _firebaseAuth.authStateChanges();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  User getUser() {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        return user;
      } else {
        throw Exception('User is null');
      }
    } catch (e) {
      rethrow;
    }
  }
}
