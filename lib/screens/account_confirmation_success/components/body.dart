import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/screens/sign_in/sign_in_screen.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfiguration.screenHeight * 0.04),
        Image.asset("assets/images/success.png", height: SizeConfiguration.screenHeight * 0.4),
        SizedBox(height: SizeConfiguration.screenHeight * 0.08),
        Text(
          "Account confirmed",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfiguration.screenWidth * 0.6,
          child: DefaultButton(
            text: "To login page",
            press: () {
              Navigator.pushNamed(
                context,
                SignInScreen.routeName,
                arguments: SignInScreenArguments(fromAccountConfirmationScreen: true),
              );
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
