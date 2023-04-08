import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/web_socket_provider.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  int correspondentId;
  String correspondentUsername;

  Body({super.key, required this.correspondentId, required this.correspondentUsername});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  bool isLastReceived = false;

  @override
  void initState() {
    super.initState();
    textEditingController.value = TextEditingValue(
      text: "",
      selection: TextSelection.fromPosition(
        const TextPosition(offset: 0),
      ),
    );
  }

  void scrollDown({required double extra}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + extra,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    WebSocketProvider webSocketProvider = Provider.of<WebSocketProvider>(context);
    ConnectedUserProvider connectedUserProvider = Provider.of<ConnectedUserProvider>(context);
    final conversation = webSocketProvider.findConversationByCorrespondentId(
      correspondentId: widget.correspondentId,
      requesterId: connectedUserProvider.userId!,
      correspondentUsername: widget.correspondentUsername,
    );
    final messages = conversation.messages!.reversed;
    scrollDown(extra: 500);

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 75),
            child: ListView(
              controller: scrollController,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              children: messages.map(
                (message) {
                  bool received = message.toId == connectedUserProvider.userId;
                  bool displaySentAt = received != isLastReceived;
                  setState(() {
                    isLastReceived = received;
                  });

                  return Align(
                    alignment: (received ? Alignment.topLeft : Alignment.topRight),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: (displaySentAt) ? 6 : 4),
                      child: Column(
                        crossAxisAlignment: received ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                        children: [
                          if (displaySentAt)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              child: Text(
                                message.sentAtHoursMinutesFormat!,
                                style: TextStyle(fontSize: 12, color: kSecondaryColor.withOpacity(0.85)),
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:
                                  (received ? kSecondaryColor.withOpacity(0.15) : kPrimaryColor.withOpacity(0.95)),
                            ),
                            child: Text(
                              message.content!,
                              style: TextStyle(fontSize: 16, color: received ? Colors.black87 : Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
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
                      controller: textEditingController,
                      onChanged: (value) {
                        textEditingController.value = TextEditingValue(
                          text: value,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: value.length),
                          ),
                        );
                      },
                      maxLines: 1,
                      autocorrect: false,
                      cursorColor: kSecondaryColor,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                        isDense: true,
                        hintText: "Write message...",
                        hintStyle: const TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.chat_bubble_outline_outlined,
                          color: kSecondaryColor,
                          size: 22,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor.withOpacity(0.1),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: () {
                      final content = textEditingController.text.trim();

                      if (content.isNotEmpty) {
                        webSocketProvider.sendChatMessage(
                          content: content,
                          fromId: connectedUserProvider.userId!,
                          fromUsername: connectedUserProvider.username!,
                          toId: conversation.correspondentId,
                          toUsername: conversation.correspondentUsername,
                        );
                      }

                      setState(() {
                        textEditingController.value = TextEditingValue(
                          text: "",
                          selection: TextSelection.fromPosition(
                            const TextPosition(offset: 0),
                          ),
                        );
                      });

                      if (scrollController.hasClients) {
                        scrollDown(extra: 500);
                      }
                    },
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
