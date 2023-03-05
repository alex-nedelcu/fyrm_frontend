import 'package:flutter/cupertino.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/rent_connections_provider.dart';
import 'package:provider/provider.dart';

class CanFinalise extends StatefulWidget {
  const CanFinalise({Key? key}) : super(key: key);

  @override
  State<CanFinalise> createState() => _CanFinaliseState();
}

class _CanFinaliseState extends State<CanFinalise> {
  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
    RentConnectionsProvider rentConnectionsProvider = Provider.of<RentConnectionsProvider>(context);

    return const SafeArea(
      child: Text("Can finalise"),
    );
  }
}
