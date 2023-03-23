import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/web_socket_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/chat/components/conversation_card.dart';
import 'package:provider/provider.dart';

import '../../../../helper/size_configuration.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String filterText = "";

  @override
  Widget build(BuildContext context) {
    WebSocketProvider webSocketProvider = Provider.of<WebSocketProvider>(context);
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Text(
                  "Conversations",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(32),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    filterText = value;
                  });
                },
                cursorColor: kSecondaryColor,
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: const TextStyle(color: kSecondaryColor),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: kSecondaryColor,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: kSecondaryColor.withOpacity(0.1),
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: kSecondaryColor.withOpacity(0.1)),
                  ),
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              children: webSocketProvider
                  .messagesToConversations(requesterId: connectedUserProvider.userId!, filterUsername: filterText)
                  .map((conversation) => ConversationCard(conversation: conversation))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
