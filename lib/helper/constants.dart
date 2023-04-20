import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';

// Keys
const String mapsAndroidApiKey = "AIzaSyBCWtwbMosk9t9gDR2AMP1TPEAvSIPq9vA";
const String mapsiOSApiKey = "AIzaSyDrd4X3PAtzzfUcM8szVXyyUf1fWBmr4eo";

// Numeric constants
const int kDefaultProposalSize = 2;

// Regular expressions validators
final RegExp usernameValidatorRegExp =
    RegExp(r"^(?=[a-zA-Z0-9._]{3,32}$)(?!.*[_.]{2})[^_.].*[^_.]$");
final RegExp firstNameValidatorRegExp = RegExp(r"^[a-zA-Z\s-]{1,128}$");
final RegExp lastNameValidatorRegExp = RegExp(r"^[a-zA-Z\s-]{1,128}$");
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp weakPasswordValidatorRegExp = RegExp(r"^[a-zA-Z]{3,128}$");
final RegExp strongPasswordValidatorRegExp =
    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$");

// API error handling
const String kDefaultErrorMessage = "Something went wrong";
const String kDefaultSuccessMessage = "Operation successfully finished";
const String kExpectedErrorMessage =
    "You fell into an expected wrong behaviour";
const String kFormValidationErrorsMessage =
    "Please check form validation issues";
const String kBadCredentials = "Invalid username or password";
const String kResendConfirmationCodeSuccess = "Confirmation code was resent";
const String kResendConfirmationCodeFailure =
    "Confirmation code could not be resent";
const String kConfirmAccountSuccess = "Your account is confirmed";
const String kConfirmAccountFailure = "Confirmation code is invalid";
const String kFinaliseRentConnectionFailure =
    "Rent connection could not be finalised. Please retry.";
const String kRentLocationNotSelected = "Please pick the desired rent location";
const String kRentMateCountNotSelected =
    "Please select the desired number of rent mates";
const String kRentMateGenderNotSelected =
    "Please select the desired gender of rent mates";
const String kBedroomOptionNotSelected =
    "Please select the desired bedroom type";
const String kBathroomCountNotSelected =
    "Please select the desired number of bathrooms";
const String kSearchProfileCreateSuccess =
    "Search profile successfully created";
const String kSearchProfileUpdateSuccess =
    "Search profile successfully updated";
const String kSearchProfileDeleteSuccess =
    "Search profile successfully deleted";
Color kSuccessColor = Colors.green.shade500;
Color kFailureColor = Colors.red.shade500;

// Form error messages
const String kMissingBirthYearError = "Please fill in your birth year!";
const String kMissingUsernameError = "Please fill in your username!";
const String kMissingPasswordError = "Please fill in your password!";
const String kMissingGenderError = "Please fill in your gender!";
const String kInvalidUsernameError = "Username format is invalid!";
const String kInvalidFirstNameError = "First name is invalid!";
const String kInvalidLastNameError = "Last name is invalid!";
const String kInvalidEmailError = "Email format is invalid!";
const String kInvalidPasswordError = "Password format is invalid!";
const String kMissingPasswordConfirmationError =
    "Please fill in your password confirmation";
const String kNotMatchingPasswords = "Password and confirmation are different!";

// Design
final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kInfoColour = Colors.blueAccent;
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
const kDefaultPadding = 20.0;
