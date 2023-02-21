import 'package:flutter/cupertino.dart';
import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';
import 'package:fyrm_frontend/api/search_profile/search_profile_service.dart';

class SearchProfileProvider with ChangeNotifier {
  final SearchProfileService searchProfileService = SearchProfileService();
  List<SearchProfileDto> searchProfiles = [];
  bool loading = false;

  Future<void> fetchSearchProfiles({
    required String tokenType,
    required String token,
    required int userId,
  }) async {
    loading = true;
    notifyListeners();

    final response = await searchProfileService.findAllByUserId(
      tokenType: tokenType,
      token: token,
      userId: userId,
    );

    searchProfiles = response;
    loading = false;
    notifyListeners();
  }
}
