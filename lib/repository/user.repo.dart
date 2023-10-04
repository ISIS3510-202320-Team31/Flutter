import 'dart:convert';

import 'package:hive_app/models/user.model.dart';
import 'package:hive_app/models/requests/user-register.model.dart';
import 'package:hive_app/models/requests/user-login.model.dart';
import 'package:hive_app/data/remote/network/NetworkApiService.dart';
import 'package:hive_app/data/remote/network/ApiEndPoints.dart';

import '../models/responses/participation.model.dart';

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

  Future<User?> getUserById(String userId) async {
    try {
      dynamic response = await _apiService
          .getResponse(ApiEndPoints().usersEndPoint + '$userId');
      print("Log: $response");
      final jsonData = User.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  Future<Participation?> getParticipationById(String userId) async {
    try {
      dynamic response = await _apiService.getResponse(
          ApiEndPoints().eventsEndPoint + 'users/$userId/participation/');
      print("Log: $response");
      final jsonData = Participation.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  Future<User?> registerUser(UserRegister user) async {
    try {
      dynamic response = await _apiService.postResponse(
          ApiEndPoints().registerEndPoint, jsonEncode(user.toJson()));
      print("Log: $response");
      final jsonData = User.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  Future<User?> login(UserLogin user) async {
    try {
      dynamic response = await _apiService.postResponse(
          ApiEndPoints().loginEndPoint, jsonEncode(user.toJson()));
      print("Log: $response");
      final jsonData = User.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }
}
