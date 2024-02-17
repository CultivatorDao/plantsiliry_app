import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:plantsility_app/models/user.dart';


class DatabaseService {
  /// Main Database class.
  ///
  /// Responsible for all operations related to database.

  DatabaseService(
    {
      this.uid,
    }
  );

  // user uid
  final String? uid;

  // collection reference
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');
  // final CollectionReference _productCollection = FirebaseFirestore.instance.collection("products");
  // final CollectionReference _plantCollection = FirebaseFirestore.instance.collection("plants");

  // update user data
  Future updateUserData(UserModel userData) async {
    return await _userCollection.doc(uid).set(
      {
        "username": userData.username,
        "first_name": userData.firstName,
        "last_name": userData.lastName,
        "email": userData.email,
        "phone_number": userData.phoneNumber,
        "favorite": userData.favorite,
      }
    );
  }

  // user list from snapshot
  List<UserModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
        return UserModel(
          uid: doc.id,
          username: doc.get("username") ?? '',
          firstName: doc.get("first_name") ?? '',
          lastName: doc.get("last_name") ?? '',
          email: doc.get("email") ?? '',
          phoneNumber: doc.get("phone_number") ?? '',
          favorite: doc.get("favorite") ?? const [],
        );
      }
    ).toList();
  }

  // get user stream
  Stream<List<UserModel>> get users {
    return _userCollection.snapshots().map(_userListFromSnapshot);
  }

}