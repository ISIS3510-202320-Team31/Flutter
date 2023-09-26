import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/data/remote/network/NetworkApiService.dart';
import 'package:hive_app/data/remote/network/ApiEndPoints.dart';
import 'package:hive_app/data/remote/network/BaseApiService.dart';

abstract class EventRepo {
  Future<EventModel?> getEventData();
}

class EventRepoImpl extends EventRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<EventModel?> getEventData() async {
    try {
      dynamic response =
          await _apiService.getResponse(ApiEndPoints().eventsEndPoint);
      print("Log: $response");
      final jsonData = EventModel.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  Future<Event> getEventById(String eventId) async {
    try {
      // Construye la URL completa para obtener un evento por ID
      final endpoint = ApiEndPoints().eventsEndPoint + '$eventId';
      
      dynamic response = await _apiService.getResponse(endpoint);
      print("Log: $response");
      final jsonData = Event.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

}
