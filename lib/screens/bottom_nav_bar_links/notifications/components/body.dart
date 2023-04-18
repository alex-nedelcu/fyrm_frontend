import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/helper/size_configuration.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/web_socket_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/notifications/components/notification_card.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    WebSocketProvider webSocketProvider =
        Provider.of<WebSocketProvider>(context);
    ConnectedUserProvider connectedUserProvider =
        Provider.of<ConnectedUserProvider>(context);

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(30),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    if (webSocketProvider.notifications
                        .any((element) => !element.isRead!))
                      GestureDetector(
                        onTap: () {
                          webSocketProvider.markAllNotificationsAsRead(
                            tokenType: connectedUserProvider.tokenType!,
                            token: connectedUserProvider.token!,
                            userId: connectedUserProvider.userId!,
                          );
                        },
                        child: Text(
                          "Mark all as read",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            ListView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10),
              children: webSocketProvider.notifications.reversed
                  .map((notification) =>
                      NotificationCard(notification: notification))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
