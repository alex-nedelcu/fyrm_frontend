import 'dart:convert';

import 'package:fyrm_frontend/api/rent_connections/dto/initiator_status_dto.dart';
import 'package:fyrm_frontend/api/rent_connections/rent_connections_api.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

class RentConnectionsService {
  final RentConnectionsApi rentConnectionsApi = RentConnectionsApi();

  Future<InitiatorStatusDto> findInitiatorStatus({
    required String tokenType,
    required String token,
    required int userId,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    http.Response response = await rentConnectionsApi.findInitiatorStatus(
      authorization: authorization,
      userId: userId,
    );
    final initiatorStatusDto = InitiatorStatusDto.fromJSON(jsonDecode(response.body));

    print("dto: ${initiatorStatusDto.toJSON()}");
    return initiatorStatusDto;
  }
}
