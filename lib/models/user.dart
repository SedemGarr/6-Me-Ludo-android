import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import '../utils/utils.dart';
import 'user_settings.dart';

class Users {
  late String avatar;
  late String id;
  late String psuedonym;
  late String email;
  late int reputationValue;
  late bool isAnon;
  late UserSettings settings;
  late List<String> onGoingGameIDs;

  Users({
    required this.id,
    required this.psuedonym,
    required this.avatar,
    required this.reputationValue,
    required this.settings,
    required this.isAnon,
    required this.email,
    required this.onGoingGameIDs,
  });

  Users.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    id = json['id'];
    psuedonym = json['psuedonym'];
    settings = UserSettings.fromJson(json['settings']);
    reputationValue = json['reputationValue'];
    isAnon = json['isAnon'];
    email = json['email'] ?? '';
    if (json['onGoingGameIDs'] != null) {
      onGoingGameIDs = <String>[];
      json['onGoingGameIDs'].forEach((v) {
        onGoingGameIDs.add(v);
      });
    } else {
      onGoingGameIDs = <String>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['psuedonym'] = psuedonym;
    data['settings'] = settings.toJson();
    data['reputationValue'] = reputationValue;
    data['isAnon'] = isAnon;
    data['email'] = email;
    data['onGoingGameIDs'] = onGoingGameIDs.map((v) => v).toList();
    return data;
  }

  static Future<Users> getDefaultUser(String uid, String email, bool isAnon) async {
    return Users(
      avatar: Utils.generateRandomUserAvatar(),
      id: uid,
      settings: UserSettings.getDefaultSettings(),
      psuedonym: Utils.getRandomPseudonym(),
      reputationValue: 0,
      isAnon: isAnon,
      email: email,
      onGoingGameIDs: [],
    );
  }

  void addOngoingGameIDToList(String gameID) {
    if (!onGoingGameIDs.contains(gameID)) {
      onGoingGameIDs.add(gameID);
      updateUser();
    }
  }

  void removeOngoingGameIDFromList(String gameID) {
    if (onGoingGameIDs.contains(gameID)) {
      onGoingGameIDs.remove(gameID);
      updateUser();
    }
  }

  void updateUser() {
    Get.context!.read<UserProvider>().setAndUpdateUser(
          Users(
            id: id,
            psuedonym: psuedonym,
            avatar: avatar,
            reputationValue: reputationValue,
            settings: settings,
            isAnon: isAnon,
            onGoingGameIDs: onGoingGameIDs,
            email: email,
          ),
          true,
          true,
        );
  }

  @override
  bool operator ==(other) {
    return (other is Users) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
