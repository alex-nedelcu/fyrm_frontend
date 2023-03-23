import 'package:fyrm_frontend/api/chat/dto/chat_message_dto.dart';

class Conversation {
  int correspondentId;
  String correspondentUsername;
  List<ChatMessageDto> messages;
  String? preview;
  String? date;
  String? time;
  String image;

  Conversation({
    required this.correspondentId,
    required this.correspondentUsername,
    required this.messages,
    this.preview,
    this.date,
    this.time,
    this.image = "assets/images/profile-image.png",
  });
}
