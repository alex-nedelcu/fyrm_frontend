import 'dart:convert';

import 'package:fyrm_frontend/api/chat/dto/chat_message_dto.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

import 'chat_api.dart';

class ChatService {
  final ChatApi chatApi = ChatApi();

  Future<List<ChatMessageDto>> findAllMessagesByUser({
    required String tokenType,
    required String token,
    required int userId,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    http.Response response = await chatApi.findAllMessagesByUser(
      authorization: authorization,
      userId: userId,
    );

    final messages = jsonDecode(response.body)['messages'] as List<dynamic>;
    return List<ChatMessageDto>.from(messages.map((json) => ChatMessageDto.fromJSON(json)));
  }
}
