import 'dart:convert';

import 'package:fyrm_frontend/api/notification/dto/notification_dto.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

import 'notification_api.dart';

class NotificationService {
  final NotificationApi notificationApi = NotificationApi();

  Future<List<NotificationDto>> findAllNotificationsReceivedByUser({
    required String tokenType,
    required String token,
    required int userId,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    http.Response response = await notificationApi.findAllNotificationsReceivedByUser(
      authorization: authorization,
      userId: userId,
    );

    final notifications = jsonDecode(response.body)['notifications'] as List<dynamic>;
    return List<NotificationDto>.from(notifications.map((json) => NotificationDto.fromJSON(json)));
  }

  Future<int> markAllAsRead({
    required String tokenType,
    required String token,
    required int userId,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    http.Response response = await notificationApi.markAllAsRead(
      authorization: authorization,
      userId: userId,
    );

    return response.statusCode;
  }

  Future<int> markAsRead({
    required String tokenType,
    required String token,
    required int notificationId,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    http.Response response = await notificationApi.markAsRead(
      authorization: authorization,
      notificationId: notificationId,
    );

    return response.statusCode;
  }
}
