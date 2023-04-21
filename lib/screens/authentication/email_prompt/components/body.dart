import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/screens/authentication/email_prompt/components/email_form.dart';

class Body extends StatelessWidget {
  String redirectRoute;

  Body({Key? key, required this.redirectRoute}) : super(key: key);

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
                SizedBox(height: SizeConfiguration.screenHeight * 0.02),
                Text(
                  "Fill in your email to continue",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: SizeConfiguration.screenHeight * 0.06),
                EmailForm(redirectRoute: redirectRoute),
                SizedBox(height: SizeConfiguration.screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
