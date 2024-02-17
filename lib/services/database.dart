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
  Future updateUserData(UserDataModel userData) async {
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
  List<UserDataModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
        return UserDataModel(
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

  // user data from snapshot
  UserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataModel(
      username: snapshot.get("username"),
      firstName: snapshot.get("first_name"),
      lastName: snapshot.get("last_name"),
      email: snapshot.get("email"),
      phoneNumber: snapshot.get("phone_number"),
      favorite: snapshot.get("favorite"),
    );
  }

  // TODO: change user stream to product stream
  // get user stream
  Stream<List<UserDataModel>> get users {
    return _userCollection.snapshots().map(_userListFromSnapshot);
  }

  // get user doc stream
  Stream<UserDataModel> get userData {
    return _userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}