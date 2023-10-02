import 'package:flutter/material.dart';
import 'package:hive_app/data/remote/response/ApiResponse.dart';
import 'package:hive_app/models/user.model.dart';
import 'package:hive_app/repository/user.repo.dart';

class UserVM extends ChangeNotifier {
  final _myRepo = UserRepoImpl();
  var userId;

  ApiResponse<UserModel> userModel = ApiResponse.loading();
  ApiResponse<User> user = ApiResponse.loading();

  void _setUserMain(ApiResponse<UserModel> response) {
    print("Response: $response");
    userModel = response;
    notifyListeners();
  }

  void _setUser(ApiResponse<User> response) {
    print("Response: $response");
    user = response;
    notifyListeners();
  }

  getUserid() {
    userId = '0f2dfb8a-df34-4026-a989-6607d2b399b7';
    print("User: $userId");
    return userId;
  }

  Future<void> fetchUserData() async {
    _setUserMain(ApiResponse.loading());
    _myRepo
        .getUserData()
        .then((value) => _setUserMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setUserMain(ApiResponse.error(error.toString())));
  }

  Future<void> registerUser(
    String name,
    String login,
    String email,
    String password,
    String career,
    DateTime birthdate,
  ) async {
    // User userRep = User.fromJson({
    //   "id": "",
    //   "icon": "",
    //   "name": name,
    //   "login": login,
    //   "email": email,
    //   "password": password,
    //   "verificated": false,
    //   "role": "STUDENT",
    //   "career": career,
    //   "birthdate": birthdate,
    // });
    User userRep = User.fromJson({
      "id": "",
      "icon": "",
      "name": "aaaaaa",
      "login": "aaaaaaaaaa",
      "email": "a.a@a.a",
      "password": "passwordA0",
      "verificated": "false",
      "role": "STUDENT",
      "career": "FILOSOFIA",
      "birthdate": "2002-12-27",
    });

    print("User: $userRep");

    _setUserMain(ApiResponse.loading());
    _myRepo
        .registerUser(userRep)
        .then((value) => _setUser(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setUser(ApiResponse.error(error.toString())));
  }
}
