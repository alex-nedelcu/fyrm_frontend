import 'dart:convert';

import 'package:fyrm_frontend/api/user/dto/update_user_dto.dart';
import 'package:http/http.dart' as http;

import '../util/api_configuration.dart';

class UserApi {
  Future<http.Response> updateUser({required UpdateUserDto updateUserDto}) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/users/${updateUserDto.userId}");
    var authorizationHeaderValue = "${updateUserDto.tokenType} ${updateUserDto.token}";
    var headers = ApiConfiguration.writeOperationHeadersWithAuthorization(authorizationHeaderValue);
    var body = jsonEncode(updateUserDto.toJSON());

    var response = await http.patch(endpoint, headers: headers, body: body);
    return response;
  }
}
