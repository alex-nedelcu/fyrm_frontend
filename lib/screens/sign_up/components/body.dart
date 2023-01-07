import 'package:flutter/material.dart';
import 'package:fyrm_frontend/constants.dart';
import 'package:fyrm_frontend/size_configuration.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

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
                SizedBox(height: SizeConfiguration.screenHeight * 0.04), // 4%
                Text("Register account", style: headingStyle),
                const Text(
                  "Use your official student\n email address",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfiguration.screenHeight * 0.08),
                const SignUpForm(),
                SizedBox(height: SizeConfiguration.screenHeight * 0.08),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
