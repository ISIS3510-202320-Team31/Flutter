import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:hive_app/data/remote/response/ApiResponse.dart';
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/models/requests/event-create.model.dart';
import 'package:hive_app/utils/SecureStorage.dart';
import 'package:hive_app/repository/event.repo.dart';

class EventVM extends ChangeNotifier {
  final _myRepo = EventRepoImpl();

  ApiResponse<EventModel> eventModel = ApiResponse.none();
  ApiResponse<EventModel> eventModelCalendarFuture = ApiResponse.none();
  ApiResponse<EventModel> eventModelCalendarPast = ApiResponse.none();
  ApiResponse<EventModel> eventModelByOwner = ApiResponse.none();
  ApiResponse<Event> event = ApiResponse.none();
  final SecureStorage secureStorage = SecureStorage();

  void _setEventMain(ApiResponse<EventModel> response) {
    print("Response: $response");
    eventModel = response;
    notifyListeners();
  }

  void _setEvent(ApiResponse<Event> response) {
    print("Response: $response");
    event = response;
    notifyListeners();
  }

  void _setEventCalendarFuture(ApiResponse<EventModel> response) {
    print("Response: $response");
    eventModelCalendarFuture = response;
    notifyListeners();
  }

  void _setEventCalendarPast(ApiResponse<EventModel> response) {
    print("Response: $response");
    eventModelCalendarPast = response;
    notifyListeners();
  }

  void _setEventByOwner(ApiResponse<EventModel> response) {
    print("Response: $response");
    eventModelByOwner = response;
    notifyListeners();
  }

