class NotificationDto {
  int? id;
  String? preview;
  int? fromId;
  String? fromUsername;
  int? toId;
  String? toUsername;
  bool? isRead;
  String? sentOnDayMonthYearFormat;

  NotificationDto({
    this.id,
    this.preview,
    this.fromId,
    this.fromUsername,
    this.toId,
    this.toUsername,
    this.isRead,
    this.sentOnDayMonthYearFormat,
  });

  static NotificationDto fromJSON(dynamic json) => NotificationDto(
        id: json[idJsonField] as int?,
        preview: json[previewJsonField] as String?,
        fromId: json[fromIdJsonField] as int?,
        fromUsername: json[fromUsernameJsonField] as String?,
        toId: json[toIdJsonField] as int?,
        toUsername: json[toUsernameJsonField] as String?,
        isRead: json[isReadJsonField] == 1 ? true : false as bool?,
        sentOnDayMonthYearFormat: json[sentOnDayMonthYearFormatJsonField] as String?,
      );

  Map<String, Object?> toJSON() => {
        idJsonField: id,
        previewJsonField: preview,
        fromIdJsonField: fromId,
        fromUsernameJsonField: fromUsername,
        toIdJsonField: toId,
        toUsernameJsonField: toUsername,
        isReadJsonField: isRead,
        sentOnDayMonthYearFormatJsonField: sentOnDayMonthYearFormat,
      };

  static String get idJsonField => "id";

  static String get previewJsonField => "preview";

  static String get fromIdJsonField => "fromId";

  static String get fromUsernameJsonField => "fromUsername";

  static String get toIdJsonField => "toId";

  static String get toUsernameJsonField => "toUsername";

  static String get isReadJsonField => "isRead";

  static String get sentOnDayMonthYearFormatJsonField => "sentOnDayMonthYearFormat";
}
