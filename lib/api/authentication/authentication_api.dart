import 'dart:convert';

import 'package:fyrm_frontend/api/authentication/dto/login_request_dto.dart';
import 'package:fyrm_frontend/api/authentication/dto/password_reset_request_dto.dart';
import 'package:fyrm_frontend/api/authentication/dto/signup_request_dto.dart';
import 'package:fyrm_frontend/api/util/api_configuration.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:http/http.dart' as http;

class AuthenticationApi {
  Future<http.Response> signup(
      {required SignupRequestDto signupRequestDto}) async {
    var endpoint =
        Uri.parse("${ApiConfiguration.baseUrl}/authentication/signup");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(signupRequestDto.toJSON());

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> confirmAccountByUserId(
      {required int userId, required String confirmationCode}) async {
    var endpoint = Uri.parse(
        "${ApiConfiguration.baseUrl}/authentication/confirm?code=$confirmationCode");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(ApiHelper.intToJson("userId", userId));

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> confirmAccountByEmail(
      {required String email, required String confirmationCode}) async {
    var endpoint = Uri.parse(
        "${ApiConfiguration.baseUrl}/authentication/confirm-by-email?code=$confirmationCode");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(ApiHelper.stringToJson("email", email));

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> resetPassword({
    required PasswordResetRequestDto passwordResetRequestDto,
    required String confirmationCode,
  }) async {
    var endpoint = Uri.parse(
        "${ApiConfiguration.baseUrl}/authentication/reset-password?code=$confirmationCode");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(passwordResetRequestDto.toJSON());

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> sendConfirmationCodeByUserId(
      {required int userId}) async {
    var endpoint = Uri.parse(
        "${ApiConfiguration.baseUrl}/authentication/confirmationcode/resend");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(ApiHelper.intToJson("userId", userId));

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> sendConfirmationCodeByEmail({
    required String email,
  }) async {
    var endpoint = Uri.parse(
        "${ApiConfiguration.baseUrl}/authentication/confirmationcode/send-by-email");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(ApiHelper.stringToJson("email", email));

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> login(
      {required LoginRequestDto loginRequestDto}) async {
    var endpoint =
        Uri.parse("${ApiConfiguration.baseUrl}/authentication/login");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(loginRequestDto.toJSON());

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }
}
