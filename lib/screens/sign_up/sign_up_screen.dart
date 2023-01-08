import 'package:flutter/material.dart';
import 'package:fyrm_frontend/size_configuration.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfiguration().init(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Registration")),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: const Body(),
      ),
    );
  }
}
