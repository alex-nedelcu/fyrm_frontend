import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/custom_bottom_nav_bar.dart';
import 'package:fyrm_frontend/helper/enums.dart';

import 'components/body.dart';

class ChatScreen extends StatelessWidget {
  static String routeName = "/chat";

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: const Body(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.chat),
    );
  }
}
