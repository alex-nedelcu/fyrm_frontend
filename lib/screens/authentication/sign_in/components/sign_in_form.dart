import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/authentication/authentication_service.dart';
import 'package:fyrm_frontend/api/authentication/dto/login_response_dto.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/components/custom_suffix_icon.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/components/form_error.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/keyboard.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/web_socket_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/home/home_screen.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final AuthenticationService authenticationService = AuthenticationService();
  final List<String?> errors = [];
  final _formKey = GlobalKey<FormState>();
  bool isToastShown = false;
  String? username;
  String? password;
  bool? remember = false;

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

  void handleFormSubmission({
    required ConnectedUserProvider connectedUserProvider,
    required WebSocketProvider webSocketProvider,
  }) async {
    if (_formKey.currentState!.validate() && errors.isEmpty) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);

      LoginResponseDto loginResponseDto = await authenticationService.login(
        username: username!,
        password: password!,
      );
      int statusCode = loginResponseDto.statusCode;
      String? optionalMessage = loginResponseDto.message;

      if (ApiHelper.isSuccess(statusCode) && mounted) {
        Navigator.pushNamed(
          context,
          HomeScreen.routeName,
        );
        connectedUserProvider.connectedUserDetails = loginResponseDto;
        webSocketProvider.initializeStompClient(
            loginResponseDto.tokenType!, loginResponseDto.token!);
        await webSocketProvider.fetchMessages(
          userId: connectedUserProvider.userId!,
          token: connectedUserProvider.token!,
          tokenType: connectedUserProvider.tokenType!,
        );
        await webSocketProvider.fetchNotifications(
          userId: connectedUserProvider.userId!,
          token: connectedUserProvider.token!,
          tokenType: connectedUserProvider.tokenType!,
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
    ConnectedUserProvider connectedUserProvider =
        Provider.of<ConnectedUserProvider>(context);
    WebSocketProvider webSocketProvider =
        Provider.of<WebSocketProvider>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUsernameField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordField(),
          if (errors.isNotEmpty)
            SizedBox(height: SizeConfiguration.screenHeight * 0.02),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(15)),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () => {
                  // TODO: handle change password
                },
                child: const Text(
                  "Reset password",
                  style: TextStyle(
                      fontSize: 15, decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () => handleFormSubmission(
              connectedUserProvider: connectedUserProvider,
              webSocketProvider: webSocketProvider,
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildUsernameField() {
    return TextFormField(
      autocorrect: false,
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
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/user-grey.svg"),
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
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/lock.svg"),
      ),
    );
  }
}
