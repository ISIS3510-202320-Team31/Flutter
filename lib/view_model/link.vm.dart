import 'package:flutter/material.dart';
import 'package:hive_app/data/remote/response/ApiResponse.dart';
import 'package:hive_app/models/link.model.dart';
import 'package:hive_app/repository/link.repo.dart';

class LinkVM extends ChangeNotifier {
  final _myRepo = LinkRepoImpl();

  ApiResponse<LinkModel> linkModel = ApiResponse.none();

  void _setLinkMain(ApiResponse<LinkModel> response) {
    print("Response: $response");
    linkModel = response;
    notifyListeners();
  }

  Future<void> fetchLinkData() async {
    _setLinkMain(ApiResponse.loading());
    _myRepo
        .getLinkData()
        .then((value) => _setLinkMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setLinkMain(ApiResponse.error(error.toString())));
  }
}
