class UpdateUserDto {
  late int userId;
  late String token;
  late String tokenType;
  late String? description;
  late bool isSearching;

  UpdateUserDto({
    required this.userId,
    required this.token,
    required this.tokenType,
    required this.description,
    required this.isSearching,
  });

  Map<String, Object?> toJSON() => {
        userIdJsonField: userId,
        tokenJsonField: token,
        tokenTypeJsonField: tokenType,
        descriptionJsonField: description,
        isSearchingJsonField: isSearching,
      };

  UpdateUserDto copy({
    int? userId,
    String? token,
    String? tokenType,
    String? description,
    bool? isSearching,
  }) =>
      UpdateUserDto(
        userId: userId ?? this.userId,
        token: token ?? this.token,
        tokenType: tokenType ?? this.tokenType,
        description: description ?? this.description,
        isSearching: isSearching ?? this.isSearching,
      );

  static String get userIdJsonField => "userId";

  static String get tokenJsonField => "token";

  static String get tokenTypeJsonField => "tokenType";

  static String get descriptionJsonField => "description";

  static String get isSearchingJsonField => "isSearching";
}
