import "dart:io";

import "package:firebase_storage/firebase_storage.dart";


class StorageService {

  final FirebaseStorage _storage = FirebaseStorage.instance;


  // get storage root directory reference
  Reference get reference {
    return _storage.ref().child("images");
  }

  // get reference of given directory
  Reference getDirectoryOf(String directory) {
    return reference.child(directory);
  }

  // put image to storage
  // TODO: handle on task upload process
  Future<String> uploadImage(String path, String uid, {String dir = "profile"}) async {
    File file = File(path);
    String fileName = file.uri.pathSegments.last;
    Reference fileReference = getDirectoryOf(dir).child("$uid/$fileName");
    fileReference.putFile(file);

    return fileReference.fullPath.replaceAll("images", "");
  }

  // get image from storage
  Future<String> downloadImage(String name) async {
    Reference ref = reference.child(name);
    return await ref.getDownloadURL();
  }

}