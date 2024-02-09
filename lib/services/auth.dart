import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantsility_app/models/user.dart';


class AuthService {

  // Initialize firebase auth instance
  // for all authentication operations
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  UserModel? _getUserFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // auth change stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges()
        .map(_getUserFromFirebaseUser); // Convert Firebase User to our custom UserModel
  }

  // sign in anonymous
  Future signInAnon() async {
    try {
      UserCredential response = await _auth.signInAnonymously();
      User? user = response.user;
      return _getUserFromFirebaseUser(user);
    }
    catch(error) {
      // Catching error in DEBUG
      // TODO remove in release
      debugPrint(error.toString());
      return null;
    }
  }

  // sign in with email

  // sign up with email

  // sign out
}