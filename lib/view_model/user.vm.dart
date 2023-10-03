import 'package:flutter/material.dart';
import 'package:hive_app/data/remote/response/ApiResponse.dart';
import 'package:hive_app/models/user.model.dart';
import 'package:hive_app/models/requests/user-register.model.dart';
import 'package:hive_app/models/requests/user-login.model.dart';
import 'package:hive_app/repository/user.repo.dart';
import 'package:hive_app/utils/SecureStorage.dart';

class UserVM extends ChangeNotifier {
  final SecureStorage secureStorage = SecureStorage();

  final _myRepo = UserRepoImpl();

  ApiResponse<UserModel> userModel = ApiResponse.none();
  ApiResponse<User> user = ApiResponse.none();
  ApiResponse<String> userId = ApiResponse.none();

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

  void _setUserId(ApiResponse<String> response) {
    print("Response: $response");
    userId = response;
    notifyListeners();
  }

  getUserId() {
    _setUserId(ApiResponse.loading());
    secureStorage
        .readSecureData("userId")
        .then((value) => _setUserId(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setUserId(ApiResponse.error(error.toString())));
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
    UserRegister userReg = UserRegister(
      name: name,
      login: login,
      email: email,
      password: password,
      career: career,
      birthdate: birthdate,
    );

    _setUser(ApiResponse.loading());
    _myRepo
        .registerUser(userReg)
        .then((value) => _setUser(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setUser(ApiResponse.error(error.toString())));
  }

  Future<void> login(String login, String password) async {
    UserLogin userLogin = UserLogin(
      login: login,
      password: password,
    );

    _setUser(ApiResponse.loading());
    _myRepo
        .login(userLogin)
        .then((value) => _setUser(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setUser(ApiResponse.error(error.toString())));
  }
}
