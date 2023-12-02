import 'dart:convert';

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
  ApiResponse<int> participation = ApiResponse.none();
  ApiResponse<List> partners = ApiResponse.none();
  ApiResponse<List<dynamic>> topCreators = ApiResponse.none();

  void _setUserMain(ApiResponse<UserModel> response) {
    print("Response: $response");
    userModel = response;
    notifyListeners();
  }

 void _setPartnersMain(ApiResponse<List> response) {
    print("Response: $response");
    partners = response;
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

  void _setParticipation(ApiResponse<int> response) {
    print("Response: $response");
    participation = response;
    notifyListeners();
  }

  void _setTopCreators(ApiResponse<List<dynamic>> response) {
    print("Response: $response");
    topCreators = response;
    notifyListeners();
  }

  Future<void> saveLocalTopCreators() async {
    secureStorage.writeSecureData('topCreators', json.encode(topCreators.data));
  }

   Future<List<dynamic>> getLocalTopCreators() async {
    final eventsJSON = await secureStorage.readSecureData("topCreators");
    if (eventsJSON != null && eventsJSON.isNotEmpty) {
      final topCreators = json.decode(eventsJSON);
      return topCreators  ;
    } else {
      return [];
    }
  }

  Future<void> fetchTopCreators() async {
    _setTopCreators(ApiResponse.loading());
    _myRepo
        .getTopCreators()
        .then((value) => _setTopCreators(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setTopCreators(ApiResponse.offline())}
              else
                {_setTopCreators(ApiResponse.error(error.toString()))}
            });
  }

  getUserId() {
    _setUserId(ApiResponse.loading());
    secureStorage
        .readSecureData("userId")
        .then((value) => _setUserId(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setUserId(ApiResponse.offline())}
              else
                {_setUserId(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> getUserById(String userId) async {
    _setUser(ApiResponse.loading());
    _myRepo
        .getUserById(userId)
        .then((value) => _setUser(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setUser(ApiResponse.offline())}
              else
                {_setUser(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> getPartners(String userId) async {
    _setPartnersMain(ApiResponse.loading());
    _myRepo
        .getPartners(userId)
        .then((value) => _setPartnersMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setPartnersMain(ApiResponse.offline())}
              else
                {_setPartnersMain(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> getParticipationById(String userId) async {
    _setParticipation(ApiResponse.loading());
    _myRepo
        .getParticipationById(userId)
        .then((value) => _setParticipation(ApiResponse.completed(value!.size)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setParticipation(ApiResponse.offline())}
              else
                {_setParticipation(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> fetchUserData() async {
    _setUserMain(ApiResponse.loading());
    _myRepo
        .getUserData()
        .then((value) => _setUserMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setUserMain(ApiResponse.offline())}
              else
                {_setUserMain(ApiResponse.error(error.toString()))}
            });
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
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setUser(ApiResponse.offline())}
              else
                {_setUser(ApiResponse.error(error.toString()))}
            });
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
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setUser(ApiResponse.offline())}
              else
                {_setUser(ApiResponse.error(error.toString()))}
            });
  }
}
