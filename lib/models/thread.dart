import 'package:six_me_ludo_android/models/user.dart';

import 'message.dart';

class Thread {
  late String id;
  late String ownerId;
  late List<Message> messages;
  late List<String> bannedIds;

  Thread({
    required this.id,
    required this.ownerId,
    required this.messages,
    required this.bannedIds,
  });

  static getDefaultThread(Users user, String id) {
    return Thread(
      id: id,
      ownerId: user.id,
      messages: [],
      bannedIds: [],
    );
  }

  Thread.fromJson(Map<String, dynamic> json) {
    ownerId = json['ownerId'];
    id = json['id'];
    if (json['bannedIds'] != null) {
      bannedIds = <String>[];
      json['bannedIds'].forEach((v) {
        bannedIds.add(v);
      });
    }
    if (json['messages'] != null) {
      messages = <Message>[];
      json['messages'].forEach((v) {
        messages.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ownerId'] = ownerId;
    data['id'] = id;
    data['bannedIds'] = bannedIds.map((v) => v).toList();
    data['messages'] = messages.map((v) => v.toJson()).toList();
    return data;
  }
}
