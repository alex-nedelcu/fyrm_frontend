class LoginResponseDto {
  int? userId;
  String? token;
  String? tokenType;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? role;
  String? description;
  bool? isSearching;
  int? birthYear;
  String? message;
  int statusCode;

  LoginResponseDto({
    this.userId,
    this.token,
    this.tokenType,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.role,
    this.description,
    this.isSearching,
    this.birthYear,
    this.message,
    required this.statusCode,
  });

  static String get userIdJsonField => "userId";

  static String get tokenJsonField => "token";

  static String get tokenTypeJsonField => "tokenType";

  static String get usernameJsonField => "username";

  static String get emailJsonField => "email";

  static String get firstNameJsonField => "firstName";

  static String get lastNameJsonField => "lastName";

  static String get genderJsonField => "gender";

  static String get roleJsonField => "role";

  static String get descriptionJsonField => "description";

  static String get isSearchingJsonField => "isSearching";

  static String get birthYearJsonField => "birthYear";

  static String get errorMessagesJsonField => "messages";
}
