class UpdateUserDto {
  late int userId;
  late String? description;
  late bool isSearching;

  UpdateUserDto({
    required this.userId,
    required this.description,
    required this.isSearching,
  });

  Map<String, Object?> toJSON() => {
        userIdJsonField: userId,
        descriptionJsonField: description,
        isSearchingJsonField: isSearching,
      };

  UpdateUserDto copy({
    int? userId,
    String? description,
    bool? isSearching,
  }) =>
      UpdateUserDto(
        userId: userId ?? this.userId,
        description: description ?? this.description,
        isSearching: isSearching ?? this.isSearching,
      );

  static String get userIdJsonField => "userId";

  static String get descriptionJsonField => "description";

  static String get isSearchingJsonField => "isSearching";
}
