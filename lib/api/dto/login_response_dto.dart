class LoginResponseDto {
  int? userId;
  String? token;
  String? tokenType;
  String? username;
  String? email;
  String? role;
  String? message;
  int statusCode;

  LoginResponseDto({
    this.userId,
    this.token,
    this.tokenType,
    this.username,
    this.email,
    this.role,
    this.message,
    required this.statusCode,
  });

  static String get userIdJsonField => "userId";

  static String get tokenJsonField => "token";

  static String get tokenTypeJsonField => "tokenType";

  static String get usernameJsonField => "username";

  static String get emailJsonField => "email";

  static String get roleJsonField => "role";

  static String get errorMessagesJsonField => "messages";
}
