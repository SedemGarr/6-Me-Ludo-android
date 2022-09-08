import '../utils/utils.dart';
import 'user_settings.dart';

class Users {
  late String avatar;
  late String id;
  late String countryCode;
  late String languageCode;
  late String psuedonym;
  late int reputationValue;
  late List<String> onGoingGames;
  late UserSettings settings;

  Users({
    required this.id,
    required this.psuedonym,
    required this.avatar,
    required this.countryCode,
    required this.languageCode,
    required this.reputationValue,
    required this.settings,
    required this.onGoingGames,
  });

  Users.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    id = json['id'];
    countryCode = json['countryCode'];
    languageCode = json['languageCode'];
    psuedonym = json['psuedonym'];
    settings = UserSettings.fromJson(json['settings']);
    reputationValue = json['reputationValue'];
    if (json['onGoingGames'] != null) {
      onGoingGames = <String>[];
      json['onGoingGames'].forEach((v) {
        onGoingGames.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['psuedonym'] = psuedonym;
    data['settings'] = settings.toJson();
    data['languageCode'] = languageCode;
    data['countryCode'] = countryCode;
    data['reputationValue'] = reputationValue;
    data['onGoingGames'] = onGoingGames.map((v) => v).toList();
    return data;
  }

  static Future<Users> getDefaultUser(String uid) async {
    return Users(
      avatar: Utils.generateRandomUserAvatar(),
      countryCode: await Utils.getDeviceCountryCode(),
      id: uid,
      languageCode: Utils.getDeviceLanguageCode(),
      settings: UserSettings.getDefaultSettings(),
      psuedonym: Utils.getRandomPseudonym(),
      reputationValue: 0,
      onGoingGames: [],
    );
  }

  static Future<Users> getTempUser() async {
    return Users(
      avatar: Utils.generateRandomUserAvatar(),
      countryCode: await Utils.getDeviceCountryCode(),
      id: '',
      languageCode: Utils.getDeviceLanguageCode(),
      settings: UserSettings.getDefaultSettings(),
      psuedonym: Utils.getRandomPseudonym(),
      reputationValue: 0,
      onGoingGames: [],
    );
  }

  @override
  bool operator ==(other) {
    return (other is Users) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
