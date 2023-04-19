import 'dart:convert';

import 'package:fyrm_frontend/api/user/dto/update_user_dto.dart';
import 'package:fyrm_frontend/api/user/dto/user_statistics_dto.dart';
import 'package:fyrm_frontend/api/user/user_api.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

class UserService {
  final UserApi userApi = UserApi();

  Future<int> updateUser({
    required int userId,
    required String token,
    required String tokenType,
    required String? description,
    required bool isSearching,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    UpdateUserDto updateUserDto = UpdateUserDto(
      userId: userId,
      description: description,
      isSearching: isSearching,
    );

    http.Response response = await userApi.updateUser(
      updateUserDto: updateUserDto,
      authorization: authorization,
    );

    return response.statusCode;
  }

  Future<UserStatisticsDto> getStatisticsByUser({
    required String tokenType,
    required String token,
    required int userId,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    http.Response response = await userApi.getStatisticsByUser(
      authorization: authorization,
      userId: userId,
    );

    final statistics = UserStatisticsDto.fromJSON(jsonDecode(response.body));
    return statistics;
  }
}
