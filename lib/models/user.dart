import '../utils/utils.dart';
import 'user_settings.dart';

class Users {
  late String avatar;
  late String id;
  late String psuedonym;
  late String email;
  late String appVersion;
  late int reputationValue;
  late bool isAnon;
  late UserSettings settings;

  Users({
    required this.id,
    required this.psuedonym,
    required this.avatar,
    required this.reputationValue,
    required this.settings,
    required this.isAnon,
    required this.email,
    required this.appVersion,
  });

  Users.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    id = json['id'];
    psuedonym = json['psuedonym'];
    settings = UserSettings.fromJson(json['settings']);
    reputationValue = json['reputationValue'];
    isAnon = json['isAnon'];
    email = json['email'] ?? '';
    appVersion = json['appVersion'] ?? '';
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
    data['appVersion'] = appVersion;
    return data;
  }

  static Future<Users> getDefaultUser(String uid, String email, bool isAnon, String appVersion) async {
    return Users(
      avatar: Utils.generateRandomUserAvatar(),
      id: uid,
      settings: UserSettings.getDefaultSettings(),
      psuedonym: Utils.getRandomPseudonym(),
      reputationValue: 0,
      isAnon: isAnon,
      email: email,
      appVersion: appVersion,
    );
  }

  void setReputationValue(int value) {
    if (value < 100 && value > -100) {
      reputationValue = value;
    }
  }

  @override
  bool operator ==(other) {
    return (other is Users) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
