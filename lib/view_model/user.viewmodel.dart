import 'package:flutter/material.dart';
import 'package:hive_app/models/user.model.dart';
import 'package:hive_app/repository/user.repo.dart';

class UserVM extends ChangeNotifier {
  final _myRepo = UserRepoImpl();

  ApiResponse<UserModel> userModel = ApiResponse.loading();

  void _setUserMain(ApiResponse<UserModel> response) {
    print("Response: $response");
    userModel = response;
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    _setUserMain(ApiResponse.loading());
    _myRepo
        .getUserData()
        .then((value) => _setUserMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setUserMain(ApiResponse.error(error.toString())));
  }
}