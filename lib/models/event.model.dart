import 'dart:convert';
import 'package:hive_app/models/user.model.dart';
import 'package:hive_app/models/tag.model.dart';

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.events = const [],
  }) {}

  List<Event> events = <Event>[];

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Event {
  int id;
  String image;
  String name;
  String place;
  DateTime date;
  String description;
  int numParticipants;
  String links;
  String category;
  bool state;
  int duration;
  User creator;
  List<User> participants;
  List<Tag> tags;

  Event({
    required this.id,
    required this.image,
    required this.name,
    required this.place,
    required this.date,
    required this.description,
    required this.numParticipants,
    required this.links,
    required this.category,
    required this.state,
    required this.duration,
    required this.creator,
    required this.participants,
    required this.tags,
  });

  Event copyWith({
    int? id,
    String? image,
    String? name,
    String? place,
    DateTime? date,
    String? description,
    int? numParticipants,
    String? links,
    String? category,
    bool? state,
    int? duration,
    User? creator,
    List<User>? participants,
    List<Tag>? tags,
  }) {
    return Event(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      place: place ?? this.place,
      date: date ?? this.date,
      description: description ?? this.description,
      numParticipants: numParticipants ?? this.numParticipants,
      links: links ?? this.links,
      category: category ?? this.category,
      state: state ?? this.state,
      duration: duration ?? this.duration,
      creator: creator ?? this.creator,
      participants: participants ?? this.participants,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'place': place,
      'date': date.millisecondsSinceEpoch,
      'description': description,
      'numParticipants': numParticipants,
      'links': links,
      'category': category,
      'state': state,
      'duration': duration,
      'creator': creator.toMap(),
      'participants': participants.map((x) => x.toMap()).toList(),
      'tags': tags.map((x) => x.toMap()).toList(),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      place: map['place'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] ?? 0),
      description: map['description'] ?? '',
      numParticipants: map['numParticipants'] ?? 0,
      links: map['links'] ?? '',
      category: map['category'] ?? '',
      state: map['state'] ?? false,
      duration: map['duration'] ?? 0,
      creator: User.fromMap(map['creator']),
      participants:
          List<User>.from(map['participants']?.map((x) => User.fromMap(x))),
      tags: List<Tag>.from(map['tags']?.map((x) => Tag.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}
