import 'package:flutter/material.dart';
import 'package:fyrm_frontend/models/ArgumentsWithEmail.dart';

import 'components/body.dart';

class ConfirmAccountScreen extends StatelessWidget {
  static String routeName = "/confirm-account";

  const ConfirmAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ArgumentsWithEmail arguments =
        ModalRoute.of(context)!.settings.arguments as ArgumentsWithEmail;
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Body(email: arguments.email),
      ),
    );
  }
}
