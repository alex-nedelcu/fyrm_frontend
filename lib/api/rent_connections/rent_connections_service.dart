import 'dart:convert';
import 'dart:math';

import 'package:fyrm_frontend/api/rent_connections/dto/active_rent_connection_count_dto.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/finalise_rent_connection_dto.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/get_rent_mate_proposal_dto.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/initiator_status_dto.dart';
import 'package:fyrm_frontend/api/rent_connections/rent_connections_api.dart';
import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:fyrm_frontend/helper/constants.dart';
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
    final initiatorStatusDto =
        InitiatorStatusDto.fromJSON(jsonDecode(response.body));

    return initiatorStatusDto;
  }

  Future<int> finaliseRentConnection({
    required String tokenType,
    required String token,
    required int rentConnectionId,
    required String finalisation,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    http.Response response = await rentConnectionsApi.finaliseRentConnection(
        authorization: authorization,
        id: rentConnectionId,
        finaliseRentConnectionDto:
            FinaliseRentConnectionDto(rentConnectionStatus: finalisation));

    return response.statusCode;
  }

  Future<int> getActiveRentConnectionCount({
    required String tokenType,
    required String token,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    http.Response response = await rentConnectionsApi
        .getActiveRentConnectionCount(authorization: authorization);
    final activeRentConnectionCountDto =
        ActiveRentConnectionCountDto.fromJSON(jsonDecode(response.body));

    return activeRentConnectionCountDto.count;
  }

  Future<int> getRentMateProposal({
    required String tokenType,
    required String token,
    required int initiatorId,
    required List<SearchProfileDto> selectedSearchProfiles,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    List<int> searchProfileIds = selectedSearchProfiles
        .map((searchProfile) => searchProfile.id!)
        .toList();
    int proposalMaximumSize = findProposalMaximumSize(selectedSearchProfiles);

    final getRentMateProposalDto = GetRentMateProposalDto(
      initiatorId: initiatorId,
      proposalMaximumSize: proposalMaximumSize,
      searchProfileIds: searchProfileIds,
    );

    http.Response response = await rentConnectionsApi.getRentMateProposal(
      authorization: authorization,
      getRentMateProposalDto: getRentMateProposalDto,
    );

    return response.statusCode;
  }

  int findProposalMaximumSize(List<SearchProfileDto> searchProfiles) {
    try {
      return searchProfiles
          .map((searchProfile) => searchProfile.rentMateCountOptions)
          .reduce((accumulator, options) {
            accumulator.addAll(options);
            return accumulator;
          })
          .map((option) => int.parse(option.replaceAll(RegExp(r'[^0-9]'), '')))
          .toList()
          .reduce(max);
    } catch (_) {
      return kDefaultProposalSize;
    }
  }
}
