import 'package:flutter/material.dart';

import 'components/body.dart';

class ManageSearchProfileScreen extends StatelessWidget {
  static String routeName = "/manage-search-profile";

  const ManageSearchProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageSearchProfileScreenArguments arguments =
        ModalRoute.of(context)!.settings.arguments as ManageSearchProfileScreenArguments;
    String title = arguments.isCreate ? "New search profile" : "Update search profile";

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Body(isCreate: arguments.isCreate),
      ),
    );
  }
}

class ManageSearchProfileScreenArguments {
  final bool isCreate;

  ManageSearchProfileScreenArguments({required this.isCreate});
}
