import 'package:email_validator/email_validator.dart';


class Validator {
  /// Custom validator class.
  ///
  /// Use Validator.validate to validate string.


  Validator(
      {
        this.onEmptyHelperMessage = "Can't be empty",
        this.onLengthErrorHelperMessage = "Must be at least 8 characters",
        this.onEmailErrorHelperMessage = "Not valid email",
        this.isEmail = false,
        this.minLength = 8,
      }
      );


  /// [onEmptyHelperMessage] Show message if string is empty.
  final String? onEmptyHelperMessage;
  /// [onLengthErrorHelperMessage] Show message if string is shorter than expected.
  final String? onLengthErrorHelperMessage;
  /// [onEmailErrorHelperMessage] Show message if string contains not valid email, works only if [isEmail] set true.
  final String? onEmailErrorHelperMessage;
  /// [isEmail] Enables email validation.
  final bool? isEmail;
  /// [minLength] Minimum string length.
  final int? minLength;


  /// Validate string value.
  String? validate(String? value) {
    if (value!.isEmpty) {
      return onEmptyHelperMessage;
    }
    else if (minLength! > value.length) {
      return onLengthErrorHelperMessage;
    }
    else if (!(EmailValidator.validate(value)) && isEmail!) {
      return onEmailErrorHelperMessage;
    }
    else {
      return null;
    }
  }

}