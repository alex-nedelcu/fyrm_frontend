import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/providers/search_profile_provider.dart';
import 'package:fyrm_frontend/screens/profile_links/manage_search_profile/manage_search_profile_screen.dart';
import 'package:fyrm_frontend/screens/profile_links/search_profile_list/components/search_profile_card.dart';
import 'package:provider/provider.dart';

import '../../../../helper/constants.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    SearchProfileProvider searchProfileProvider = Provider.of<SearchProfileProvider>(context);

    return SafeArea(
      child: searchProfileProvider.loading
          ? SpinKitThreeInOut(color: kSecondaryColor.withOpacity(0.5))
          : buildSearchProfileList(searchProfileProvider, context),
    );
  }

  Widget buildSearchProfileList(SearchProfileProvider searchProfileProvider, BuildContext context) {
    return searchProfileProvider.searchProfiles.isNotEmpty
        ? SizedBox(
            height: SizeConfiguration.screenHeight,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 70),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: searchProfileProvider.searchProfiles.length,
                        itemBuilder: (context, index) => SearchProfileCard(
                          searchProfile: searchProfileProvider.searchProfiles[index],
                          index: index + 1,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              children: [
                const Text(
                  "You don't have any search profiles at the moment...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(44.0),
                  child: DefaultButton(
                    text: "Create",
                    press: () {
                      Navigator.pushNamed(
                        context,
                        ManageSearchProfileScreen.routeName,
                        arguments: ManageSearchProfileScreenArguments(isCreate: true),
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }
}
