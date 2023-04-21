import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/enums.dart';
import 'package:fyrm_frontend/screens/authentication/confirm_account/confirm_account_screen.dart';
import 'package:fyrm_frontend/screens/authentication/password_reset/password_reset_screen.dart';

import 'components/body.dart';

class EmailPromptScreen extends StatelessWidget {
  static String routeName = "/email-prompt";

  const EmailPromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmailPromptScreenArguments arguments = ModalRoute.of(context)!
        .settings
        .arguments as EmailPromptScreenArguments;
    final flow = arguments.flow;
    final title = flow == EmailPromptFlow.confirmAccount
        ? "Confirm account"
        : "Reset password";
    final redirectRoute = flow == EmailPromptFlow.confirmAccount
        ? ConfirmAccountScreen.routeName
        : PasswordResetScreen.routeName;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Body(redirectRoute: redirectRoute),
      ),
    );
  }
}

class EmailPromptScreenArguments {
  late EmailPromptFlow flow;

  EmailPromptScreenArguments({required this.flow});
}
