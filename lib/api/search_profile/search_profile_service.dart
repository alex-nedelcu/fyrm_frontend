import 'package:fyrm_frontend/api/search_profile/dto/search_profile_dto.dart';
import 'package:fyrm_frontend/api/search_profile/search_profile_api.dart';
import 'package:fyrm_frontend/api/util/authorization.dart';
import 'package:http/http.dart' as http;

class SearchProfileService {
  final SearchProfileApi searchProfileApi = SearchProfileApi();

  Future<int> createSearchProfile({
    required int userId,
    required String tokenType,
    required String token,
    required num rentPriceLowerBound,
    required num rentPriceUpperBound,
    required double latitude,
    required double longitude,
    required List<String> rentMatesGenderOptions,
    required List<String> rentMateCountOptions,
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
      rentMatesGenderOptions: rentMatesGenderOptions,
      rentMateCountOptions: rentMateCountOptions,
      bedroomOptions: bedroomOptions,
      bathroomOptions: bathroomOptions,
    );

    http.Response response = await searchProfileApi.createSearchProfile(
      searchProfileDto: searchProfileDto,
      authorization: authorization,
    );

    return response.statusCode;
  }
}
