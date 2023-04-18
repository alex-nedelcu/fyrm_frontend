import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/proposed_rent_mate_dto.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/web_socket_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/chat_detail/chat_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../../../helper/constants.dart';

class RentMateCard extends StatefulWidget {
  final ProposedRentMateDto rentMate;

  const RentMateCard({required this.rentMate, Key? key}) : super(key: key);

  @override
  State<RentMateCard> createState() => _RentMateCardState();
}

class _RentMateCardState extends State<RentMateCard> {
  Duration duration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    WebSocketProvider webSocketProvider =
        Provider.of<WebSocketProvider>(context);
    ConnectedUserProvider connectedUserProvider =
        Provider.of<ConnectedUserProvider>(context);

    return InkWell(
      child: AnimatedContainer(
        duration: duration,
        margin: const EdgeInsets.only(top: kDefaultPadding * 4),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, -40),
              child: CircleAvatar(
                maxRadius: 35,
                child: randomAvatar(
                  widget.rentMate.userId.hashCode.toString(),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.rentMate.username!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    child: const Icon(Icons.chat,
                        color: kSecondaryColor, size: 26),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ChatDetailScreen.routeName,
                        arguments: ChatDetailScreenArguments(
                          conversation: webSocketProvider
                              .findConversationByCorrespondentId(
                                  correspondentId: widget.rentMate.userId!,
                                  correspondentUsername:
                                      widget.rentMate.username!,
                                  requesterId: connectedUserProvider.userId!),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 140,
              child: Text(
                widget.rentMate.description ??
                    "Unfortunately ${widget.rentMate.username} has not provided any description.\nBut we suggest you still get in touch because you never know.",
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
