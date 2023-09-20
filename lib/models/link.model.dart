import 'dart:convert';

String tagModelToJson(LinkModel data) => json.encode(data.toJson());

class LinkModel {
  LinkModel({
    this.links = const [],
  }) {}

  List<Link> links = <Link>[];

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class Link {
  int? id;
  String? url;

  Link({
    this.id,
    this.url,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
