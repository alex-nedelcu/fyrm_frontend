import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyrm_frontend/components/icon_button_with_counter.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/web_socket_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/chat/chat_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/home/home_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/notifications/notifications_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/rent_connections_screen.dart';
import 'package:provider/provider.dart';

import '../helper/constants.dart';
import '../helper/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  final MenuState? selectedMenu;

  const CustomBottomNavBar({Key? key, this.selectedMenu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
    WebSocketProvider webSocketProvider = Provider.of<WebSocketProvider>(context);

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
                  color: MenuState.rentConnections == selectedMenu ? kPrimaryColor : kInactiveIconColor,
                  height: 20.0,
                  width: 20.0,
                ),
                onPressed: () {
                  if (selectedMenu != MenuState.rentConnections) {
                    Navigator.pushNamed(context, RentConnectionsScreen.routeName);
                  }
                },
              ),
              IconButtonWithCounter(
                svgSrc: "assets/icons/chat.svg",
                color: MenuState.chat == selectedMenu ? kPrimaryColor : kInactiveIconColor,
                count: webSocketProvider.unreadChatCount(requesterId: connectedUserProvider.userId!),
                press: () {
                  if (selectedMenu != MenuState.chat) {
                    Navigator.pushNamed(context, ChatScreen.routeName);
                  }
                },
              ),
              IconButtonWithCounter(
                svgSrc: "assets/icons/notifications.svg",
                color: MenuState.notifications == selectedMenu ? kPrimaryColor : kInactiveIconColor,
                count: webSocketProvider.unreadNotificationCount(requesterId: connectedUserProvider.userId!),
                press: () {
                  if (selectedMenu != MenuState.notifications) {
                    Navigator.pushNamed(context, NotificationsScreen.routeName);
                  }
                },
              ),
            ],
          )),
    );
  }
}
