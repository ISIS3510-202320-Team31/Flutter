import 'dart:convert';

UserRegisterModel userModelFromJson(String str) =>
    UserRegisterModel.fromJson(json.decode(str));

String userModelToJson(UserRegisterModel data) => json.encode(data.toJson());

class UserRegisterModel {
  UserRegisterModel({
    this.users = const [],
  });

  List<UserRegister> users;

  // factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  //       users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  //     );

  factory UserRegisterModel.fromJson(List<dynamic> json) {
    List<UserRegister> users =
        json.map((userData) => UserRegister.fromJson(userData)).toList();
    return UserRegisterModel(users: users);
  }

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class UserRegister {
  String? login;
  String? password;
  String? name;
  String? email;
  String? career;
  DateTime? birthdate;

  UserRegister({
    this.login,
    this.password,
    this.name,
    this.email,
    this.career,
    this.birthdate,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        login: json["login"],
        password: json["password"],
        name: json["name"],
        email: json["email"],
        career: json["career"],
        birthdate: DateTime.parse(json["birthdate"]),
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "password": password,
        "name": name,
        "email": email,
        "career": career,
        // take ONLY the date part of the DateTime object (YYYY-MM-DD format)
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
      };
}
