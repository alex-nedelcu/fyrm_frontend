import 'package:flutter/material.dart';
import 'package:fyrm_frontend/size_configuration.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfiguration().init(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Log in")),
      body: const Body(),
    );
  }
}
