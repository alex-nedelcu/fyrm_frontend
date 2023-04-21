import 'package:flutter/material.dart';

import 'components/body.dart';

class SuccessScreen extends StatelessWidget {
  static String routeName = "/success";

  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SuccessScreenArguments arguments =
        ModalRoute.of(context)!.settings.arguments as SuccessScreenArguments;

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Success"),
      ),
      body: Body(text: arguments.text),
    );
  }
}

class SuccessScreenArguments {
  late String text;

  SuccessScreenArguments({required this.text});
}
