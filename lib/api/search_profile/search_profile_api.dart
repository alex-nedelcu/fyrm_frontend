import 'dart:convert';

import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';
import 'package:fyrm_frontend/api/util/api_configuration.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

class SearchProfileApi {
  Future<http.Response> createSearchProfile({
    required SearchProfileDto searchProfileDto,
    required Authorization authorization,
  }) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/search-profiles");
    var authorizationHeaderValue = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.writeOperationHeadersWithAuthorization(authorizationHeaderValue);
    var body = jsonEncode(searchProfileDto.toJSON());

    var response = await http.post(endpoint, headers: headers, body: body);

    return response;
  }
}
