import 'package:flutter/material.dart';

import 'components/body.dart';

class SearchProfilesScreen extends StatelessWidget {
  static String routeName = "/search-profiles";

  const SearchProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Profiles")),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: const Body(),
      ),
    );
  }
}
