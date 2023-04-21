import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/authentication/authentication_service.dart';
import 'package:fyrm_frontend/api/authentication/dto/password_reset_response_dto.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/components/custom_suffix_icon_as_image.dart';
import 'package:fyrm_frontend/components/form_error.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/keyboard.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/screens/authentication/otp/components/otp_form.dart';
import 'package:fyrm_frontend/screens/authentication/success/success_screen.dart';

class Body extends StatefulWidget {
  final String email;

  const Body({Key? key, required this.email}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthenticationService authenticationService = AuthenticationService();
  final List<String?> errors = [];
  final _formKey = GlobalKey<FormState>();
  bool isToastShown = false;
  String? password;
  String? passwordConfirmation;

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

  void handleFormSubmission(String confirmationCode) async {
    if (_formKey.currentState!.validate() && errors.isEmpty) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);

      PasswordResetResponseDto passwordResetResponseDto =
          await authenticationService.resetPassword(
              email: widget.email,
              password: password!,
              confirmationCode: confirmationCode);

      int statusCode = passwordResetResponseDto.statusCode;
      String? optionalMessage = passwordResetResponseDto.message;

      if (ApiHelper.isSuccess(statusCode) && mounted) {
        Navigator.pushNamed(
          context,
          SuccessScreen.routeName,
          arguments: SuccessScreenArguments(text: "Password was reset"),
        );
      } else {
        handleToast(statusCode: statusCode, message: optionalMessage);
      }
    } else {
      handleToast(message: kFormValidationErrorsMessage);
    }
  }

  void onResend() async {
    int statusCode = await authenticationService.sendConfirmationCodeByEmail(
      email: widget.email,
    );

    if (ApiHelper.isSuccess(statusCode)) {
      handleToast(
          statusCode: statusCode, message: kResendConfirmationCodeSuccess);
    } else {
      handleToast(
          statusCode: statusCode, message: kResendConfirmationCodeFailure);
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
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Reset your password", style: headingStyle),
                  SizedBox(height: SizeConfiguration.screenHeight * 0.01),
                  Text(
                    "We sent your code to ${widget.email}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  buildTimer(),
                  SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                  buildPasswordField(),
                  SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                  buildPasswordConfirmationField(),
                  if (errors.isNotEmpty)
                    SizedBox(height: SizeConfiguration.screenHeight * 0.02),
                  FormError(errors: errors),
                  OtpForm(onConfirmCallback: handleFormSubmission),
                  SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                  GestureDetector(
                    onTap: onResend,
                    child: const Text(
                      "Resend confirmation code",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This code will expire in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 29.99, end: 0.0),
          duration: const Duration(minutes: 30),
          builder: (_, dynamic value, child) => Text(
            "${value.toInt() + 1}",
            style: const TextStyle(color: kPrimaryColor),
          ),
        ),
        const Text(" minutes"),
      ],
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
