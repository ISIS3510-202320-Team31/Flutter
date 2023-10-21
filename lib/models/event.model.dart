import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));
String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.events = const [],
  });

  List<Event> events;

  factory EventModel.fromJson(List<dynamic> json) {
    List<Event> events =
        json.map((eventData) => Event.fromJson(eventData)).toList();
    return EventModel(events: events);
  }

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Event {
  String? id;
  String? image;
  String? name;
  String? place;
  DateTime? date;
  String? description;
  int? numParticipants;
  String? category;
  bool? state;
  int? duration;
  String? creatorId;
  String? creator;
  List<String>? participants;
  List<String>? tags;
  List<String>? links;

  Event({
    this.id,
    this.image,
    this.name,
    this.place,
    this.date,
    this.description,
    this.numParticipants,
    this.category,
    this.state,
    this.duration,
    this.creatorId,
    this.creator,
    this.participants,
    this.tags,
    this.links,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        place: json["place"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        numParticipants: json["num_participants"],
        category: json["category"],
        state: json["state"] == "true" ? true : false,
        duration: json["duration"],
        creatorId: json["creator_id"],
        creator: json["creator"],
        participants: List<String>.from(json["participants"] ?? []),
        tags: List<String>.from(json["tags"] ?? []),
        links: List<String>.from(json["links"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "place": place,
        "date": date!.toIso8601String(),
        "description": description,
        "num_participants": numParticipants,
        "category": category,
        "state": state,
        "duration": duration,
        "creator_id": creatorId,
        "creator": creator,
        "participants": participants,
        "tags": tags,
        "links": links,
      };
}
