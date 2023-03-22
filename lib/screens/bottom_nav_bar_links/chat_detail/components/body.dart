import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/web_socket_provider.dart';
import 'package:provider/provider.dart';

import '../../../../models/conversation.dart';

class Body extends StatefulWidget {
  Conversation conversation;

  Body({super.key, required this.conversation});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    WebSocketProvider webSocketProvider = Provider.of<WebSocketProvider>(context);
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
    final messages = widget.conversation.messages.reversed;

    return SafeArea(
      child: Stack(
        children: <Widget>[
          ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final message = messages.elementAt(index);
                bool received = message.toId == connectedUserProvider.userId;

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: Align(
                    alignment: (received ? Alignment.topLeft : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: (received ? kSecondaryColor.withOpacity(0.15) : kPrimaryColor.withOpacity(0.95)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text(
                        message.content!,
                        style: TextStyle(fontSize: 16, color: received ? Colors.black87 : Colors.white),
                      ),
                    ),
                  ),
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 5),
              height: 70,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      autocorrect: false,
                      cursorColor: kSecondaryColor,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Write message...",
                        hintStyle: const TextStyle(color: Colors.black54),
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(
                          Icons.chat_bubble_outline_outlined,
                          color: kSecondaryColor,
                          size: 20,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor.withOpacity(0.1),
                      ),
                      textAlignVertical: TextAlignVertical.bottom,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: kPrimaryColor,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
