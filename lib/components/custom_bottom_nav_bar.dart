import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyrm_frontend/components/icon_button_with_counter.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../helper/constants.dart';
import '../helper/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  final MenuState? selectedMenu;

  const CustomBottomNavBar({Key? key, this.selectedMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);

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
                  color: MenuState.home == selectedMenu ? kPrimaryColor : kInactiveIconColor,
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
                  color: MenuState.rentConnection == selectedMenu ? kPrimaryColor : kInactiveIconColor,
                  height: 20.0,
                  width: 20.0,
                ),
                onPressed: () {
                  // TODO: redirect to rent connections page page
                },
              ),
              IconButtonWithCounter(
                svgSrc: "assets/icons/chat.svg",
                color: MenuState.chat == selectedMenu ? kPrimaryColor : kInactiveIconColor,
                count: connectedUserProvider.unreadChatCount,
                press: () {
                  // TODO: redirect to chat page
                },
              ),
              IconButtonWithCounter(
                svgSrc: "assets/icons/notifications.svg",
                color: MenuState.notifications == selectedMenu ? kPrimaryColor : kInactiveIconColor,
                count: connectedUserProvider.notificationCount,
                press: () {
                  // TODO: redirect to notifications page
                },
              ),
            ],
          )),
    );
  }
}
