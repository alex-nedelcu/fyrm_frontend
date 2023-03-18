class ActiveRentConnectionCountDto {
  late int count;

  ActiveRentConnectionCountDto({required this.count});

  static ActiveRentConnectionCountDto fromJSON(dynamic json) =>
      ActiveRentConnectionCountDto(count: json[countJsonField] as int);

  static String get countJsonField => "count";
}
