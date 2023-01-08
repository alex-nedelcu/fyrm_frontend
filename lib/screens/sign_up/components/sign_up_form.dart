import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/authentication/authentication_service.dart';
import 'package:fyrm_frontend/api/dto/signup_response_dto.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/components/custom_suffix_icon.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/components/form_error.dart';
import 'package:fyrm_frontend/helper/keyboard.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/screens/otp/otp_screen.dart';

import '../../../helper/constants.dart';

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
  String? email;
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
      );

      if (ApiHelper.is2xx(signupResponseDto.statusCode) && mounted) {
        Navigator.pushNamed(
          context,
          OtpScreen.routeName,
          arguments: OtpScreenArguments(signupResponse: signupResponseDto),
        );
      } else {
        handleInvalidSignupInformationToast(displayedError: signupResponseDto.message!);
      }
    } else {
      handleFormValidationToast();
    }
  }

  void handleInvalidSignupInformationToast({required String displayedError}) {
    if (isToastShown) {
      return;
    }

    isToastShown = true;

    showCustomToast(
      text: displayedError,
      context: context,
      backgroundColor: Colors.red.shade500,
    );

    isToastShown = false;
  }

  void handleFormValidationToast() {
    if (isToastShown) {
      return;
    }

    isToastShown = true;

    showCustomToast(
      text: "Please check form validation issues",
      context: context,
      backgroundColor: Colors.red.shade500,
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
          buildEmailField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordConfirmationField(),
          if (errors.isNotEmpty) SizedBox(height: SizeConfiguration.screenHeight * 0.02),
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

  TextFormField buildUsernameField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (value) => username = value,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMissingUsernameError);
        } else {
          addError(error: kMissingUsernameError);
        }

        if (usernameValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidUsernameError);
        } else {
          addError(error: kInvalidUsernameError);
        }

        username = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kMissingUsernameError);
        }

        if (!usernameValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidUsernameError);
        }

        return null;
      },
      decoration: const InputDecoration(
        labelText: "Username",
        hintText: "Enter your username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => email = value,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMissingEmailError);
        } else {
          addError(error: kMissingEmailError);
        }

        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        } else {
          addError(error: kInvalidEmailError);
        }

        email = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kMissingEmailError);
        }

        if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
        }

        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      obscureText: true,
      onSaved: (value) => password = value,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMissingPasswordError);
        } else {
          addError(error: kMissingPasswordError);
        }

        if (passwordValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidPasswordError);
        } else {
          addError(error: kInvalidPasswordError);
        }

        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kMissingPasswordError);
        }

        if (!passwordValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidPasswordError);
        }

        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordConfirmationField() {
    return TextFormField(
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
        labelText: "Password Confirmation",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
