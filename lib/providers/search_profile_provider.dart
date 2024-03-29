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

  Future<int> create({
    required int userId,
    required String tokenType,
    required String token,
    required num rentPriceLowerBound,
    required num rentPriceUpperBound,
    required double latitude,
    required double longitude,
    required int maximumAgeGapInYears,
    required List<String> rentMatesGenderOptions,
    required List<String> rentMateCountOptions,
    required List<String> hobbyOptions,
    required List<String> bedroomOptions,
    required List<String> bathroomOptions,
  }) async {
    int statusCode = await searchProfileService.create(
      userId: userId,
      tokenType: tokenType,
      token: token,
      rentPriceLowerBound: rentPriceLowerBound,
      rentPriceUpperBound: rentPriceUpperBound,
      latitude: latitude,
      longitude: longitude,
      maximumAgeGapInYears: maximumAgeGapInYears,
      rentMatesGenderOptions: rentMatesGenderOptions,
      rentMateCountOptions: rentMateCountOptions,
      hobbyOptions: hobbyOptions,
      bedroomOptions: bedroomOptions,
      bathroomOptions: bathroomOptions,
    );

    fetchSearchProfiles(tokenType: tokenType, token: token, userId: userId);
    return statusCode;
  }

  Future<int> update({
    required int id,
    required int userId,
    required String tokenType,
    required String token,
    required num rentPriceLowerBound,
    required num rentPriceUpperBound,
    required double latitude,
    required double longitude,
    required int maximumAgeGapInYears,
    required List<String> rentMatesGenderOptions,
    required List<String> rentMateCountOptions,
    required List<String> hobbyOptions,
    required List<String> bedroomOptions,
    required List<String> bathroomOptions,
  }) async {
    int statusCode = await searchProfileService.update(
      id: id,
      tokenType: tokenType,
      token: token,
      rentPriceLowerBound: rentPriceLowerBound,
      rentPriceUpperBound: rentPriceUpperBound,
      latitude: latitude,
      longitude: longitude,
      maximumAgeGapInYears: maximumAgeGapInYears,
      rentMatesGenderOptions: rentMatesGenderOptions,
      rentMateCountOptions: rentMateCountOptions,
      hobbyOptions: hobbyOptions,
      bedroomOptions: bedroomOptions,
      bathroomOptions: bathroomOptions,
    );

    fetchSearchProfiles(tokenType: tokenType, token: token, userId: userId);
    return statusCode;
  }

  Future<int> delete({
    required int id,
    required int userId,
    required String tokenType,
    required String token,
  }) async {
    int statusCode = await searchProfileService.delete(
      id: id,
      tokenType: tokenType,
      token: token,
    );

    fetchSearchProfiles(tokenType: tokenType, token: token, userId: userId);
    return statusCode;
  }
}
