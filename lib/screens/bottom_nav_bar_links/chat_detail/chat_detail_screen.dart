import 'package:flutter/material.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../models/conversation.dart';
import 'components/body.dart';

class ChatDetailScreen extends StatelessWidget {
  static String routeName = "/chat-detail";

  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ChatDetailScreenArguments;
    final conversation = arguments.conversation;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              CircleAvatar(
                maxRadius: 25,
                child: randomAvatar(
                  conversation.correspondentId.hashCode.toString(),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      conversation.correspondentUsername,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Body(
          correspondentId: conversation.correspondentId,
          correspondentUsername: conversation.correspondentUsername,
        ),
      ),
    );
  }
}

class ChatDetailScreenArguments {
  final Conversation conversation;

  ChatDetailScreenArguments({required this.conversation});
}
