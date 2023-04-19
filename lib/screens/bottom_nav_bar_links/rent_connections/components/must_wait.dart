import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/rent_connections_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/components/proposed_rent_mates_list.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/rent_connections_screen.dart';
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
                minutesToWait: rentConnectionsProvider
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

  Widget buildInformativeText({required num minutesToWait}) {
    return TweenAnimationBuilder(
      tween: Tween(begin: minutesToWait.toDouble(), end: 0.0),
      duration: Duration(minutes: minutesToWait.toInt()),
      builder: (_, dynamic value, child) {
        if (value as double <= 0) {
          return Column(
            children: [
              Text(
                "The time limit for creating a new rent connection has expired. Please refresh the page to progress further.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(17),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RentConnectionsScreen.routeName);
                },
                child: const Text(
                  "Refresh",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        }

        return Text(
          "You can find below your latest rent connection details. Please wait ${value.toInt() + 1} minute${(value.toInt() + 1) == 1 ? "" : "s"} until you can initiate a new one.",
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenWidth(17),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
