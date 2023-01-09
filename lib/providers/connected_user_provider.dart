import 'package:flutter/foundation.dart';
import 'package:fyrm_frontend/api/dto/login_response_dto.dart';

class ConnectedUserProvider with ChangeNotifier {
  late LoginResponseDto _connectedUserDetails;

  set connectedUserDetails(LoginResponseDto connectedUserDetails) => _connectedUserDetails = connectedUserDetails;

  String get token => _connectedUserDetails.token!;

  String get tokenType => _connectedUserDetails.tokenType!;
}
