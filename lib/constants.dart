import 'package:flutter/material.dart';
import 'package:fyrm_frontend/size_configuration.dart';

// Colors and styles
const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const kAnimationDuration = Duration(milliseconds: 200);
const defaultDuration = Duration(milliseconds: 250);

// Regular expressions
final RegExp usernameValidatorRegExp =
    RegExp(r"^(?=[a-zA-Z0-9._]{3,32}$)(?!.*[_.]{2})[^_.].*[^_.]$");
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp passwordValidatorRegExp =
    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");

// Form errors
const String kMissingUsernameError = "Please fill in your username!";
const String kInvalidUsernameError = "Username format is invalid!";
const String kMissingEmailError = "Please fill in your email!";
const String kInvalidEmailError = "Email format is invalid!";
const String kMissingPasswordError = "Please fill in your password";
const String kInvalidPasswordError = "Password format is invalid!";
const String kMissingPasswordConfirmationError =
    "Please fill in your password confirmation";
const String kNotMatchingPasswords = "Password and confirmation are different!";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

// Dimensions
const kUniversalLayoutHeight = 812.0;
const kUniversalLayoutWidth = 375.0;
