import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/custom_bottom_nav_bar.dart';
import 'package:fyrm_frontend/helper/enums.dart';

import 'components/body.dart';

class FinaliseRentConnectionSuccessScreen extends StatelessWidget {
  static String routeName = "/finalise-rent-connection-success";

  const FinaliseRentConnectionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("Finalised with success"),
      ),
      body: const Body(),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.rentConnections),
    );
  }
}
