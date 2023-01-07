import 'dart:convert';

import 'package:fyrm_frontend/api/api_configuration.dart';
import 'package:fyrm_frontend/api/dto/signup_request_dto.dart';
import 'package:http/http.dart' as http;

class AuthenticationApi {
  Future<http.Response> signup(SignupRequestDto signupRequestDto) async {
    var endpoint =
        Uri.parse("${ApiConfiguration.baseUrl}/authentication/signup");
    var headers = ApiConfiguration.writeOperationHeaders;
    var body = jsonEncode(signupRequestDto.toJSON());

    var response = await http.post(endpoint, headers: headers, body: body);
    print("SIGN UP RESPONSE: ${(response.statusCode)}");
    return response;
  }
}
