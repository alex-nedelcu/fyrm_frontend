import 'package:flutter/cupertino.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/rent_connections_provider.dart';
import 'package:provider/provider.dart';

class CanCreate extends StatefulWidget {
  const CanCreate({Key? key}) : super(key: key);

  @override
  State<CanCreate> createState() => _CanCreateState();
}

class _CanCreateState extends State<CanCreate> {
  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
    RentConnectionsProvider rentConnectionsProvider = Provider.of<RentConnectionsProvider>(context);

    return const SafeArea(
      child: Text("Can create"),
    );
  }
}
