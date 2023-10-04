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
