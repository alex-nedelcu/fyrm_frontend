import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/dto/signup_response_dto.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";

  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OtpScreenArguments arguments =
        ModalRoute.of(context)!.settings.arguments as OtpScreenArguments;
    return Scaffold(
      appBar: AppBar(title: const Text("Activation")),
      body: Body(signupResponse: arguments.signupResponse),
    );
  }
}

class OtpScreenArguments {
  final SignupResponseDto signupResponse;

  OtpScreenArguments({required this.signupResponse});
}
