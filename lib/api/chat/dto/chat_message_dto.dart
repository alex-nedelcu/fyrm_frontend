class ChatMessageDto {
  int? id;
  String? content;
  int? fromId;
  String? fromUsername;
  int? toId;
  String? toUsername;
  String? sentAt;

  ChatMessageDto({
    this.id,
    this.content,
    this.fromId,
    this.fromUsername,
    this.toId,
    this.toUsername,
    this.sentAt,
  });

  static ChatMessageDto fromJSON(dynamic json) => ChatMessageDto(
        id: json[idJsonField] as int?,
        content: json[contentJsonField] as String?,
        fromId: json[fromIdJsonField] as int?,
        fromUsername: json[fromUsernameJsonField] as String?,
        toId: json[toIdJsonField] as int?,
        toUsername: json[toUsernameJsonField] as String?,
      );

  Map<String, Object?> toJSON() => {
        idJsonField: id,
        contentJsonField: content,
        fromIdJsonField: fromId,
        fromUsernameJsonField: fromUsername,
        toIdJsonField: toId,
        toUsernameJsonField: toUsername,
      };

  static String get idJsonField => "id";

  static String get contentJsonField => "content";

  static String get fromIdJsonField => "fromId";

  static String get fromUsernameJsonField => "fromUsername";

  static String get toIdJsonField => "toId";

  static String get toUsernameJsonField => "toUsername";

  static String get sentAtJsonField => "sentAt";
}
