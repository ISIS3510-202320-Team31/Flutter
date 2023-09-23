abstract class BaseApiService {
  final String baseUrl = "http://34.125.226.119:8080/";

  Future<dynamic> getResponse(String url);
}