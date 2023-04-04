import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Column(
        children: webSocketProvider.notifications
            .map(
              (notif) => Text(notif.preview ?? "No preview"),
            )
            .toList(),
      ),
    );
  }
}
