import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/authentication/authentication_service.dart';
import 'package:fyrm_frontend/api/authentication/dto/signup_response_dto.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/components/custom_suffix_icon_as_image.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/components/form_error.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/keyboard.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/screens/authentication/otp/otp_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final AuthenticationService authenticationService = AuthenticationService();
  final List<String?> errors = [];
  final _formKey = GlobalKey<FormState>();
  bool isToastShown = false;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  int? birthYear;
  String? gender;
  String? password;
  String? passwordConfirmation;
  String? role = "ROLE_USER";

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void handleFormSubmission() async {
    if (_formKey.currentState!.validate() && errors.isEmpty) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);

      SignupResponseDto signupResponseDto = await authenticationService.signup(
        username: username!,
        email: email!,
        password: password!,
        role: role!,
        birthYear: birthYear!,
        firstName: firstName!,
        lastName: lastName!,
        gender: gender!,
      );
      int statusCode = signupResponseDto.statusCode;
      String? optionalMessage = signupResponseDto.message;

      if (ApiHelper.isSuccess(statusCode) && mounted) {
        Navigator.pushNamed(
          context,
          OtpScreen.routeName,
          arguments: OtpScreenArguments(signupResponse: signupResponseDto),
        );
      } else {
        handleToast(statusCode: statusCode, message: optionalMessage);
      }
    } else {
      handleToast(message: kFormValidationErrorsMessage);
    }
  }

  void handleToast({int? statusCode, String? message}) {
    if (isToastShown) {
      return;
    }

    isToastShown = true;

    showToastWrapper(
      context: context,
      statusCode: statusCode,
      optionalMessage: message,
    );

    isToastShown = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUsernameField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildFirstNameField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildBirthDateField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUserGenderField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordConfirmationField(),
          if (errors.isNotEmpty)
            SizedBox(height: SizeConfiguration.screenHeight * 0.02),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: handleFormSubmission,
          ),
        ],
      ),
    );
  }

  TextFormField buildFirstNameField() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.text,
      onSaved: (value) => firstName = value?.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kInvalidFirstNameError);
        } else {
          addError(error: kInvalidFirstNameError);
        }

        if (firstNameValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidFirstNameError);
        } else {
          addError(error: kInvalidFirstNameError);
        }

        firstName = value.trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kInvalidFirstNameError);
        }

        if (!firstNameValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidFirstNameError);
        }

        return null;
      },
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        labelText: "First name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/user-grey.svg"),
      ),
    );
  }

  TextFormField buildLastNameField() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.text,
      onSaved: (value) => lastName = value?.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kInvalidLastNameError);
        } else {
          addError(error: kInvalidLastNameError);
        }

        if (lastNameValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidLastNameError);
        } else {
          addError(error: kInvalidLastNameError);
        }

        lastName = value.trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kInvalidLastNameError);
        }

        if (!lastNameValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidLastNameError);
        }

        return null;
      },
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        labelText: "Last name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/user-grey.svg"),
      ),
    );
  }

  DropdownButtonFormField<String> buildUserGenderField() {
    return DropdownButtonFormField(
      isExpanded: false,
      iconSize: 0,
      value: gender,
      validator: (value) {
        if (value == null) {
          addError(error: kMissingGenderError);
        }

        return null;
      },
      menuMaxHeight: 150,
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        labelText: "Gender",
        hintText: "Select your gender",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/lightning.svg",
          color: kSecondaryColor,
        ),
      ),
      items: const [
        DropdownMenuItem(value: "male", child: Text("male")),
        DropdownMenuItem(value: "female", child: Text("female"))
      ],
      onSaved: (value) => gender = value,
      onChanged: (value) {
        if (value != null) {
          removeError(error: kMissingGenderError);
        } else {
          addError(error: kMissingGenderError);
        }

        gender = value;
      },
    );
  }

  DropdownButtonFormField<int> buildBirthDateField() {
    return DropdownButtonFormField(
      iconSize: 0,
      value: birthYear,
      validator: (value) {
        if (value == null) {
          addError(error: kMissingBirthYearError);
        }

        return null;
      },
      menuMaxHeight: 300,
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        labelText: "Birth year",
        hintText: "Select your birth year",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/gift.svg",
          color: kSecondaryColor,
        ),
      ),
      items: List.generate(
        DateTime.now().year - 1900 + 1,
        (index) {
          var year = DateTime.now().year - index;

          return DropdownMenuItem(
            alignment: Alignment.center,
            value: year,
            child: Text(
              year.toString(),
            ),
          );
        },
      ),
      onSaved: (value) => birthYear = value,
      onChanged: (value) {
        if (value != null) {
          removeError(error: kMissingBirthYearError);
        } else {
          addError(error: kMissingBirthYearError);
        }

        birthYear = value;
      },
    );
  }

  TextFormField buildUsernameField() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.text,
      onSaved: (value) => username = value?.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kInvalidUsernameError);
        } else {
          addError(error: kInvalidUsernameError);
        }

        if (usernameValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidUsernameError);
        } else {
          addError(error: kInvalidUsernameError);
        }

        username = value.trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kInvalidUsernameError);
        }

        if (!usernameValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidUsernameError);
        }

        return null;
      },
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        labelText: "Username",
        hintText: "Enter your username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/user-grey.svg"),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => email = value?.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kInvalidEmailError);
        } else {
          addError(error: kInvalidEmailError);
        }

        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        } else {
          addError(error: kInvalidEmailError);
        }

        email = value.trim();
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kInvalidEmailError);
        }

        if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
        }

        return null;
      },
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/envelope.svg"),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      onSaved: (value) => password = value,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kInvalidPasswordError);
        } else {
          addError(error: kInvalidPasswordError);
        }

        if (weakPasswordValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidPasswordError);
        } else {
          addError(error: kInvalidPasswordError);
        }

        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kInvalidPasswordError);
        }

        if (!weakPasswordValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidPasswordError);
        }

        return null;
      },
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordConfirmationField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      onSaved: (value) => passwordConfirmation = value,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMissingPasswordConfirmationError);
        } else {
          addError(error: kMissingPasswordConfirmationError);
        }

        if (value == password) {
          removeError(error: kNotMatchingPasswords);
        } else {
          addError(error: kNotMatchingPasswords);
        }

        passwordConfirmation = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kMissingPasswordConfirmationError);
        }

        if (value != password) {
          addError(error: kNotMatchingPasswords);
        }

        return null;
      },
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: kPrimaryColor),
        labelText: "Password Confirmation",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/lock.svg"),
      ),
    );
  }
}
