import 'package:fyrm_frontend/api/util/dto_convert_helper.dart';

class SearchProfileDto {
  late int? id;
  late int userId;
  late num rentPriceLowerBound;
  late num rentPriceUpperBound;
  late double latitude;
  late double longitude;
  late List<String> rentMatesGenderOptions;
  late List<String> rentMateCountOptions;
  late List<String> bedroomOptions;
  late List<String> bathroomOptions;

  SearchProfileDto({
    this.id,
    required this.userId,
    required this.rentPriceLowerBound,
    required this.rentPriceUpperBound,
    required this.latitude,
    required this.longitude,
    required this.rentMatesGenderOptions,
    required this.rentMateCountOptions,
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
        rentMateGenderOptionsJsonField: rentMatesGenderOptions,
        rentMateCountOptionsJsonField: rentMateCountOptions,
        bedroomOptionsJsonField: bedroomOptions,
        bathroomOptionsJsonField: bathroomOptions
      };

  SearchProfileDto copy({
    int? id,
    int? userId,
    num? rentPriceLowerBound,
    num? rentPriceUpperBound,
    double? latitude,
    double? longitude,
    List<String>? rentMatesGenderOptions,
    List<String>? rentMateCountOptions,
    List<String>? bedroomOptions,
    List<String>? bathroomOptions,
  }) =>
      SearchProfileDto(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        rentPriceLowerBound: rentPriceLowerBound ?? this.rentPriceLowerBound,
        rentPriceUpperBound: rentPriceUpperBound ?? this.rentPriceUpperBound,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        rentMatesGenderOptions: rentMatesGenderOptions ?? this.rentMatesGenderOptions,
        rentMateCountOptions: rentMateCountOptions ?? this.rentMateCountOptions,
        bedroomOptions: bedroomOptions ?? this.bedroomOptions,
        bathroomOptions: bathroomOptions ?? this.bathroomOptions,
      );

  static SearchProfileDto fromJSON(dynamic json) => SearchProfileDto(
        id: json[idJsonField] as int,
        userId: json[userIdJsonField] as int,
        rentPriceLowerBound: json[rentPriceLowerBoundJsonField] as num,
        rentPriceUpperBound: json[rentPriceUpperBoundJsonField] as num,
        latitude: json[latitudeJsonField] as double,
        longitude: json[longitudeJsonField] as double,
        rentMatesGenderOptions: DtoConvertHelper.toStringList(json[rentMateGenderOptionsJsonField]),
        rentMateCountOptions: DtoConvertHelper.toStringList(json[rentMateCountOptionsJsonField]),
        bathroomOptions: DtoConvertHelper.toStringList(json[bathroomOptionsJsonField]),
        bedroomOptions: DtoConvertHelper.toStringList(json[bedroomOptionsJsonField]),
      );

  static String get idJsonField => "id";

  static String get userIdJsonField => "userId";

  static String get rentPriceLowerBoundJsonField => "rentPriceLowerBound";

  static String get rentPriceUpperBoundJsonField => "rentPriceUpperBound";

  static String get latitudeJsonField => "latitude";

  static String get longitudeJsonField => "longitude";

  static String get rentMateGenderOptionsJsonField => "rentMatesGenderOptions";

  static String get rentMateCountOptionsJsonField => "rentMateCountOptions";

  static String get bedroomOptionsJsonField => "bedroomOptions";

  static String get bathroomOptionsJsonField => "bathroomOptions";
}
