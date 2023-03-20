import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fyrm_frontend/api/chat/dto/chat_message_dto.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class WebSocketProvider with ChangeNotifier {
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

  void onReceive(StompFrame frame) {
    var chatMessage = ChatMessageDto.fromJSON(jsonDecode(frame.body!));
    messages.add(chatMessage);
    notifyListeners();
    print("Received private message: ${chatMessage.toJSON()}");
  }

  void send(
      {required String content,
      required int fromId,
      required String fromUsername,
      required int toId,
      required String toUsername}) {
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
}
