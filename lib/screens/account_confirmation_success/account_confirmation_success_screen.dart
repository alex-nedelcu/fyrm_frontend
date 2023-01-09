import 'package:flutter/material.dart';

import 'components/body.dart';

class AccountConfirmationSuccessScreen extends StatelessWidget {
  static String routeName = "/account_confirmation_success";

  const AccountConfirmationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Success"),
      ),
      body: const Body(),
    );
  }
}
