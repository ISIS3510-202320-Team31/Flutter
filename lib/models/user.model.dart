import 'dart:convert';
import 'package:hive_app/models/event.model.dart';
import 'package:hive_app/models/tag.model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.users = const [],
  });

  List<User> users;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  String? id;
  String? icon;
  String? login;
  String? password;
  String? name;
  String? email;
  bool? verificated;
  String? role;
  String? career;
  DateTime? birthdate;
  List<User>? friends;
  List<Event>? events;
  List<Tag>? tags;

  User(
      {this.id,
      this.icon,
      this.login,
      this.password,
      this.name,
      this.email,
      this.verificated,
      this.role,
      this.career,
      this.birthdate,
      this.friends,
      this.events,
      this.tags});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      icon: json["icon"],
      login: json["login"],
      password: json["password"],
      name: json["name"],
      email: json["email"],
      verificated: json["verificated"],
      role: json["role"],
      career: json["career"],
      birthdate: DateTime.parse(json["birthdate"]),
      friends: List<User>.from(json["friends"].map((x) => User.fromJson(x))),
      events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
        "login": login,
        "password": password,
        "name": name,
        "email": email,
        "verificated": verificated,
        "role": role,
        "career": career,
        "birthdate": birthdate!.toIso8601String(),
        "friends": List<dynamic>.from(friends!.map((x) => x.toJson())),
        "events": List<dynamic>.from(events!.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags!.map((x) => x.toJson()))
      };
}
