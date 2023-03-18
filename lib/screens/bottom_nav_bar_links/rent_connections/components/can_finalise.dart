import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:fyrm_frontend/components/default_button.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/helper/toast.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/rent_connections_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/finalise_rent_connection_success/finalise_rent_connection_success_screen.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/components/proposed_rent_mates_list.dart';
import 'package:provider/provider.dart';

class CanFinalise extends StatefulWidget {
  const CanFinalise({Key? key}) : super(key: key);

  @override
  State<CanFinalise> createState() => _CanFinaliseState();
}

class _CanFinaliseState extends State<CanFinalise> {
  bool clickedFinalise = false;
  bool isToastShown = false;

  void handleToast({int? statusCode, String? message}) {
    if (isToastShown) {
      return;
    }

    isToastShown = true;

    showToastWrapper(
      context: context,
      statusCode: statusCode,
      optionalMessage: message,
    );

    isToastShown = false;
  }

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
    RentConnectionsProvider rentConnectionsProvider = Provider.of<RentConnectionsProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: ListView(
          children: [
            SizedBox(height: SizeConfiguration.screenHeight * 0.04),
            buildGreeting(username: connectedUserProvider.username!),
            SizedBox(height: SizeConfiguration.screenHeight * 0.02),
            buildInformativeText(),
            SizedBox(height: SizeConfiguration.screenHeight * 0.04),
            clickedFinalise
                ? buildFinaliseOptions(
                    connectedUserProvider: connectedUserProvider,
                    rentConnectionsProvider: rentConnectionsProvider,
                  )
                : buildFinaliseButton(),
            SizedBox(height: SizeConfiguration.screenHeight * 0.02),
            ProposedRentMatesList(
              rentMates: rentConnectionsProvider.latestInitiatorStatus.rentMateProposal!.proposedRentMates!,
            ),
            SizedBox(height: SizeConfiguration.screenHeight * 0.04),
          ],
        ),
      ),
    );
  }

  Widget buildFinaliseButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: DefaultButton(
        text: "I want to finalise",
        backgroundColor: kPrimaryColor,
        press: () {
          setState(() {
            clickedFinalise = true;
          });
        },
      ),
    );
  }

  Widget buildFinaliseOptions({
    required ConnectedUserProvider connectedUserProvider,
    required RentConnectionsProvider rentConnectionsProvider,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: DefaultButton(
            text: "Finalise as success",
            backgroundColor: kSuccessColor.withOpacity(0.90),
            press: () async {
              int statusCode = await rentConnectionsProvider.finaliseRentConnection(
                tokenType: connectedUserProvider.tokenType!,
                token: connectedUserProvider.token!,
                rentConnectionId: rentConnectionsProvider.latestInitiatorStatus.activeRentConnection!.id!,
                finalisation: "SUCCESS",
              );

              if (ApiHelper.isSuccess(statusCode) && mounted) {
                Navigator.pushReplacementNamed(context, FinaliseRentConnectionSuccessScreen.routeName);
              } else {
                handleToast(statusCode: statusCode, message: kConfirmAccountFailure);
              }
            },
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: DefaultButton(
            text: "Finalise as failure",
            backgroundColor: kFailureColor.withOpacity(0.90),
            press: () async {
              int statusCode = await rentConnectionsProvider.finaliseRentConnection(
                tokenType: connectedUserProvider.tokenType!,
                token: connectedUserProvider.token!,
                rentConnectionId: rentConnectionsProvider.latestInitiatorStatus.activeRentConnection!.id!,
                finalisation: "FAILURE",
              );

              if (ApiHelper.isSuccess(statusCode) && mounted) {
                Navigator.pushReplacementNamed(context, FinaliseRentConnectionSuccessScreen.routeName);
              }
            },
          ),
        ),
      ],
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

  Widget buildInformativeText() {
    return Text(
      "Find below the result of your latest rent connection. You can finalise it in order to create a new one.",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: getProportionateScreenWidth(17),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
