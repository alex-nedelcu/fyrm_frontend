import 'package:flutter/material.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInScreenArguments? arguments = ModalRoute.of(context)!.settings.arguments as SignInScreenArguments?;
    bool hideBackButton = arguments?.hideBackButton ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
        automaticallyImplyLeading: !hideBackButton,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: const Body(),
      ),
    );
  }
}

class SignInScreenArguments {
  late bool hideBackButton;

  SignInScreenArguments({this.hideBackButton = false});
}
