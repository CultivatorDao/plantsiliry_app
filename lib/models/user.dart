class UserModel {
  /// Custom user model, contains user unique id.

  final String uid;

  UserModel({
    required this.uid,
    });

}


class UserDataModel {
  /// Custom user data model, contains all user information.

  final String? username;
  final String? profilePhoto;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final List? favorite;

  UserDataModel({
    this.username = "no_one_knows",
    this.profilePhoto = "placeholder.png",
    this.firstName = "No-one",
    this.lastName = "Knows",
    this.email = "knows@mail.com",
    this.phoneNumber = "123456789",
    this.favorite = const []
  });


}