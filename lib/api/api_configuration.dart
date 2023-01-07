class ApiConfiguration {
  static const String baseUrl = "http://localhost:8080/api/v1/fyrm";
  static const Map<String, String> writeOperationHeaders = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*'
  };
}
