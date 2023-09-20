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
  int id;
  String name;

  Tag({
    required this.id,
    required this.name,
  });

  Tag copyWith({
    int? id,
    String? name,
  }) {
    return Tag(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) => Tag.fromMap(json.decode(source));
}
