import 'dart:convert';

UserLoginModel userModelFromJson(String str) =>
    UserLoginModel.fromJson(json.decode(str));

String userModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  UserLoginModel({
    this.users = const [],
  });

  List<UserLogin> users;

  // factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  //       users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  //     );

  factory UserLoginModel.fromJson(List<dynamic> json) {
    List<UserLogin> users =
        json.map((userData) => UserLogin.fromJson(userData)).toList();
    return UserLoginModel(users: users);
  }

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class UserLogin {
  String? login;
  String? password;

  UserLogin({
    this.login,
    this.password,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        login: json["login"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "password": password,
      };
}
