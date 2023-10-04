class Participation {
  int? size;

  Participation({this.size});

  factory Participation.fromJson(Map<String, dynamic> json) => Participation(
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
      };
}
