import 'dart:convert';

import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';
import 'package:fyrm_frontend/api/search_profile/search_profile_api.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

class SearchProfileService {
  final SearchProfileApi searchProfileApi = SearchProfileApi();

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
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    SearchProfileDto searchProfileDto = SearchProfileDto(
      userId: userId,
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

    http.Response response = await searchProfileApi.create(
      searchProfileDto: searchProfileDto,
      authorization: authorization,
    );

    return response.statusCode;
  }

  Future<int> update({
    required int id,
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
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    SearchProfileDto searchProfileDto = SearchProfileDto(
      id: id,
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

    http.Response response = await searchProfileApi.update(
      searchProfileDto: searchProfileDto,
      authorization: authorization,
    );

    return response.statusCode;
  }

  Future<List<SearchProfileDto>> findAllByUserId({
    required String tokenType,
    required String token,
    required int userId,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    http.Response response = await searchProfileApi.findAllByUserId(
        authorization: authorization, userId: userId);
    final searchProfileDtos =
        jsonDecode(response.body)['searchProfiles'] as List<dynamic>;
    return List<SearchProfileDto>.from(
        searchProfileDtos.map((json) => SearchProfileDto.fromJSON(json)));
  }

  Future<int> delete({
    required String tokenType,
    required String token,
    required int id,
  }) async {
    Authorization authorization = Authorization(
      tokenType: tokenType,
      token: token,
    );

    http.Response response =
        await searchProfileApi.delete(authorization: authorization, id: id);
    return response.statusCode;
  }
}
