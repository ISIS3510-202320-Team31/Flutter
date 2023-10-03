import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:hive_app/data/remote/AppException.dart';
import 'package:hive_app/data/remote/network/BaseApiService.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet Connection'); // 503 Service Unavailable
    }
    return responseJson;
  }

  Future postResponse(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl + url), body: body);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet Connection'); // 503 Service Unavailable
    }
    return responseJson;
  }

  Future putResponse(String url, dynamic body) async {
    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(baseUrl + url), body: body);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet Connection'); // 503 Service Unavailable
    }
    return responseJson;
  }

  Future deleteResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(baseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet Connection'); // 503 Service Unavailable
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    } else {
      print("[${response.statusCode}] ${response.body}");
      if (response.statusCode >= 500 && response.statusCode < 600) {
        throw InternalServerException(response.body);
      } else if (response.statusCode == 400) {
        throw BadRequestException(response.body);
      } else if (response.statusCode == 401) {
        throw UnauthorisedException(response.body);
      } else if (response.statusCode == 404) {
        throw NotFoundException(response.body);
      } else {
        throw OtherException(response.body);
      }
    }
  }
}
