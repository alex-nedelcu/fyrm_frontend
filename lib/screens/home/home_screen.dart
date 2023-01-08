import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/dto/login_response_dto.dart';
import 'package:fyrm_frontend/components/custom_bottom_nav_bar.dart';

import '../../helper/enums.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenArguments arguments = ModalRoute.of(context)!.settings.arguments as HomeScreenArguments;
    return Scaffold(
      body: Body(loginResponse: arguments.loginResponse),
      bottomNavigationBar: const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

class HomeScreenArguments {
  final LoginResponseDto loginResponse;

  HomeScreenArguments({required this.loginResponse});
}
