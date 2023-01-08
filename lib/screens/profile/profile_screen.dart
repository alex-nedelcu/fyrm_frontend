import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/custom_bottom_nav_bar.dart';
import 'package:fyrm_frontend/helper/enums.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfiguration().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: const Body(),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
