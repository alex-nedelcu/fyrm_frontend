import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/screens/profile_links/my_profile/components/my_profile_form.dart';

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
                  "Complete your profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(22),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("We recommend you set up an accurate description", textAlign: TextAlign.center),
                SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                const MyProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
