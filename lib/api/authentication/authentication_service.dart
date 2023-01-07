import 'package:fyrm_frontend/api/authentication/authentication_api.dart';

import '../dto/signup_request_dto.dart';

class AuthenticationService {
  final AuthenticationApi authenticationApi = AuthenticationApi();

  void signup({
    required String username,
    required String email,
    required String password,
    required String role,
  }) async {
    SignupRequestDto signupRequestDto = SignupRequestDto(
      username: username,
      email: email,
      password: password,
      role: role,
    );

    await authenticationApi.signup(signupRequestDto);
  }
}
