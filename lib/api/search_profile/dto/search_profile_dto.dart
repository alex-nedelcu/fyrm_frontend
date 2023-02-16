class SearchProfileDto {
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
