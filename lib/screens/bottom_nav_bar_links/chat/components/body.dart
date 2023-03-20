import 'package:flutter/material.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/web_socket_provider.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    WebSocketProvider webSocketProvider = Provider.of<WebSocketProvider>(context);
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: ListView.builder(
          itemCount: webSocketProvider.messages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                webSocketProvider.send(
                  content: "[REPLY] ${webSocketProvider.messages[index].content!}",
                  fromId: connectedUserProvider.userId!,
                  fromUsername: connectedUserProvider.username!,
                  toId: webSocketProvider.messages[index].fromId!,
                  toUsername: webSocketProvider.messages[index].fromUsername!,
                );
              },
              child: Text(
                webSocketProvider.messages[index].toJSON().toString(),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}
