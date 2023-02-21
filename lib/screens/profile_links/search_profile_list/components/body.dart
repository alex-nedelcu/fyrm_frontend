import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/providers/search_profile_provider.dart';
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
          : buildSearchProfileList(searchProfileProvider),
    );
  }

  SizedBox buildSearchProfileList(SearchProfileProvider searchProfileProvider) {
    return SizedBox(
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
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
