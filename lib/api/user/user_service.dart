import 'package:fyrm_frontend/api/user/dto/update_user_dto.dart';
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
}
