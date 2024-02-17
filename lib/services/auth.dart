import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantsility_app/models/user.dart';
import 'package:plantsility_app/services/database.dart';


class AuthService {
  /// Main authentication class.
  ///
  /// Responsible for all authentication operations with FireBase Authentication service.

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
  Future signIn(email, password) async {
    try {
      UserCredential response = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = response.user;
      return _getUserFromFirebaseUser(user);
    }
    catch(error) {
      // TODO remove in release
      debugPrint(error.toString());
      return null;
    }
  }

  // sign up with email
  Future signUp(String email, String password) async {
    try {
      UserCredential response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = response.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user?.uid).updateUserData(UserDataModel());

      return _getUserFromFirebaseUser(user);
    }
    catch(error) {
      // TODO remove in release
      debugPrint(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch(error) {
      // Catching error in DEBUG
      // TODO remove in release
      debugPrint(error.toString());
      return null;
    }
  }
}