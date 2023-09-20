import 'dart:convert';

String tagModelToJson(TagModel data) => json.encode(data.toJson());

class TagModel {
  TagModel({
    this.tags = const [],
  }) {}

  List<Tag> tags = <Tag>[];

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}

class Tag {
  int? id;
  String? name;

  Tag({
    this.id,
    this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
