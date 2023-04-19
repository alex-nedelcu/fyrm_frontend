import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/rent_connections_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/components/proposed_rent_mates_list.dart';
import 'package:provider/provider.dart';

class MustWait extends StatefulWidget {
  const MustWait({Key? key}) : super(key: key);

  @override
  State<MustWait> createState() => _MustWaitState();
}

class _MustWaitState extends State<MustWait> {
  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider =
        Provider.of<ConnectedUserProvider>(context);
    RentConnectionsProvider rentConnectionsProvider =
        Provider.of<RentConnectionsProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: ListView(
          children: [
            SizedBox(height: SizeConfiguration.screenHeight * 0.04),
            buildGreeting(username: connectedUserProvider.username!),
            SizedBox(height: SizeConfiguration.screenHeight * 0.02),
            buildInformativeText(
                hoursToWait: rentConnectionsProvider
                    .latestInitiatorStatus.minutesToWait!),
            SizedBox(height: SizeConfiguration.screenHeight * 0.02),
            ProposedRentMatesList(
              rentMates: rentConnectionsProvider.latestInitiatorStatus
                      .rentMateProposal?.proposedRentMates ??
                  [],
            ),
            SizedBox(height: SizeConfiguration.screenHeight * 0.04),
          ],
        ),
      ),
    );
  }

  Widget buildGreeting({required String username}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hi, ",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(22),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          username,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: getProportionateScreenWidth(22),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "!",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(22),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildInformativeText({required num hoursToWait}) {
    return Text(
      "You can find below your latest rent connection details. "
      "Please wait $hoursToWait more hours until you can initiate a new one.",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: getProportionateScreenWidth(17),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
