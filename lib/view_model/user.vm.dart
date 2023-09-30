import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_app/data/remote/response/ApiResponse.dart';
import 'package:hive_app/models/user.model.dart';
import 'package:hive_app/repository/user.repo.dart';

class UserVM extends ChangeNotifier {
  final _myRepo = UserRepoImpl();
  var user;

  ApiResponse<UserModel> userModel = ApiResponse.loading();

  void _setUserMain(ApiResponse<UserModel> response) {
    print("Response: $response");
    userModel = response;
    notifyListeners();
  }

  getUserid()  {
    user = '0f2dfb8a-df34-4026-a989-6607d2b399b7';
    print("User: $user");
    return user;
  }

  Future<void> fetchUserData() async {
    _setUserMain(ApiResponse.loading());
    _myRepo
        .getUserData()
        .then((value) => _setUserMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setUserMain(ApiResponse.error(error.toString())));
  }
}