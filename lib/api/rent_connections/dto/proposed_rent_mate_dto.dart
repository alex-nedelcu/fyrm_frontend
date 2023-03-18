class ProposedRentMateDto {
  late int? userId;
  late String? username;
  late String? email;
  late String? description;

  ProposedRentMateDto({
    required this.userId,
    required this.username,
    required this.email,
    required this.description,
  });

  Map<String, Object?> toJSON() => {
        userIdJsonField: userId,
        usernameJsonField: username,
        emailJsonField: email,
        descriptionJsonField: description,
      };

  ProposedRentMateDto copy({
    int? userId,
    String? username,
    String? email,
    String? description,
  }) =>
      ProposedRentMateDto(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        email: email ?? this.email,
        description: description ?? this.description,
      );

  static ProposedRentMateDto fromJSON(dynamic json) => ProposedRentMateDto(
        userId: json[userIdJsonField] as int?,
        username: json[usernameJsonField] as String?,
        email: json[emailJsonField] as String?,
        description: json[descriptionJsonField] as String?,
      );

  static String get userIdJsonField => "userId";

  static String get usernameJsonField => "username";

  static String get emailJsonField => "email";

  static String get descriptionJsonField => "description";
}
