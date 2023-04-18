import 'package:flutter/material.dart';
import 'package:fyrm_frontend/api/notification/dto/notification_dto.dart';
import 'package:fyrm_frontend/helper/constants.dart';
import 'package:fyrm_frontend/models/conversation.dart';
import 'package:fyrm_frontend/providers/connected_user_provider.dart';
import 'package:fyrm_frontend/providers/web_socket_provider.dart';
import 'package:fyrm_frontend/screens/bottom_nav_bar_links/chat_detail/chat_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

class NotificationCard extends StatefulWidget {
  NotificationDto notification;

  NotificationCard({super.key, required this.notification});

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    WebSocketProvider webSocketProvider =
        Provider.of<WebSocketProvider>(context);
    ConnectedUserProvider connectedUserProvider =
        Provider.of<ConnectedUserProvider>(context);

    return SafeArea(
        child: GestureDetector(
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        Navigator.pushNamed(
          context,
          ChatDetailScreen.routeName,
          arguments: ChatDetailScreenArguments(
            conversation: Conversation(
                correspondentId: widget.notification.fromId!,
                correspondentUsername: widget.notification.fromUsername!),
          ),
        );
        await webSocketProvider.markNotificationAsRead(
          tokenType: connectedUserProvider.tokenType!,
          token: connectedUserProvider.token!,
          userId: connectedUserProvider.userId!,
          notificationId: widget.notification.id!,
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 22, right: 28, top: 15, bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                        ),
                        color: widget.notification.isRead!
                            ? kSecondaryColor.withOpacity(0.15)
                            : kPrimaryColor.withOpacity(0.8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            widget.notification.preview!,
                            style: TextStyle(
                              fontSize: 18,
                              color: widget.notification.isRead!
                                  ? Colors.black.withOpacity(0.55)
                                  : Colors.black.withOpacity(0.75),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.notification.sentOnDayMonthYearFormat!,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: widget.notification.isRead!
                                        ? kSecondaryColor
                                        : Colors.black.withOpacity(0.45)),
                              ),
                              const SizedBox(width: 5),
                              CircleAvatar(
                                maxRadius: 18,
                                child: randomAvatar(
                                  widget.notification.fromId.hashCode
                                      .toString(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
