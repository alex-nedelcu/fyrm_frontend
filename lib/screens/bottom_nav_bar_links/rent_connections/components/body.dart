import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/rent_connections_provider.dart';
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
        builder: (context, snapshot) => snapshot.hasData
            ? Text(
                "${snapshot.requireData.status} ${snapshot.requireData.hoursToWait} ${snapshot.requireData.rentMateProposal?.proposedRentMates?.length}")
            : SpinKitThreeInOut(color: kSecondaryColor.withOpacity(0.5)),
      ),
    );
  }
}
