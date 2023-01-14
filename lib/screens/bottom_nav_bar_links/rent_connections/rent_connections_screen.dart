import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/custom_bottom_nav_bar.dart';
import 'package:fyrm_frontend/helper/enums.dart';

import 'components/body.dart';

class RentConnectionsScreen extends StatelessWidget {
  static String routeName = "/rent-connections";

  const RentConnectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.rentConnections),
    );
  }
}
