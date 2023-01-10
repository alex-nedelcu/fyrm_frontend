import 'package:flutter/material.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:provider/provider.dart';

import '../../../helper/size_configuration.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
    print("Home screen token: ${connectedUserProvider.token}");

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
          ],
        ),
      ),
    );
  }
}
