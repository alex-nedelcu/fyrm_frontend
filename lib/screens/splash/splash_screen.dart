import 'package:flutter/material.dart';
import 'package:fyrm_frontend/screens/splash/components/body.dart';
import 'package:fyrm_frontend/size_configuration.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfiguration().init(context);
    return const Scaffold(body: Body());
  }
}
