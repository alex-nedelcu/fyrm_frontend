import 'package:flutter/widgets.dart';
import 'package:fyrm_frontend/screens/authentication/confirm_account/confirm_account_screen.dart';
import 'package:fyrm_frontend/screens/authentication/email_prompt/email_prompt_screen.dart';
import 'package:fyrm_frontend/screens/authentication/otp/otp_screen.dart';
import 'package:fyrm_frontend/screens/authentication/password_reset/password_reset_screen.dart';
import 'package:fyrm_frontend/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:fyrm_frontend/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:fyrm_frontend/screens/authentication/success/success_screen.dart';
import 'package:fyrm_frontend/screens/authentication/supported_universities/supported_universities_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/chat/chat_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/chat_detail/chat_detail_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/finalise_rent_connection_success/finalise_rent_connection_success_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/home/home_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/notifications/notifications_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/rent_connections_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/manage_search_profile/manage_search_profile_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/my_profile/my_profile_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/profile_menu/profile_menu_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/search_profile_list/search_profile_list_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/search_profiles/search_profiles_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/statistics/statistics_screen.dart';
import 'package:fyrm_frontend/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  SuccessScreen.routeName: (context) => const SuccessScreen(),
  ProfileMenuScreen.routeName: (context) => const ProfileMenuScreen(),
  MyProfileScreen.routeName: (context) => const MyProfileScreen(),
  SearchProfilesScreen.routeName: (context) => const SearchProfilesScreen(),
  ManageSearchProfileScreen.routeName: (context) =>
      const ManageSearchProfileScreen(),
  SearchProfileListScreen.routeName: (context) =>
      const SearchProfileListScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  RentConnectionsScreen.routeName: (context) => const RentConnectionsScreen(),
  FinaliseRentConnectionSuccessScreen.routeName: (context) =>
      const FinaliseRentConnectionSuccessScreen(),
  ChatScreen.routeName: (context) => const ChatScreen(),
  NotificationsScreen.routeName: (context) => const NotificationsScreen(),
  ChatDetailScreen.routeName: (context) => const ChatDetailScreen(),
  StatisticsScreen.routeName: (context) => const StatisticsScreen(),
  SupportedUniversitiesScreen.routeName: (context) =>
      const SupportedUniversitiesScreen(),
  EmailPromptScreen.routeName: (context) => const EmailPromptScreen(),
  ConfirmAccountScreen.routeName: (context) => const ConfirmAccountScreen(),
  PasswordResetScreen.routeName: (context) => const PasswordResetScreen(),
};
