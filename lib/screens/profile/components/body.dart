import 'package:flutter/material.dart';

import '../../../components/profile_picture.dart';
import 'profile_menu.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePicture(isUpdatable: true),
          const SizedBox(height: 30),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/user-white.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Manage Search Profiles",
            icon: "assets/icons/notifications.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/question-mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/log-out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
