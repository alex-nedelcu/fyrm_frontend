import 'package:flutter/foundation.dart';
import 'package:fyrm_frontend/api/authentication/dto/login_response_dto.dart';

class ConnectedUserProvider with ChangeNotifier {
  late LoginResponseDto? _connectedUserDetails;

  set connectedUserDetails(LoginResponseDto? connectedUserDetails) => _connectedUserDetails = connectedUserDetails;

  int? get userId => _connectedUserDetails?.userId;

  String? get token => _connectedUserDetails?.token;

  String? get tokenType => _connectedUserDetails?.tokenType;

  String? get username => _connectedUserDetails?.username;

  String? get email => _connectedUserDetails?.email;

  String? get description => _connectedUserDetails?.description;

  String? get birthDate => _connectedUserDetails?.birthDate;

  bool? get isSearching => _connectedUserDetails?.isSearching;

  int get unreadChatCount => 12;

  int get notificationCount => 5;

  set description(String? description) {
    _connectedUserDetails?.description = description;
  }

  set isSearching(bool? isSearching) {
    _connectedUserDetails?.isSearching = isSearching;
  }
}
