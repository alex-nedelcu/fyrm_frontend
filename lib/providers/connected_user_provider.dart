import 'package:flutter/foundation.dart';
import 'package:fyrm_frontend/api/authentication/dto/login_response_dto.dart';

class ConnectedUserProvider with ChangeNotifier {
  late LoginResponseDto? _connectedUserDetails;

  set connectedUserDetails(LoginResponseDto? connectedUserDetails) =>
      _connectedUserDetails = connectedUserDetails;

  int? get userId => _connectedUserDetails?.userId;

  String? get token => _connectedUserDetails?.token;

  String? get tokenType => _connectedUserDetails?.tokenType;

  String? get username => _connectedUserDetails?.username;

  String? get email => _connectedUserDetails?.email;

  String? get firstName => _connectedUserDetails?.firstName;

  String? get lastName => _connectedUserDetails?.lastName;

  String? get gender => _connectedUserDetails?.gender;

  String? get description => _connectedUserDetails?.description;

  int? get birthYear => _connectedUserDetails?.birthYear;

  bool? get isSearching => _connectedUserDetails?.isSearching;

  set description(String? description) {
    _connectedUserDetails?.description = description;
    notifyListeners();
  }

  set isSearching(bool? isSearching) {
    _connectedUserDetails?.isSearching = isSearching;
    notifyListeners();
  }
}
