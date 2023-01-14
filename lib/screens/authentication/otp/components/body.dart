import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/authentication/authentication_service.dart';
import 'package:fyrm_frontend/api/authentication/dto/signup_response_dto.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/screens/authentication/account_confirmation_success/account_confirmation_success_screen.dart';

import 'otp_form.dart';

class Body extends StatefulWidget {
  final SignupResponseDto signupResponse;

  const Body({Key? key, required this.signupResponse}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthenticationService authenticationService = AuthenticationService();
  bool isToastShown = false;

  void onConfirm(String confirmationCode) async {
    int statusCode = await authenticationService.confirmAccount(
      userId: widget.signupResponse.userId!,
      confirmationCode: confirmationCode,
    );

    if (ApiHelper.isSuccess(statusCode) && mounted) {
      Navigator.pushNamed(
        context,
        AccountConfirmationSuccessScreen.routeName,
      );
    } else {
      handleToast(statusCode: statusCode, message: kConfirmAccountFailure);
    }
  }

  void onResend() async {
    int statusCode = await authenticationService.resendConfirmationCode(
      userId: widget.signupResponse.userId!,
    );
    if (ApiHelper.isSuccess(statusCode)) {
      handleToast(statusCode: statusCode, message: kResendConfirmationCodeSuccess);
    } else {
      handleToast(statusCode: statusCode, message: kResendConfirmationCodeFailure);
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
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                Text("Account confirmation", style: headingStyle),
                Text(
                  "We sent your code to ${widget.signupResponse.email!}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                buildTimer(),
                OtpForm(onConfirmCallback: onConfirm),
                SizedBox(height: SizeConfiguration.screenHeight * 0.1),
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
            "${value.toInt()}",
            style: const TextStyle(color: kPrimaryColor),
          ),
        ),
        const Text(" minutes"),
      ],
    );
  }
}
