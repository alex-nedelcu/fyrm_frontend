import 'package:flutter/material.dart';

import 'components/body.dart';

class SupportedUniversitiesScreen extends StatelessWidget {
  static String routeName = "/supported-universities";

  const SupportedUniversitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supported universities")),
      body: Body(),
    );
  }
}
