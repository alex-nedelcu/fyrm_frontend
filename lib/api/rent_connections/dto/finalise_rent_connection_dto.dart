class FinaliseRentConnectionDto {
  late String? rentConnectionStatus;

  FinaliseRentConnectionDto({
    required this.rentConnectionStatus,
  });

  Map<String, Object?> toJSON() => {rentConnectionStatusJsonField: rentConnectionStatus};

  FinaliseRentConnectionDto copy({String? rentConnectionStatus}) =>
      FinaliseRentConnectionDto(rentConnectionStatus: rentConnectionStatus ?? this.rentConnectionStatus);

  static String get rentConnectionStatusJsonField => "rentConnectionStatus";
}
