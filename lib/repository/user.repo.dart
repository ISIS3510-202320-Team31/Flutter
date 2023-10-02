import 'package:hive_app/models/user.model.dart';
import 'package:hive_app/data/remote/network/NetworkApiService.dart';
import 'package:hive_app/data/remote/network/ApiEndPoints.dart';

abstract class UserRepo {
  Future<UserModel?> getUserData();
}

class UserRepoImpl extends UserRepo {
  final NetworkApiService _apiService = NetworkApiService();

  @override
  Future<UserModel?> getUserData() async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints().usersEndPoint);
      print("Log: $response");
      final jsonData = UserModel.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  // register user
  Future<User?> registerUser(User user) async {
    try {
      dynamic response = await _apiService.postResponse(
          ApiEndPoints().registerEndPoint, user.toJson());
      print("Log: $response");
      final jsonData = User.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }
}
