import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';

// Regular expressions validators
final RegExp usernameValidatorRegExp = RegExp(r"^(?=[a-zA-Z0-9._]{3,32}$)(?!.*[_.]{2})[^_.].*[^_.]$");
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp passwordValidatorRegExp = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");

// API error handling
const String kDefaultErrorMessage = "Something went wrong";
const String kDefaultSuccessMessage = "Operation successfully finished";
const String kExpectedErrorMessage = "You fell into an expected wrong behaviour";
const String kFormValidationErrorsMessage = "Please check form validation issues";
const String kBadCredentials = "Invalid username or password";
const String kResendConfirmationCodeSuccess = "Confirmation code was resent";
const String kResendConfirmationCodeFailure = "Confirmation code could not be resent";
const String kConfirmAccountSuccess = "Your account is confirmed";
const String kConfirmAccountFailure = "Confirmation code is invalid. Try resending";
Color kSuccessColor = Colors.green.shade500;
Color kFailureColor = Colors.red.shade500;

// Form error messages
const String kMissingUsernameError = "Please fill in your username!";
const String kInvalidUsernameError = "Username format is invalid!";
const String kMissingEmailError = "Please fill in your email!";
const String kInvalidEmailError = "Email format is invalid!";
const String kMissingPasswordError = "Please fill in your password";
const String kInvalidPasswordError = "Password format is invalid!";
const String kMissingPasswordConfirmationError = "Please fill in your password confirmation";
const String kNotMatchingPasswords = "Password and confirmation are different!";

// Design
final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kInactiveIconColor = Color(0xFFB6B6B6);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const kAnimationDuration = Duration(milliseconds: 200);
const defaultDuration = Duration(milliseconds: 250);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

// Dimensions
const kUniversalLayoutHeight = 812.0;
const kUniversalLayoutWidth = 375.0;
