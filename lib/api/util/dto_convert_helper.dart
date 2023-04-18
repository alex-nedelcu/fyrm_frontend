class DtoConvertHelper {
  static List<String> toStringList(dynamic value) {
    final iterable = value as Iterable<dynamic>;
    return iterable.map((item) => item.toString()).toList();
  }

  static List<int> toIntList(dynamic value) {
    final iterable = value as Iterable<dynamic>;
    return iterable.map((item) => item as int).toList();
  }
}
