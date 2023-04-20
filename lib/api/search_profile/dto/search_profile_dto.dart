import 'package:fyrm_frontend/api/util/dto_convert_helper.dart';

class SearchProfileDto {
  late int? id;
  late int? userId;
  late num rentPriceLowerBound;
  late num rentPriceUpperBound;
  late double latitude;
  late double longitude;
  late int maximumAgeGapInYears;
  late List<String> rentMatesGenderOptions;
  late List<String> rentMateCountOptions;
  late List<String> hobbyOptions;
  late List<String> bedroomOptions;
  late List<String> bathroomOptions;

  SearchProfileDto({
    this.id,
    this.userId,
    required this.rentPriceLowerBound,
    required this.rentPriceUpperBound,
    required this.latitude,
    required this.longitude,
    required this.maximumAgeGapInYears,
    required this.rentMatesGenderOptions,
    required this.rentMateCountOptions,
    required this.hobbyOptions,
    required this.bedroomOptions,
    required this.bathroomOptions,
  });

  Map<String, Object?> toJSON() => {
        idJsonField: id,
        userIdJsonField: userId,
        rentPriceLowerBoundJsonField: rentPriceLowerBound,
        rentPriceUpperBoundJsonField: rentPriceUpperBound,
        latitudeJsonField: latitude,
        longitudeJsonField: longitude,
        maximumAgeGapInYearsJsonField: maximumAgeGapInYears,
        rentMateGenderOptionsJsonField: rentMatesGenderOptions,
        rentMateCountOptionsJsonField: rentMateCountOptions,
        hobbyOptionsJsonField: hobbyOptions,
        bedroomOptionsJsonField: bedroomOptions,
        bathroomOptionsJsonField: bathroomOptions
      };

  static SearchProfileDto fromJSON(dynamic json) => SearchProfileDto(
        id: json[idJsonField] as int,
        userId: json[userIdJsonField] as int,
        rentPriceLowerBound: json[rentPriceLowerBoundJsonField] as num,
        rentPriceUpperBound: json[rentPriceUpperBoundJsonField] as num,
        latitude: json[latitudeJsonField] as double,
        longitude: json[longitudeJsonField] as double,
        maximumAgeGapInYears: json[maximumAgeGapInYearsJsonField] as int,
        rentMatesGenderOptions:
            DtoConvertHelper.toStringList(json[rentMateGenderOptionsJsonField]),
        rentMateCountOptions:
            DtoConvertHelper.toStringList(json[rentMateCountOptionsJsonField]),
        hobbyOptions:
            DtoConvertHelper.toStringList(json[hobbyOptionsJsonField]),
        bathroomOptions:
            DtoConvertHelper.toStringList(json[bathroomOptionsJsonField]),
        bedroomOptions:
            DtoConvertHelper.toStringList(json[bedroomOptionsJsonField]),
      );

  static String get idJsonField => "id";

  static String get userIdJsonField => "userId";

  static String get rentPriceLowerBoundJsonField => "rentPriceLowerBound";

  static String get rentPriceUpperBoundJsonField => "rentPriceUpperBound";

  static String get latitudeJsonField => "latitude";

  static String get longitudeJsonField => "longitude";

  static String get maximumAgeGapInYearsJsonField => "maximumAgeGapInYears";

  static String get rentMateGenderOptionsJsonField => "rentMatesGenderOptions";

  static String get rentMateCountOptionsJsonField => "rentMateCountOptions";

  static String get hobbyOptionsJsonField => "hobbyOptions";

  static String get bedroomOptionsJsonField => "bedroomOptions";

  static String get bathroomOptionsJsonField => "bathroomOptions";
}
