import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/profile_picture.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/my_profile/my_profile_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/search_profiles/search_profiles_screen.dart';
import 'package:provider/provider.dart';

import 'profile_menu.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePicture(isUpdatable: true),
          const SizedBox(height: 30),
          ProfileMenu(
            text: "My Profile",
            icon: "assets/icons/user-white.svg",
            press: () => Navigator.pushNamed(context, MyProfileScreen.routeName),
          ),
          ProfileMenu(
            text: "Manage Search Profiles",
            icon: "assets/icons/notifications.svg",
            press: () => Navigator.pushNamed(context, SearchProfilesScreen.routeName),
          ),
          ProfileMenu(
            text: "Statistics",
            icon: "assets/icons/game.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/log-out.svg",
            press: () {
              connectedUserProvider.connectedUserDetails = null;
              Navigator.pushNamed(
                context,
                SignInScreen.routeName,
                arguments: SignInScreenArguments(hideBackButton: true),
              );
            },
          ),
        ],
      ),
    );
  }
}
