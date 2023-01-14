import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/screens/profile_links/manage_search_profile/manage_search_profile_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/profile_menu/components/profile_menu.dart';

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
                  "Manage your search profiles",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(22),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text("This is the control panel for your search profiles", textAlign: TextAlign.center),
                SizedBox(height: SizeConfiguration.screenHeight * 0.04),
                ProfileMenu(
                  text: "View existing profiles",
                  icon: "assets/icons/gift.svg",
                  press: () {},
                ),
                ProfileMenu(
                  text: "Create new profile",
                  icon: "assets/icons/plus.svg",
                  press: () => Navigator.pushNamed(
                    context,
                    ManageSearchProfileScreen.routeName,
                    arguments: ManageSearchProfileScreenArguments(isCreate: true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
