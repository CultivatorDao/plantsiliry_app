class UserModel {
  /// Custom user model to get rid of unnecessary information

  final String uid;

  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final List? favorite;

  UserModel({
    required this.uid,
    this.username = "no_one_knows",
    this.firstName = "No-one",
    this.lastName = "Knows",
    this.email = "knows@mail.com",
    this.phoneNumber = "123456789",
    this.favorite = const []
    });

}