import 'package:fyrm_frontend/api/chat/dto/chat_message_dto.dart';

class Conversation {
  int correspondentId;
  String correspondentUsername;
  String preview;
  String date;
  String time;
  List<ChatMessageDto> messages;
  String image;

  Conversation({
    required this.correspondentId,
    required this.correspondentUsername,
    required this.preview,
    required this.date,
    required this.time,
    required this.messages,
    this.image = "assets/images/profile-image.png",
  });
}
