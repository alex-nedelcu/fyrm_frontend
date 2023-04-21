class LoginRequestDto {
  late String username;
  late String password;

  LoginRequestDto({required this.username, required this.password});

  Map<String, Object?> toJSON() => {
        usernameJsonField: username,
        passwordJsonField: password,
      };

  static String get usernameJsonField => "username";

  static String get passwordJsonField => "password";
}
