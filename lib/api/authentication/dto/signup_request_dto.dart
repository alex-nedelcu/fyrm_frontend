class SignupRequestDto {
  late String username;
  late String email;
  late String password;
  late String role;

  SignupRequestDto(
      {required this.username,
      required this.email,
      required this.password,
      required this.role});

  Map<String, Object?> toJSON() => {
        usernameJsonField: username,
        emailJsonField: email,
        passwordJsonField: password,
        roleJsonField: role,
      };

  SignupRequestDto copy({
    String? username,
    String? email,
    String? password,
    String? role,
  }) =>
      SignupRequestDto(
          username: username ?? this.username,
          email: email ?? this.email,
          password: password ?? this.password,
          role: role ?? this.role);

  static String get usernameJsonField => "username";

  static String get emailJsonField => "email";

  static String get passwordJsonField => "password";

  static String get roleJsonField => "role";
}
