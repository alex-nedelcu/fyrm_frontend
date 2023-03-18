import 'dart:convert';

import 'package:fyrm_frontend/api/rent_connections/dto/finalise_rent_connection_dto.dart';
import 'package:fyrm_frontend/api/rent_connections/dto/get_rent_mate_proposal_dto.dart';
import 'package:fyrm_frontend/api/util/api_configuration.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

class RentConnectionsApi {
  Future<http.Response> findInitiatorStatus({required Authorization authorization, required int userId}) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/find-initiator-status/$userId");
    var authorizationHeader = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.headersWithAuthorization(authorizationHeader);

    var response = await http.get(endpoint, headers: headers);
    return response;
  }

  Future<http.Response> finaliseRentConnection({
    required Authorization authorization,
    required FinaliseRentConnectionDto finaliseRentConnectionDto,
    required int id,
  }) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/rent-connections/$id");
    var authorizationHeader = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.headersWithAuthorization(authorizationHeader);
    var body = jsonEncode(finaliseRentConnectionDto.toJSON());

    var response = await http.patch(endpoint, headers: headers, body: body);
    return response;
  }

  Future<http.Response> getRentMateProposal({
    required Authorization authorization,
    required GetRentMateProposalDto getRentMateProposalDto,
  }) async {
    var endpoint = Uri.parse("${ApiConfiguration.baseUrl}/propose-rent-mates");
    var authorizationHeader = "${authorization.tokenType} ${authorization.token}";
    var headers = ApiConfiguration.headersWithAuthorization(authorizationHeader);
    var body = jsonEncode(getRentMateProposalDto.toJSON());

    var response = await http.post(endpoint, headers: headers, body: body);
    return response;
  }
}
