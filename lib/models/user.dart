import 'package:six_me_ludo_android/models/stats.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import 'user_settings.dart';

class Users {
  late String avatar;
  late String id;
  late String psuedonym;
  late String email;
  late String appVersion;
  late int appBuildNumber;
  late int reputationValue;
  late bool isAnon;
  late UserSettings settings;
  late Stats stats;

  Users({
    required this.id,
    required this.psuedonym,
    required this.avatar,
    required this.reputationValue,
    required this.settings,
    required this.isAnon,
    required this.email,
    required this.appVersion,
    required this.appBuildNumber,
    required this.stats,
  });

  Users.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    id = json['id'];
    psuedonym = json['psuedonym'];
    settings = UserSettings.fromJson(json['settings']);
    stats = json['stats'] == null ? Stats.getDefaultStats() : Stats.fromJson(json['stats']);
    reputationValue = json['reputationValue'];
    isAnon = json['isAnon'];
    email = json['email'] ?? '';
    appVersion = json['appVersion'] ?? '';
    appBuildNumber = json['appBuildNumber'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['psuedonym'] = psuedonym;
    data['settings'] = settings.toJson();
    data['stats'] = stats.toJson();
    data['reputationValue'] = reputationValue;
    data['isAnon'] = isAnon;
    data['email'] = email;
    data['appVersion'] = appVersion;
    data['appBuildNumber'] = appBuildNumber;
    return data;
  }

  static Future<Users> getDefaultUser(String uid, String email, bool isAnon, String appVersion, int buildNumber) async {
    return Users(
      avatar: UserProvider.generateRandomUserAvatar(),
      id: uid,
      settings: UserSettings.getDefaultSettings(),
      psuedonym: UserProvider.getRandomPseudonym(),
      reputationValue: 0,
      isAnon: isAnon,
      email: email,
      appVersion: appVersion,
      appBuildNumber: buildNumber,
      stats: Stats.getDefaultStats(),
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
