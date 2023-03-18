import 'package:flutter/material.dart';
import 'package:fyrm_frontend/components/custom_bottom_nav_bar.dart';
import 'package:fyrm_frontend/helper/enums.dart';
import 'package:fyrm_frontend/providers/rent_connections_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/connected_user_provider.dart';
import '../../../providers/search_profile_provider.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int activeRentConnectionCount;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RentConnectionsProvider rentConnectionsProvider =
          Provider.of<RentConnectionsProvider>(context, listen: false);
      ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context, listen: false);
      SearchProfileProvider searchProfileProvider = Provider.of<SearchProfileProvider>(context, listen: false);

      rentConnectionsProvider.fetchActiveRentConnectionCount(
        tokenType: connectedUserProvider.tokenType!,
        token: connectedUserProvider.token!,
      );
      searchProfileProvider.fetchSearchProfiles(
        tokenType: connectedUserProvider.tokenType!,
        token: connectedUserProvider.token!,
        userId: connectedUserProvider.userId!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
