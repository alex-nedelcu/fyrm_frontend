import 'package:flutter/cupertino.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/initiator_status_dto.dart';
import 'package:fyrm_frontend/api/rent_connections/rent_connections_service.dart';

class RentConnectionsProvider with ChangeNotifier {
  final RentConnectionsService rentConnectionsService = RentConnectionsService();
  late InitiatorStatusDto latestInitiatorStatus;

  Future<InitiatorStatusDto> getLatestInitiatorStatus({
    required String tokenType,
    required String token,
    required int userId,
  }) async {
    final response = await rentConnectionsService.findInitiatorStatus(
      tokenType: tokenType,
      token: token,
      userId: userId,
    );

    return response;
  }

  Future<int> finaliseRentConnection({
    required String tokenType,
    required String token,
    required int rentConnectionId,
    required String finalisation,
  }) async {
    final response = await rentConnectionsService.finaliseRentConnection(
      tokenType: tokenType,
      token: token,
      rentConnectionId: rentConnectionId,
      finalisation: finalisation,
    );

    return response;
  }
}
