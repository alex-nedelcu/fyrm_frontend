import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/initiator_status_dto.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/initiator_status_enum.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/rent_connections_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/components/can_create.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/components/can_finalise.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/rent_connections/components/must_wait.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
    RentConnectionsProvider rentConnectionsProvider = Provider.of<RentConnectionsProvider>(context);

    return SafeArea(
      child: FutureBuilder(
        future: rentConnectionsProvider.getLatestInitiatorStatus(
          tokenType: connectedUserProvider.tokenType!,
          token: connectedUserProvider.token!,
          userId: connectedUserProvider.userId!,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final initiatorStatus = snapshot.requireData;
            rentConnectionsProvider.latestInitiatorStatus = initiatorStatus;
            return widgetByInitiatorStatus(initiatorStatus: rentConnectionsProvider.latestInitiatorStatus);
          }

          return SpinKitThreeInOut(color: kSecondaryColor.withOpacity(0.5));
        },
      ),
    );
  }

  Widget widgetByInitiatorStatus({required InitiatorStatusDto initiatorStatus}) {
    switch (initiatorStatus.status) {
      case InitiatorStatusEnum.canCreate:
        return const CanCreate();
      case InitiatorStatusEnum.canFinalise:
        return const CanFinalise();
      case InitiatorStatusEnum.mustWait:
        return const MustWait();
      case null:
        throw ArgumentError("Invalid $initiatorStatus");
    }
  }
}
