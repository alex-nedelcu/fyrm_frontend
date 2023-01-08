import 'dart:convert';

import 'package:fyrm_frontend/api/dto/login_request_dto.dart';
import 'package:fyrm_frontend/api/dto/signup_request_dto.dart';
import 'package:fyrm_frontend/api/util/api_configuration.dart';
import 'package:fyrm_frontend/api/util/api_helper.dart';
import 'package:http/http.dart' as http;

class AuthenticationApi {
  Future<http.Response> signup(
      {required SignupRequestDto signupRequestDto}) async {
    var endpoint =
        Uri.parse("${ApiConfiguration.localBaseUrl}/authentication/signup");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(signupRequestDto.toJSON());

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> confirmAccount(
      {required int userId, required String confirmationCode}) async {
    var endpoint = Uri.parse(
        "${ApiConfiguration.localBaseUrl}/authentication/confirm?code=$confirmationCode");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(ApiHelper.intToJson("userId", userId));

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> resendConfirmationCode({required int userId}) async {
    var endpoint = Uri.parse(
        "${ApiConfiguration.localBaseUrl}/authentication/confirmationcode/resend");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(ApiHelper.intToJson("userId", userId));

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> login(
      {required LoginRequestDto loginRequestDto}) async {
    var endpoint =
        Uri.parse("${ApiConfiguration.localBaseUrl}/authentication/login");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(loginRequestDto.toJSON());

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }
}
