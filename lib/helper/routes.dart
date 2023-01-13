import 'package:flutter/widgets.dart';
import 'package:fyrm_frontend/screens/authentication/account_confirmation_success/account_confirmation_success_screen.dart';
import 'package:fyrm_frontend/screens/authentication/otp/otp_screen.dart';
import 'package:fyrm_frontend/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:fyrm_frontend/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/chat/chat_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/home/home_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/notifications/notifications_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/rent_connections_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/profile/profile_screen.dart';
import 'package:fyrm_frontend/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  AccountConfirmationSuccessScreen.routeName: (context) => const AccountConfirmationSuccessScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  RentConnectionsScreen.routeName: (context) => const RentConnectionsScreen(),
  ChatScreen.routeName: (context) => const ChatScreen(),
  NotificationsScreen.routeName: (context) => const NotificationsScreen(),
};
