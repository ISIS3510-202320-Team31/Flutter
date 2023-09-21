import 'package:flutter/material.dart';
import 'package:hive_app/data/remote/response/ApiResponse.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/repository/event.repo.dart';

class EventVM extends ChangeNotifier {
  final _myRepo = EventRepoImpl();

  ApiResponse<EventModel> eventModel = ApiResponse.loading();

  void _setEventMain(ApiResponse<EventModel> response) {
    print("Response: $response");
    eventModel = response;
    notifyListeners();
  }

  Future<void> fetchEventData() async {
    _setEventMain(ApiResponse.loading());
    _myRepo
        .getEventData()
        .then((value) => _setEventMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setEventMain(ApiResponse.error(error.toString())));
  }
}