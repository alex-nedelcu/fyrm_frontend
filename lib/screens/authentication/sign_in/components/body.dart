import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/no_account_text.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';

import 'sign_in_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

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
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("Sign in with your username and password", textAlign: TextAlign.center),
                SizedBox(height: SizeConfiguration.screenHeight * 0.08),
                const SignInForm(),
                SizedBox(height: SizeConfiguration.screenHeight * 0.08),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
