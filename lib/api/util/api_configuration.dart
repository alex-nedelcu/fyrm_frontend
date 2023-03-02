class ApiConfiguration {
  static const String localBaseUrl = "http://localhost:8080/api/v1/fyrm";
  static const String externalBaseUrl = "http://192.168.1.129:8080/api/v1/fyrm";
  static const String baseUrl = localBaseUrl;
  static Map<String, String> writeOperationHeaders = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': '*/*'
  };

  static Map<String, String> headersWithAuthorization(String authorization) {
    var writeOperationHeadersWithAuthorization = writeOperationHeaders;
    writeOperationHeadersWithAuthorization.putIfAbsent('Authorization', () => authorization);
    return writeOperationHeadersWithAuthorization;
  }
}
