import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/models/conversation.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/web_socket_provider.dart';
import 'package:provider/provider.dart';

class ConversationCard extends StatefulWidget {
  Conversation conversation;

  ConversationCard({
    super.key,
    required this.conversation,
  });

  @override
  _ConversationCardState createState() => _ConversationCardState();
}

class _ConversationCardState extends State<ConversationCard> {
  @override
  Widget build(BuildContext context) {
    WebSocketProvider webSocketProvider = Provider.of<WebSocketProvider>(context);
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);

    return SafeArea(
        child: GestureDetector(
      onTap: () {
        webSocketProvider.send(
          content: "From chat",
          fromId: connectedUserProvider.userId!,
          fromUsername: connectedUserProvider.username!,
          toId: widget.conversation.correspondentId,
          toUsername: widget.conversation.correspondentUsername,
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 10, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.conversation.image),
                    maxRadius: 30,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.conversation.correspondentUsername,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            formatPreview(widget.conversation.preview),
                            style: const TextStyle(
                              fontSize: 15,
                              color: kSecondaryColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        formatDate(widget.conversation.date),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kSecondaryColor),
                      ),
                      if (belongsToCurrentYear(widget.conversation.date)) const SizedBox(height: 6),
                      if (belongsToCurrentYear(widget.conversation.date))
                        Text(
                          widget.conversation.time,
                          style:
                              const TextStyle(fontSize: 13, fontWeight: FontWeight.w300, color: kSecondaryColor),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  String formatPreview(String preview) {
    if (preview.length <= 20) {
      return preview;
    }

    return "${preview.substring(0, 21)}...";
  }

  // Date format is dd/MM/YYYY
  String formatDate(String date) {
    List<String> tokens = date.split("/");

    if (belongsToCurrentYear(date)) {
      return "${tokens[0]}/${tokens[1]}";
    } else {
      return tokens.last;
    }
  }

  bool belongsToCurrentYear(String date) {
    final currentYear = DateTime.now().year.toString();
    List<String> tokens = date.split("/");
    return tokens.last == currentYear;
  }
}
