import 'dart:convert';

import 'package:fyrm_frontend/api/authentication/authentication_api.dart';
import 'package:fyrm_frontend/api/authentication/dto/login_request_dto.dart';
import 'package:fyrm_frontend/api/authentication/dto/login_response_dto.dart';
import 'package:fyrm_frontend/api/authentication/dto/password_reset_request_dto.dart';
import 'package:fyrm_frontend/api/authentication/dto/password_reset_response_dto.dart';
import 'package:fyrm_frontend/api/authentication/dto/signup_request_dto.dart';
import 'package:fyrm_frontend/api/authentication/dto/signup_response_dto.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  final AuthenticationApi authenticationApi = AuthenticationApi();

  Future<SignupResponseDto> signup({
    required String username,
    required String email,
    required String password,
    required String role,
    required int birthYear,
    required String firstName,
    required String lastName,
    required String gender,
  }) async {
    SignupRequestDto signupRequestDto = SignupRequestDto(
      username: username,
      email: email,
      password: password,
      role: role,
      birthYear: birthYear,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
    );

    http.Response response = await authenticationApi.signup(
      signupRequestDto: signupRequestDto,
    );
    final decodedResponse = jsonDecode(response.body);
    return _buildSignupResponse(response.statusCode, decodedResponse);
  }

  SignupResponseDto _buildSignupResponse(
    int statusCode,
    dynamic decodedResponse,
  ) {
    SignupResponseDto signupResponseDto;

    if (ApiHelper.isSuccess(statusCode)) {
      signupResponseDto = SignupResponseDto(
        userId: decodedResponse[SignupResponseDto.userIdJsonField] as int,
        email: decodedResponse[SignupResponseDto.emailJsonField] as String,
        message: decodedResponse[SignupResponseDto.messageJsonField] as String,
        statusCode: statusCode,
      );
    } else {
      List<dynamic>? errors =
          decodedResponse[SignupResponseDto.errorMessagesJsonField]
              as List<dynamic>?;
      String? displayedError = errors?.first as String?;

      signupResponseDto =
          SignupResponseDto(statusCode: statusCode, message: displayedError);
    }

    return signupResponseDto;
  }

  Future<int> confirmAccountByUserId(
      {required int userId, required String confirmationCode}) async {
    http.Response response = await authenticationApi.confirmAccountByUserId(
      userId: userId,
      confirmationCode: confirmationCode,
    );
    return response.statusCode;
  }

  Future<int> confirmAccountByEmail(
      {required String email, required String confirmationCode}) async {
    http.Response response = await authenticationApi.confirmAccountByEmail(
      email: email,
      confirmationCode: confirmationCode,
    );
    return response.statusCode;
  }

  Future<PasswordResetResponseDto> resetPassword({
    required String confirmationCode,
    required String email,
    required String password,
  }) async {
    PasswordResetRequestDto resetPasswordRequestDto = PasswordResetRequestDto(
      email: email,
      password: password,
    );

    http.Response response = await authenticationApi.resetPassword(
      passwordResetRequestDto: resetPasswordRequestDto,
      confirmationCode: confirmationCode,
    );

    final decodedResponse = jsonDecode(response.body);
    return _buildPasswordResetResponse(response.statusCode, decodedResponse);
  }

  Future<int> sendConfirmationCodeByUserId({required int userId}) async {
    http.Response response =
        await authenticationApi.sendConfirmationCodeByUserId(userId: userId);
    return response.statusCode;
  }

  Future<int> sendConfirmationCodeByEmail({required String email}) async {
    http.Response response =
        await authenticationApi.sendConfirmationCodeByEmail(email: email);
    return response.statusCode;
  }

  Future<LoginResponseDto> login(
      {required String username, required String password}) async {
    LoginRequestDto loginRequestDto =
        LoginRequestDto(username: username, password: password);

    http.Response response =
        await authenticationApi.login(loginRequestDto: loginRequestDto);
    final decodedResponse = jsonDecode(response.body);
    return _buildLoginResponse(response.statusCode, decodedResponse);
  }

  PasswordResetResponseDto _buildPasswordResetResponse(
      int statusCode, dynamic decodedResponse) {
    PasswordResetResponseDto passwordResetResponseDto;

    if (ApiHelper.isSuccess(statusCode)) {
      passwordResetResponseDto =
          PasswordResetResponseDto(statusCode: statusCode);
    } else {
      List<dynamic>? errors =
          decodedResponse[PasswordResetResponseDto.errorMessagesJsonField]
              as List<dynamic>?;
      String? displayedError = errors?.first as String?;

      passwordResetResponseDto = PasswordResetResponseDto(
          statusCode: statusCode, message: displayedError);
    }

    return passwordResetResponseDto;
  }

  LoginResponseDto _buildLoginResponse(
      int statusCode, dynamic decodedResponse) {
    LoginResponseDto loginResponseDto;

    if (ApiHelper.isSuccess(statusCode)) {
      loginResponseDto = LoginResponseDto(
        userId: decodedResponse[LoginResponseDto.userIdJsonField] as int,
        token: decodedResponse[LoginResponseDto.tokenJsonField] as String,
        tokenType:
            decodedResponse[LoginResponseDto.tokenTypeJsonField] as String,
        email: decodedResponse[LoginResponseDto.emailJsonField] as String,
        firstName:
            decodedResponse[LoginResponseDto.firstNameJsonField] as String,
        lastName: decodedResponse[LoginResponseDto.lastNameJsonField] as String,
        gender: decodedResponse[LoginResponseDto.genderJsonField] as String,
        username: decodedResponse[LoginResponseDto.usernameJsonField] as String,
        role: decodedResponse[LoginResponseDto.roleJsonField] as String,
        university:
            decodedResponse[LoginResponseDto.universityJsonField] as String,
        description:
            decodedResponse[LoginResponseDto.descriptionJsonField] as String?,
        isSearching:
            decodedResponse[LoginResponseDto.isSearchingJsonField] as bool,
        birthYear: decodedResponse[LoginResponseDto.birthYearJsonField] as int,
        statusCode: statusCode,
      );
    } else {
      List<dynamic>? errors =
          decodedResponse[LoginResponseDto.errorMessagesJsonField]
              as List<dynamic>?;
      String? displayedError = errors?.first as String?;

      loginResponseDto =
          LoginResponseDto(statusCode: statusCode, message: displayedError);
    }

    return loginResponseDto;
  }
}
