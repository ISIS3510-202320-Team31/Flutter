import 'package:flutter/material.dart';
import 'package:hive_app/data/remote/response/ApiResponse.dart';
import 'package:hive_app/models/tag.model.dart';
import 'package:hive_app/repository/tag.repo.dart';

class TagVM extends ChangeNotifier {
  final _myRepo = TagRepoImpl();

  ApiResponse<TagModel> tagModel = ApiResponse.loading();

  void _setTagMain(ApiResponse<TagModel> response) {
    print("Response: $response");
    tagModel = response;
    notifyListeners();
  }

  Future<void> fetchTagData() async {
    _setTagMain(ApiResponse.loading());
    _myRepo
        .getTagData()
        .then((value) => _setTagMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setTagMain(ApiResponse.error(error.toString())));
  }
}