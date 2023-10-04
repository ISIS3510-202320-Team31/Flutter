class EventCreate {
  String? name;
  String? place;
  int? duration;
  int? numParticipants;
  DateTime? date;
  String? category;
  String? description;
  List<String>? tags;
  List<String>? links;
  String? creatorId;

  EventCreate({
    this.name,
    this.place,
    this.duration,
    this.numParticipants,
    this.date,
    this.category,
    this.description,
    this.tags,
    this.links,
    this.creatorId,
  });

  factory EventCreate.fromJson(Map<String, dynamic> json) => EventCreate(
        name: json["name"],
        place: json["place"],
        duration: json["duration"],
        numParticipants: json["num_participants"],
        date: DateTime.parse(json["date"]),
        category: json["category"],
        description: json["description"],
        tags: List<String>.from(json["tags"] ?? []),
        links: List<String>.from(json["links"] ?? []),
        creatorId: json["creator"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "place": place,
        "duration": duration,
        "num_participants": numParticipants,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "category": category,
        "description": description,
        "tags": tags,
        "links": links,
        "creator": creatorId,
      };
}
