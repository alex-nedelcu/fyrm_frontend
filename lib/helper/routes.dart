import 'package:flutter/widgets.dart';
import 'package:fyrm_frontend/screens/account_confirmation_success/account_confirmation_success_screen.dart';
import 'package:fyrm_frontend/screens/home/home_screen.dart';
import 'package:fyrm_frontend/screens/otp/otp_screen.dart';
import 'package:fyrm_frontend/screens/profile/profile_screen.dart';
import 'package:fyrm_frontend/screens/sign_in/sign_in_screen.dart';
import 'package:fyrm_frontend/screens/sign_up/sign_up_screen.dart';
import 'package:fyrm_frontend/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  AccountConfirmationSuccessScreen.routeName: (context) => const AccountConfirmationSuccessScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};
