import 'dart:convert';

import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';
import 'package:fyrm_frontend/api/util/api_configuration.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

class SearchProfileApi {
  Future<http.Response> create({
    required SearchProfileDto searchProfileDto,
    required Authorization authorization,
  }) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/search-profiles");
    var authorizationHeader = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.headersWithAuthorization(authorizationHeader);
    var body = jsonEncode(searchProfileDto.toJSON());

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> findAllByUserId({required Authorization authorization, required int userId}) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/users/$userId/search-profiles");
    var authorizationHeader = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.headersWithAuthorization(authorizationHeader);

    var response = await http.get(endpoint, headers: headers);
    return response;
  }

  Future<http.Response> delete({required Authorization authorization, required int id}) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/search-profiles/$id");
    var authorizationHeader = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.headersWithAuthorization(authorizationHeader);

    var response = await http.delete(endpoint, headers: headers);
    return response;
  }
}
