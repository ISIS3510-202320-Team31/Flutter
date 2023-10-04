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
