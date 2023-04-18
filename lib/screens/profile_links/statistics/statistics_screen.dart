import 'package:flutter/material.dart';

import 'components/body.dart';

class StatisticsScreen extends StatelessWidget {
  static String routeName = "/statistics";

  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statistics")),
      body: const Body(),
    );
  }
}
