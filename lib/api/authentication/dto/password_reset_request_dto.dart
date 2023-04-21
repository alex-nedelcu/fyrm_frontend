class PasswordResetRequestDto {
  late String email;
  late String password;

  PasswordResetRequestDto({required this.email, required this.password});

  Map<String, Object?> toJSON() => {
        emailJsonField: email,
        passwordJsonField: password,
      };

  static String get emailJsonField => "email";

  static String get passwordJsonField => "password";
}
