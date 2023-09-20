import 'package:hive_app/models/user.model.dart';
import 'package:hive_app/data/remote/network/NetworkApiService.dart';
import 'package:hive_app/data/remote/network/ApiEndPoints.dart';
import 'package:hive_app/data/remote/network/BaseApiService.dart';

class UserRepo {

  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<UserModel?> getUserData() async {
    try {
      dynamic response = await _apiService.getResponse(ApiEndPoints().USER_DATA);
      print("Log: $response");
      final jsonData = UserModel.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

}