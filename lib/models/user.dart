import 'package:six_me_ludo_android/models/game.dart';
import '../utils/utils.dart';
import 'user_settings.dart';

class Users {
  late String avatar;
  late String id;
  late String psuedonym;
  late int reputationValue;
  late UserSettings settings;
  List<Game> onGoingGames = [];

  Users({
    required this.id,
    required this.psuedonym,
    required this.avatar,
    required this.reputationValue,
    required this.settings,
  });

  Users.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    id = json['id'];
    psuedonym = json['psuedonym'];
    settings = UserSettings.fromJson(json['settings']);
    reputationValue = json['reputationValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['psuedonym'] = psuedonym;
    data['settings'] = settings.toJson();
    data['reputationValue'] = reputationValue;
    return data;
  }

  static Future<Users> getDefaultUser(String uid) async {
    return Users(
      avatar: Utils.generateRandomUserAvatar(),
      id: uid,
      settings: UserSettings.getDefaultSettings(),
      psuedonym: Utils.getRandomPseudonym(),
      reputationValue: 0,
    );
  }

  static Future<Users> getTempUser() async {
    return Users(
      avatar: Utils.generateRandomUserAvatar(),
      id: '',
      settings: UserSettings.getDefaultSettings(),
      psuedonym: Utils.getRandomPseudonym(),
      reputationValue: 0,
    );
  }

  @override
  bool operator ==(other) {
    return (other is Users) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
