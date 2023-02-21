class DtoConvertHelper {
  static List<String> toStringList(dynamic value) {
    final iterable = value as Iterable<dynamic>;
    return iterable.map((item) => item.toString()).toList();
  }
}
