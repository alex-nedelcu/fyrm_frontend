import 'package:flutter/material.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInScreenArguments? arguments =
        ModalRoute.of(context)!.settings.arguments as SignInScreenArguments?;
    bool hideBackButton = arguments?.fromAccountConfirmationScreen ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
        automaticallyImplyLeading: !hideBackButton,
      ),
      body: const Body(),
    );
  }
}

class SignInScreenArguments {
  late bool fromAccountConfirmationScreen;

  SignInScreenArguments({this.fromAccountConfirmationScreen = false});
}
