class SignupResponseDto {
  int? userId;
  String? message;
  String? email;
  late int statusCode;

  SignupResponseDto({
    this.userId,
    this.message,
    this.email,
    required this.statusCode,
  });

  static String get userIdJsonField => "userId";

  static String get messageJsonField => "message";

  static String get emailJsonField => "email";
}
