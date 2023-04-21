class ApiHelper {
  static Map<String, Object?> intToJson(String fieldName, int value) =>
      {fieldName: value};

  static Map<String, Object?> stringToJson(String fieldName, String value) =>
      {fieldName: value};

  static bool isSuccess(int? statusCode) {
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }

  static bool isUnauthorized(int? statusCode) {
    return statusCode != null && statusCode == 401;
  }

  static bool isExpectedError(int? statusCode) {
    return statusCode != null && statusCode == 400 || statusCode == 422;
  }
}
