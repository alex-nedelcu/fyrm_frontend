class ActiveRentConnectionDto {
  late int? id;
  late int? initiatorId;

  ActiveRentConnectionDto({
    required this.id,
    required this.initiatorId,
  });

  Map<String, Object?> toJSON() => {
        idJsonField: id,
        initiatorIdJsonField: initiatorId,
      };

  ActiveRentConnectionDto copy({
    int? id,
    int? initiatorId,
  }) =>
      ActiveRentConnectionDto(
        id: id ?? this.id,
        initiatorId: initiatorId ?? this.initiatorId,
      );

  static ActiveRentConnectionDto fromJSON(dynamic json) => ActiveRentConnectionDto(
        id: json[idJsonField] as int?,
        initiatorId: json[initiatorIdJsonField] as int?,
      );

  static String get idJsonField => "id";

  static String get initiatorIdJsonField => "initiatorId";
}
