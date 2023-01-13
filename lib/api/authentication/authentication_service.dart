import 'dart:convert';

import 'package:fyrm_frontend/api/authentication/authentication_api.dart';
import 'package:fyrm_frontend/api/dto/login_request_dto.dart';
import 'package:fyrm_frontend/api/dto/login_response_dto.dart';
import 'package:fyrm_frontend/api/dto/signup_response_dto.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:http/http.dart' as http;

import '../dto/signup_request_dto.dart';

class AuthenticationService {
  final AuthenticationApi authenticationApi = AuthenticationApi();

  Future<SignupResponseDto> signup({
    required String username,
    required String email,
    required String password,
    required String role,
  }) async {
    SignupRequestDto signupRequestDto =
        SignupRequestDto(username: username, email: email, password: password, role: role);

    http.Response response = await authenticationApi.signup(signupRequestDto: signupRequestDto);
    final decodedResponse = jsonDecode(response.body);
    return _buildSignupResponse(response.statusCode, decodedResponse);
  }

  SignupResponseDto _buildSignupResponse(int statusCode, dynamic decodedResponse) {
    SignupResponseDto signupResponseDto;

    if (ApiHelper.isSuccess(statusCode)) {
      signupResponseDto = SignupResponseDto(
        userId: decodedResponse[SignupResponseDto.userIdJsonField] as int,
        email: decodedResponse[SignupResponseDto.emailJsonField] as String,
        message: decodedResponse[SignupResponseDto.messageJsonField] as String,
        statusCode: statusCode,
      );
    } else {
      List<dynamic>? errors = decodedResponse[SignupResponseDto.errorMessagesJsonField] as List<dynamic>?;
      String? displayedError = errors?.first as String?;

      signupResponseDto = SignupResponseDto(statusCode: statusCode, message: displayedError);
    }

    return signupResponseDto;
  }

  Future<int> confirmAccount({required int userId, required String confirmationCode}) async {
    http.Response response = await authenticationApi.confirmAccount(
      userId: userId,
      confirmationCode: confirmationCode,
    );
    return response.statusCode;
  }

  Future<int> resendConfirmationCode({required int userId}) async {
    http.Response response = await authenticationApi.resendConfirmationCode(userId: userId);
    return response.statusCode;
  }

  Future<LoginResponseDto> login({required String username, required String password}) async {
    LoginRequestDto loginRequestDto = LoginRequestDto(username: username, password: password);

    http.Response response = await authenticationApi.login(loginRequestDto: loginRequestDto);
    final decodedResponse = jsonDecode(response.body);
    return _buildLoginResponse(response.statusCode, decodedResponse);
  }

  LoginResponseDto _buildLoginResponse(int statusCode, dynamic decodedResponse) {
    LoginResponseDto loginResponseDto;

    if (ApiHelper.isSuccess(statusCode)) {
      loginResponseDto = LoginResponseDto(
        userId: decodedResponse[LoginResponseDto.userIdJsonField] as int,
        token: decodedResponse[LoginResponseDto.tokenJsonField] as String,
        tokenType: decodedResponse[LoginResponseDto.tokenTypeJsonField] as String,
        email: decodedResponse[LoginResponseDto.emailJsonField] as String,
        username: decodedResponse[LoginResponseDto.usernameJsonField] as String,
        role: decodedResponse[LoginResponseDto.roleJsonField] as String,
        description: decodedResponse[LoginResponseDto.descriptionJsonField] as String?,
        isSearching: decodedResponse[LoginResponseDto.isSearchingJsonField] as bool,
        birthDate: decodedResponse[LoginResponseDto.birthDateJsonField] as String,
        statusCode: statusCode,
      );
    } else {
      List<dynamic>? errors = decodedResponse[LoginResponseDto.errorMessagesJsonField] as List<dynamic>?;
      String? displayedError = errors?.first as String?;

      loginResponseDto = LoginResponseDto(statusCode: statusCode, message: displayedError);
    }

    return loginResponseDto;
  }
}
