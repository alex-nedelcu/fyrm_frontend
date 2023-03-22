import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fyrm_frontend/api/chat/chat_service.dart';
import 'package:fyrm_frontend/api/chat/dto/chat_message_dto.dart';
import 'package:fyrm_frontend/models/conversation.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class WebSocketProvider with ChangeNotifier {
  final ChatService chatService = ChatService();
  List<ChatMessageDto> messages = [];
  late StompClient _stompClient;

  void initializeStompClient(String tokenType, String token) {
    _stompClient = StompClient(
      config: StompConfig.SockJS(
        url: "http://localhost:8080/fyrm-ws",
        onConnect: onWebSocketConnect,
        stompConnectHeaders: {"Authorization": "$tokenType $token"},
        webSocketConnectHeaders: {"Authorization": "$tokenType $token"},
        onStompError: (dynamic error) => print(error.toString()),
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );

    _stompClient.activate();
  }

  @override
  void dispose() {
    super.dispose();
    _stompClient.deactivate();
  }

  void onWebSocketConnect(StompFrame frame) {
    _stompClient.subscribe(
      destination: "/user/queue/private-messages",
      callback: onReceive,
    );
  }

  // Receiver side
  void onReceive(StompFrame frame) {
    var chatMessage = ChatMessageDto.fromJSON(jsonDecode(frame.body!));
    messages.add(chatMessage);
    notifyListeners();
  }

  // Sender side
  void send({
    required String content,
    required int fromId,
    required String fromUsername,
    required int toId,
    required String toUsername,
  }) {
    var chatMessage = ChatMessageDto(
      content: content,
      fromId: fromId,
      fromUsername: fromUsername,
      toId: toId,
      toUsername: toUsername,
    );

    _stompClient.send(
      destination: "/fyrm/private-message",
      body: json.encode(chatMessage.toJSON()),
    );
  }

  void fetchMessages({required String tokenType, required String token, required int userId}) async {
    messages = await chatService.findAllMessagesByUser(tokenType: tokenType, token: token, userId: userId);
    notifyListeners();
  }

  List<Conversation> messagesToConversations({required int requesterId}) {
    Map<int, List<ChatMessageDto>> correspondentMessagesOrderedDescBySentAt = {};

    for (var message in messages.reversed) {
      int correspondentId = message.fromId == requesterId ? message.toId! : message.fromId!;

      correspondentMessagesOrderedDescBySentAt.update(
        correspondentId,
        (previous) => [...previous, message],
        ifAbsent: () => [message],
      );
    }

    return correspondentMessagesOrderedDescBySentAt.entries.map((entry) {
      final correspondentId = entry.key;
      final messages = entry.value;
      final latestMessage = messages.first;
      final correspondentUsername =
          (requesterId == latestMessage.fromId) ? latestMessage.toUsername! : latestMessage.fromUsername!;
      final preview = "${latestMessage.fromUsername}: ${latestMessage.content!}";
      final date = latestMessage.sentOnDayMonthYearFormat!;
      final time = latestMessage.sentAtHoursMinutesFormat!;

      return Conversation(
        correspondentId: correspondentId,
        correspondentUsername: correspondentUsername,
        preview: preview,
        date: date,
        time: time,
        messages: messages,
      );
    }).toList();
  }

  Conversation findConversationByCorrespondentId({required int correspondentId, required int requesterId}) {
    return messagesToConversations(requesterId: requesterId)
        .firstWhere((conversation) => conversation.correspondentId == correspondentId);
  }
}
