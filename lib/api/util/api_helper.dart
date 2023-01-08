class ApiHelper {
  static Map<String, Object?> intToJson(String fieldName, int value) => {fieldName: value};

  static bool isSuccess(int? statusCode) {
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }

  static bool isUnauthorized(int? statusCode) {
    return statusCode != null && statusCode == 401;
  }

  static bool isServerError(int? statusCode) {
    return statusCode != null && statusCode == 500;
  }

  static bool isExpectedError(int? statusCode) {
    return statusCode != null && statusCode == 400 || statusCode == 422;
  }
}
