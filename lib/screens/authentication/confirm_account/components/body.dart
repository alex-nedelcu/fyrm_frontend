import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/authentication/authentication_service.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/helper/constants.dart';
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
  bool isToastShown = false;

  void onConfirm(String confirmationCode) async {
    int statusCode = await authenticationService.confirmAccountByEmail(
      email: widget.email,
      confirmationCode: confirmationCode,
    );

    if (ApiHelper.isSuccess(statusCode) && mounted) {
      Navigator.pushNamed(
        context,
        SuccessScreen.routeName,
        arguments: SuccessScreenArguments(text: "Account confirmed"),
      );
    } else {
      handleToast(statusCode: statusCode, message: kConfirmAccountFailure);
    }
  }

  void onResend() async {
    int statusCode = await authenticationService.sendConfirmationCodeByEmail(
        email: widget.email);

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
            child: Column(
              children: [
                SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                Text("Account confirmation", style: headingStyle),
                Text(
                  "We sent your code to ${widget.email}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                buildTimer(),
                OtpForm(onConfirmCallback: onConfirm),
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
}
