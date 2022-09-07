import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/user.dart';

import '../utils/utils.dart';
import 'player.dart';

class UserSettings {
  static const int slowSpeed = 500;
  static const int normalSpeed = 250;
  static const int fastSpeed = 0;

  static const noobSettings = 'noob';
  static const mediumSettings = 'medium';
  static const hardSettings = 'hard';

  late int preferredSpeed;
  late int preferredColor;
  late bool prefersDarkMode;
  late bool prefersAudio;
  late bool prefersStartAssist;
  late bool prefersAutoStart;
  late bool prefersCatchupAssist;
  late bool prefersAdaptiveAI;
  late String aiPersonalityPreference;
  late String locale;

  UserSettings({
    required this.locale,
    required this.prefersAutoStart,
    required this.preferredColor,
    required this.preferredSpeed,
    required this.aiPersonalityPreference,
    required this.prefersAudio,
    required this.prefersDarkMode,
    required this.prefersCatchupAssist,
    required this.prefersAdaptiveAI,
    required this.prefersStartAssist,
  });

  UserSettings.fromJson(Map<String, dynamic> json) {
    aiPersonalityPreference = json['aiPersonalityPreference'] ?? Player.randomPersonality;
    prefersCatchupAssist = json['prefersCatchupAssist'] ?? false;
    preferredColor = json['preferredColor'] ?? 0;
    preferredSpeed = json['preferredSpeed'];
    prefersAudio = json['prefersAudio'];
    prefersDarkMode = json['prefersDarkMode'];
    prefersStartAssist = json['prefersStartAssist'];
    prefersAdaptiveAI = json['prefersAdaptiveAI'] ?? true;
    prefersAutoStart = json['prefersAutoStart'] ?? false;
    locale = json['locale'] ?? Get.deviceLocale.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aiPersonalityPreference'] = aiPersonalityPreference;
    data['preferredSpeed'] = preferredSpeed;
    data['prefersDarkMode'] = prefersDarkMode;
    data['prefersAudio'] = prefersAudio;
    data['prefersStartAssist'] = prefersStartAssist;
    data['prefersCatchupAssist'] = prefersCatchupAssist;
    data['prefersAdaptiveAI'] = prefersAdaptiveAI;
    data['prefersAutoStart'] = prefersAutoStart;
    data['preferredColor'] = preferredColor;
    data['locale'] = locale;
    return data;
  }

  static UserSettings getDefaultSettings() {
    return UserSettings(
      preferredColor: 0,
      preferredSpeed: normalSpeed,
      aiPersonalityPreference: Player.randomPersonality,
      prefersAutoStart: false,
      prefersAudio: true,
      prefersDarkMode: Utils.getSystemDarkModeSetting(),
      prefersCatchupAssist: true,
      prefersAdaptiveAI: true,
      prefersStartAssist: true,
      locale: Get.deviceLocale.toString(),
    );
  }

  static UserSettings getNoobSettings(Users user) {
    return UserSettings(
      preferredColor: user.settings.preferredColor,
      preferredSpeed: slowSpeed,
      aiPersonalityPreference: Player.pacifist,
      prefersAutoStart: user.settings.prefersAutoStart,
      prefersAudio: user.settings.prefersAudio,
      prefersCatchupAssist: true,
      prefersDarkMode: user.settings.prefersDarkMode,
      prefersAdaptiveAI: false,
      prefersStartAssist: true,
      locale: user.settings.locale,
    );
  }

  static UserSettings getMediumSettings(Users user) {
    return UserSettings(
      preferredColor: user.settings.preferredColor,
      preferredSpeed: normalSpeed,
      aiPersonalityPreference: Player.averageJoe,
      prefersAutoStart: user.settings.prefersAutoStart,
      prefersAudio: user.settings.prefersAudio,
      prefersCatchupAssist: false,
      prefersDarkMode: user.settings.prefersDarkMode,
      prefersAdaptiveAI: true,
      prefersStartAssist: true,
      locale: user.settings.locale,
    );
  }

  static UserSettings getHardcoreSettings(Users user) {
    return UserSettings(
      preferredColor: user.settings.preferredColor,
      preferredSpeed: fastSpeed,
      aiPersonalityPreference: Player.vicious,
      prefersAutoStart: false,
      prefersAudio: user.settings.prefersAudio,
      prefersCatchupAssist: false,
      prefersDarkMode: user.settings.prefersDarkMode,
      prefersAdaptiveAI: false,
      prefersStartAssist: false,
      locale: user.settings.locale,
    );
  }

  @override
  bool operator ==(other) {
    return (other is UserSettings) &&
        other.preferredSpeed == preferredSpeed &&
        other.aiPersonalityPreference == aiPersonalityPreference &&
        other.prefersAutoStart == prefersAutoStart &&
        other.prefersAudio == prefersAudio &&
        other.prefersCatchupAssist == prefersCatchupAssist &&
        other.prefersDarkMode == prefersDarkMode &&
        other.prefersAdaptiveAI == prefersAdaptiveAI &&
        other.preferredColor == preferredColor &&
        other.prefersStartAssist == prefersStartAssist;
  }

  @override
  int get hashCode =>
      preferredSpeed.hashCode ^
      aiPersonalityPreference.hashCode ^
      prefersAutoStart.hashCode ^
      prefersAudio.hashCode ^
      prefersCatchupAssist.hashCode ^
      prefersDarkMode.hashCode ^
      prefersAdaptiveAI.hashCode ^
      preferredColor.hashCode ^
      prefersStartAssist.hashCode;
}
