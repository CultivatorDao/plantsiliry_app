import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:plantsility_app/services/storage.dart';

import 'package:plantsility_app/models/user.dart';
import 'package:plantsility_app/models/product.dart';
import 'package:plantsility_app/models/plant.dart';


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
  final StorageService _storageService = StorageService();

  // collection reference
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference _productCollection = FirebaseFirestore.instance.collection("products");
  final CollectionReference _plantCollection = FirebaseFirestore.instance.collection("plants");

  // update user data
  Future updateUserData(UserDataModel userData) async {
    return await _userCollection.doc(uid).set(
      {
        "username": userData.username,
        "profile_photo": userData.profilePhoto,
        "first_name": userData.firstName,
        "last_name": userData.lastName,
        "email": userData.email,
        "phone_number": userData.phoneNumber,
        "favorite": userData.favorite,
      }
    );
  }

  // product list from snapshot
  List<ProductModel> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
        return ProductModel(
          name: doc.get("name") ?? '',
          frontImage: doc.get("image"),
          description: doc.get("description"),
          originalPrice: doc.get("originalPrice"),
          hasDiscount: doc.get("hasDiscount"),
          discountPrice: doc.get("discountPrice"),
          images: doc.get("images"),
        );
      }
    ).toList();
  }

  // plant list from snapshot
  List<PlantModel> _plantListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
        return PlantModel(
          name: doc.get("name"),
          category: doc.get("category"),
          frontImage: "placeholder.png"
        );
      }
    ).toList();
  }

  // user data from snapshot
  UserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataModel(
      username: snapshot.get("username") ?? '',
      profilePhoto: snapshot.get("profile_photo"),
      firstName: snapshot.get("first_name") ?? '',
      lastName: snapshot.get("last_name") ?? '',
      email: snapshot.get("email") ?? '',
      phoneNumber: snapshot.get("phone_number") ?? '',
      favorite: snapshot.get("favorite") ?? const [],
    );
  }

  // get product stream
  Stream<List<ProductModel>> get products {
    return _productCollection.snapshots().map(_productListFromSnapshot);
  }

  // get plant stream
  Stream<List<PlantModel>> get plants {
    return _plantCollection.snapshots().map(_plantListFromSnapshot);
  }

  // get user doc stream
  Stream<UserDataModel> get userData {
    return _userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}