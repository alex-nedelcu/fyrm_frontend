class ApiConfiguration {
  static const String localBaseUrl = "http://localhost:8080/api/v1/fyrm";
  static const String externalBaseUrl = "http://192.168.1.128:8080/api/v1/fyrm";
  static const String baseUrl = externalBaseUrl;
  static const Map<String, String> writeOperationHeaders = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*'
  };
}
