import 'package:flutter/material.dart';

import 'components/body.dart';

class MyProfileScreen extends StatelessWidget {
  static String routeName = "/my-profile";

  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: const Body(),
      ),
    );
  }
}