  Future<void> fetchEventData() async {
    _setEventMain(ApiResponse.loading());
    _myRepo
        .getEventData()
        .then((value) => _setEventMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setEventMain(ApiResponse.offline())}
              else
                {_setEventMain(ApiResponse.error(error.toString()))}
            });
  }

  Future<List<Event>> getLocalEventsFeed() async {
    final eventsJSON = await secureStorage.readSecureData("feedEvents");
    if (eventsJSON != null && eventsJSON.isNotEmpty) {
      final eventsRaw = json.decode(eventsJSON);
      final events = json.encode(eventsRaw['events']);
      final storedEvents = eventModelFromJson(events).events;
      return storedEvents;
    } else {
      return [];
    }
  }

  Future<void> saveLocalEventsFeed() async {
    secureStorage.writeSecureData(
        'feedEvents', eventModelToJson(eventModel.data!));
  }


  Future<void> saveLocalEventsFutureCalendar() async {
    secureStorage.writeSecureData('futureCalendarEvents',
        eventModelToJson(eventModelCalendarFuture.data!));
  }

  Future<void> saveLocalEventsPastCalendar() async {
    secureStorage.writeSecureData(
        'pastCalendarEvents', eventModelToJson(eventModelCalendarPast.data!));
  }

  Future<void> saveLocalEventsByOwner() async {
    secureStorage.writeSecureData(
        'eventsByOwner', eventModelToJson(eventModelByOwner.data!));
  }

  Future<List<Event>> getLocalCalendarFuture() async {
    final eventsJSON =
        await secureStorage.readSecureData("futureCalendarEvents");
    if (eventsJSON != null && eventsJSON.isNotEmpty) {
      final eventsRaw = json.decode(eventsJSON);
      final events = json.encode(eventsRaw['events']);
      final storedEvents = eventModelFromJson(events).events;
      return storedEvents;
    } else {
      return [];
    }
  }

  Future<List<Event>> getLocalCalendarPast() async {
    final eventsJSON = await secureStorage.readSecureData("pastCalendarEvents");
    if (eventsJSON != null && eventsJSON.isNotEmpty) {
      final eventsRaw = json.decode(eventsJSON);
      final events = json.encode(eventsRaw['events']);
      final storedEvents = eventModelFromJson(events).events;
      return storedEvents;
    } else {
      return [];
    }
  }

  Future<List<Event>> getLocalEventsByOwner() async {
    final eventsJSON = await secureStorage.readSecureData("eventsByOwner");
    if (eventsJSON != null && eventsJSON.isNotEmpty) {
      final eventsRaw = json.decode(eventsJSON);
      final events = json.encode(eventsRaw['events']);
      final storedEvents = eventModelFromJson(events).events;
      return storedEvents;
    } else {
      return [];
    }
  }

  Future<void> fetchEventsForUser(String userId) async {
    _setEventMain(ApiResponse.loading());
    _myRepo
        .getEventsForUser(userId)
        .then((value) => _setEventMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setEventMain(ApiResponse.offline())}
              else
                {_setEventMain(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> fetchEventById(String eventId) async {
    _setEvent(ApiResponse.loading());
    _myRepo
        .getEventById(eventId)
        .then((value) => _setEvent(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setEvent(ApiResponse.offline())}
              else
                {_setEvent(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> createEvent(
    String name,
    String place,
    int duration,
    int numParticipants,
    DateTime date,
    String category,
    String description,
    List<String> tags,
    List<String> links,
    String creatorId,
  ) async {
    EventCreate event = EventCreate(
      name: name,
      place: place,
      duration: duration,
      numParticipants: numParticipants,
      date: date,
      category: category,
      description: description,
      tags: tags,
      links: links,
      creatorId: creatorId,
    );

    _setEvent(ApiResponse.loading());
    _myRepo
        .createEvent(event)
        .then((value) => _setEvent(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setEvent(ApiResponse.offline())}
              else
                {_setEvent(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> addParticipant(String eventId, String participantId) async {
    _setEvent(ApiResponse.loading());
    _myRepo
        .addParticipant(eventId, participantId)
        .then((value) => _setEvent(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setEvent(ApiResponse.offline())}
              else
                {_setEvent(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> removeParticipant(String eventId, String participantId) async {
    _setEvent(ApiResponse.loading());
    _myRepo
        .removeParticipant(eventId, participantId)
        .then((value) => _setEvent(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setEvent(ApiResponse.offline())}
              else
                {_setEvent(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> fetchEventListByUser(
      String date, String uuidUser, String orderFuture) async {
    _setEventMain(ApiResponse.loading());
    _myRepo
        .fetchEventListByUser(date, uuidUser, orderFuture)
        .then((value) => _setEventMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setEventMain(ApiResponse.offline())}
              else
                {_setEventMain(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> fetchEventsByOwner(String userId) async {
    _setEventByOwner(ApiResponse.loading());
    _myRepo
        .getEventsByOwner(userId)
        .then((value) => _setEventByOwner(ApiResponse.completed(value)))
        .onError((error, stackTrace) => {
              if (error.toString() == "No Internet Connection")
                {_setEventByOwner(ApiResponse.offline())}
              else
                {_setEventByOwner(ApiResponse.error(error.toString()))}
            });
  }

  Future<void> fetchCalendarByUser(
      String date, String uuidUser, String orderFuture) async {
    if (orderFuture == '1') {
      _setEventCalendarFuture(ApiResponse.loading());
      _myRepo
          .fetchEventListByUser(date, uuidUser, orderFuture)
          .then(
              (value) => _setEventCalendarFuture(ApiResponse.completed(value)))
          .onError((error, stackTrace) => {
                if (error.toString() == "No Internet Connection")
                  {_setEventCalendarFuture(ApiResponse.offline())}
                else
                  {_setEventCalendarFuture(ApiResponse.error(error.toString()))}
              });
    } else {
      _setEventCalendarPast(ApiResponse.loading());
      _myRepo
          .fetchEventListByUser(date, uuidUser, orderFuture)
          .then((value) => _setEventCalendarPast(ApiResponse.completed(value)))
          .onError((error, stackTrace) => {
                if (error.toString() == "No Internet Connection")
                  {_setEventCalendarPast(ApiResponse.offline())}
                else
                  {_setEventCalendarPast(ApiResponse.error(error.toString()))}
              });
    }
  }
}
