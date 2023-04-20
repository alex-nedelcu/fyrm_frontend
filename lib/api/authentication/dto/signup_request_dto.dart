class SignupRequestDto {
  late String username;
  late String email;
  late String password;
  late String role;
  late int birthYear;
  late String firstName;
  late String lastName;
  late String gender;

  SignupRequestDto({
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.birthYear,
    required this.firstName,
    required this.lastName,
    required this.gender,
  });

  Map<String, Object?> toJSON() => {
        usernameJsonField: username,
        emailJsonField: email,
        passwordJsonField: password,
        roleJsonField: role,
        birthYearJsonField: birthYear,
        firstNameJsonField: firstName,
        lastNameJsonField: lastName,
        genderJsonField: gender,
      };

  static String get usernameJsonField => "username";

  static String get emailJsonField => "email";

  static String get passwordJsonField => "password";

  static String get roleJsonField => "role";

  static String get birthYearJsonField => "birthYear";

  static String get firstNameJsonField => "firstName";

  static String get lastNameJsonField => "lastName";

  static String get genderJsonField => "gender";
}
