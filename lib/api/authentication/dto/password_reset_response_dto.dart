class PasswordResetResponseDto {
  String? message;
  late int statusCode;

  PasswordResetResponseDto({
    this.message,
    required this.statusCode,
  });

  static String get messageJsonField => "message";

  static String get errorMessagesJsonField => "messages";
}
