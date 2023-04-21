import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/authentication/authentication_service.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/components/custom_suffix_icon_as_image.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/components/form_error.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/keyboard.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/models/ArgumentsWithEmail.dart';

class EmailForm extends StatefulWidget {
  String redirectRoute;

  EmailForm({required this.redirectRoute, super.key});

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final AuthenticationService authenticationService = AuthenticationService();
  final List<String?> errors = [];
  final _formKey = GlobalKey<FormState>();
  bool isToastShown = false;
  String? email;

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

      int statusCode = await authenticationService.sendConfirmationCodeByEmail(
        email: email!,
      );

      if (ApiHelper.isSuccess(statusCode) && mounted) {
        Navigator.pushNamed(context, widget.redirectRoute,
            arguments: ArgumentsWithEmail(email: email!));
      } else {
        handleToast(
          statusCode: statusCode,
          message: kSendConfirmationCodeFailure,
        );
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
          buildEmailField(),
          if (errors.isNotEmpty)
            SizedBox(height: SizeConfiguration.screenHeight * 0.02),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: handleFormSubmission,
          ),
        ],
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
}
