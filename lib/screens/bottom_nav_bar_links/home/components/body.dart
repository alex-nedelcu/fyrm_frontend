import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/rent_connections_provider.dart';
import 'package:fyrm_frontend/providers/search_profile_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/rent_connections_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/manage_search_profile/manage_search_profile_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/my_profile/my_profile_screen.dart';
import 'package:provider/provider.dart';

import '../../../../helper/constants.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RentConnectionsProvider rentConnectionsProvider = Provider.of<RentConnectionsProvider>(context);
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
    SearchProfileProvider searchProfileProvider = Provider.of<SearchProfileProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          rentConnectionsProvider.loading
              ? buildPlaceholder(connectedUserProvider: connectedUserProvider)
              : buildCustomisedMessage(
                  connectedUserProvider: connectedUserProvider,
                  rentConnectionsProvider: rentConnectionsProvider,
                  searchProfileProvider: searchProfileProvider,
                  context: context,
                ),
        ],
      ),
    );
  }

  Widget buildPlaceholder({required ConnectedUserProvider connectedUserProvider}) {
    return SpinKitThreeInOut(color: kSecondaryColor.withOpacity(0.5));
  }

  Widget buildCustomisedMessage({
    required RentConnectionsProvider rentConnectionsProvider,
    required ConnectedUserProvider connectedUserProvider,
    required SearchProfileProvider searchProfileProvider,
    required BuildContext context,
  }) {
    bool isSearching = connectedUserProvider.isSearching!;
    bool hasSearchProfiles = searchProfileProvider.searchProfiles.isNotEmpty;

    if (!isSearching) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            Text(
              "Welcome, ${connectedUserProvider.username}!",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kSecondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "We noticed that you are currently not searching for a rent mate. This can mean two things:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kSecondaryColor,
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "• you already found your rent mate(s), thing makes us super happy",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kSecondaryColor,
                fontWeight: FontWeight.w200,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "• you forgot activating your “I am looking for a rent mate” option from settings",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kSecondaryColor,
                fontWeight: FontWeight.w200,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 65),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyProfileScreen.routeName);
              },
              child: const Text(
                "Go to settings",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      if (hasSearchProfiles) {
        int count = rentConnectionsProvider.activeRentConnectionCount;
        String text;
        if (count < 2) {
          text = "Unfortunately there is not too much activity matching your preferences at the moment.\n"
              "We suggest initiating a rent connection unless you already did it!";
        } else {
          text = "There are $count people that have an active rent connection at the moment. "
              "It's just a matter of time until you find your perfect rent mates.";
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              Text(
                "Welcome, ${connectedUserProvider.username}!",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RentConnectionsScreen.routeName);
                },
                child: const Text(
                  "Go to rent connections",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: [
              Text(
                "Welcome, ${connectedUserProvider.username}!",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Nice to see you here! We suggest you create a search profile and start looking for rent-mates.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ManageSearchProfileScreen.routeName,
                      arguments: ManageSearchProfileScreenArguments(isCreate: true));
                },
                child: const Text(
                  "Create search profile",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
  }
}
