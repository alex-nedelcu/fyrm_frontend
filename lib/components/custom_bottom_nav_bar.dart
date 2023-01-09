import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyrm_frontend/screens/home/home_screen.dart';

import '../helper/constants.dart';
import '../helper/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key, required this.selectedMenu}) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/home.svg",
                  color: MenuState.home == selectedMenu ? kPrimaryColor : inActiveIconColor,
                ),
                onPressed: () {
                  if (selectedMenu != MenuState.home) {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/search.svg",
                  color: MenuState.rentConnection == selectedMenu ? kPrimaryColor : inActiveIconColor,
                ),
                onPressed: () {
                  // TODO: redirect to rent connections page page
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/chat.svg",
                  color: MenuState.chat == selectedMenu ? kPrimaryColor : inActiveIconColor,
                ),
                onPressed: () {
                  // TODO: redirect to chat page
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/notifications.svg",
                  color: MenuState.notifications == selectedMenu ? kPrimaryColor : inActiveIconColor,
                ),
                onPressed: () {
                  // TODO: redirect to notifications page
                },
              ),
            ],
          )),
    );
  }
}
