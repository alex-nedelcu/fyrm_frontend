class ApiHelper {
  static Map<String, Object?> intToJson(String fieldName, int value) =>
      {fieldName: value};

  static bool is2xx(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }
}
