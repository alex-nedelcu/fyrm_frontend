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
        SignupRequestDtoJsonFields.username: username,
        SignupRequestDtoJsonFields.email: email,
        SignupRequestDtoJsonFields.password: password,
        SignupRequestDtoJsonFields.role: role,
      };

  SignupRequestDto copy(
          {String? username, String? email, String? password, String? role}) =>
      SignupRequestDto(
          username: username ?? this.username,
          email: email ?? this.email,
          password: password ?? this.password,
          role: role ?? this.role);
}

class SignupRequestDtoJsonFields {
  static String username = 'username';
  static String email = 'email';
  static String password = 'password';
  static String role = 'role';
}
