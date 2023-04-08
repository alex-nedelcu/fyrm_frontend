import 'package:fyrm_frontend/api/util/api_configuration.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  Future<http.Response> findAllNotificationsReceivedByUser({
    required Authorization authorization,
    required int userId,
  }) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/notifications/$userId");
    var authorizationHeader = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.headersWithAuthorization(authorizationHeader);

    var response = await http.get(endpoint, headers: headers);
    return response;
  }

  Future<http.Response> markAllAsRead({
    required Authorization authorization,
    required int userId,
  }) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/notifications/read-all/$userId");
    var authorizationHeader = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.headersWithAuthorization(authorizationHeader);

    var response = await http.post(endpoint, headers: headers);
    return response;
  }

  Future<http.Response> markAsRead({
    required Authorization authorization,
    required int notificationId,
  }) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/notifications/read/$notificationId");
    var authorizationHeader = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.headersWithAuthorization(authorizationHeader);

    var response = await http.post(endpoint, headers: headers);
    return response;
  }
}
