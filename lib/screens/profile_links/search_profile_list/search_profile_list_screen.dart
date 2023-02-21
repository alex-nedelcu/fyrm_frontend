import 'package:flutter/material.dart';

import 'components/body.dart';

class SearchProfileListScreen extends StatelessWidget {
  static String routeName = "/search-profile-list";

  const SearchProfileListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Search Profiles")),
      body: const Body(),
    );
  }
}
