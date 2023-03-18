import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/rent_connections_screen.dart';

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
          "Rent connection finalised",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(24),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfiguration.screenWidth * 0.6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DefaultButton(
              text: "Initiate new",
              press: () {
                Navigator.pushNamed(
                  context,
                  RentConnectionsScreen.routeName,
                );
              },
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
