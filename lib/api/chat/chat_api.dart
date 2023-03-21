import 'package:fyrm_frontend/api/util/api_configuration.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

class ChatApi {
  Future<http.Response> findAllMessagesByUser({required Authorization authorization, required int userId}) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/chat-messages/$userId");
    var authorizationHeader = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.headersWithAuthorization(authorizationHeader);

    var response = await http.get(endpoint, headers: headers);
    return response;
  }
}
