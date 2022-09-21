class Message {
  late String createdById;
  late String createdAt;
  late String body;
  late bool isDeleted;
  late List<String> seenBy;

  Message({
    required this.body,
    required this.createdAt,
    required this.createdById,
    required this.seenBy,
    required this.isDeleted,
  });

  Message.fromJson(Map<String, dynamic> json) {
    createdById = json['createdById'];
    createdAt = json['createdAt'];
    body = json['body'];
    isDeleted = json['isDeleted'];
    if (json['seenBy'] != null) {
      seenBy = <String>[];
      json['seenBy'].forEach((v) {
        seenBy.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdById'] = createdById;
    data['createdAt'] = createdAt;
    data['body'] = body;
    data['isDeleted'] = isDeleted;
    data['seenBy'] = seenBy.map((v) => v).toList();
    return data;
  }
}
