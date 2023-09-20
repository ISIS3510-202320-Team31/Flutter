import 'dart:convert';
import 'package:hive_app/models/user.model.dart';
import 'package:hive_app/models/tag.model.dart';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));
String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.events = const [],
  });

  List<Event> events;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Event {
  int? id;
  String? image;
  String? name;
  String? place;
  DateTime? date;
  String? description;
  int? numParticipants;
  String? links;
  String? category;
  bool? state;
  int? duration;
  User? creator;
  List<User>? participants;
  List<Tag>? tags;

  Event({
    this.id,
    this.image,
    this.name,
    this.place,
    this.date,
    this.description,
    this.numParticipants,
    this.links,
    this.category,
    this.state,
    this.duration,
    this.creator,
    this.participants,
    this.tags,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        place: json["place"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        numParticipants: json["numParticipants"],
        links: json["links"],
        category: json["category"],
        state: json["state"],
        duration: json["duration"],
        creator: User.fromJson(json["creator"]),
        participants: List<User>.from(json["participants"].map((x) => User.fromJson(x))),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x)))
      );
  
  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "place": place,
        "date": date!.toIso8601String(),
        "description": description,
        "numParticipants": numParticipants,
        "links": links,
        "category": category,
        "state": state,
        "duration": duration,
        "creator": creator!.toJson(),
        "participants": List<dynamic>.from(participants!.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags!.map((x) => x.toJson()))
      };

}
