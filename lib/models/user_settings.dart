import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../constants/textstyle_constants.dart';
import '../utils/utils.dart';

class UserSettings {
  static const int slowSpeed = 500;
  static const int normalSpeed = 250;
  static const int fastSpeed = 0;

  static List<Map<String, dynamic>> gameSpeedModes = [
    {'value': fastSpeed, 'name': DialogueService.gameSpeedFastText.tr},
    {'value': normalSpeed, 'name': DialogueService.gameSpeedNormalText.tr},
    {'value': slowSpeed, 'name': DialogueService.gameSpeedSlowText.tr},
  ];

  static List<Map<String, dynamic>> preferredPersonalityType = [
    {'value': PlayerConstants.pacifist, 'name': DialogueService.pacifistPersonalityType.tr},
    {'value': PlayerConstants.averageJoe, 'name': DialogueService.averagePersonalityType.tr},
    {'value': PlayerConstants.vicious, 'name': DialogueService.viciousPersonalityType.tr},
    {'value': PlayerConstants.randomPersonality, 'name': DialogueService.randomPersonalityType.tr},
  ];

  late int preferredSpeed;
  late int maxPlayers;
  late bool prefersDarkMode;
  late bool prefersAudio;
  late bool prefersStartAssist;
  late bool prefersAutoStart;
  late bool prefersCatchupAssist;
  late bool prefersAdaptiveAI;
  late bool prefersProfanity;
  late bool prefersAddAI;
  late bool prefersWakelock;
  late String aiPersonalityPreference;
  late String locale;
  late String theme;

  UserSettings({
    required this.locale,
    required this.prefersAutoStart,
    required this.preferredSpeed,
    required this.aiPersonalityPreference,
    required this.prefersAudio,
    required this.prefersDarkMode,
    required this.prefersCatchupAssist,
    required this.prefersAdaptiveAI,
    required this.prefersStartAssist,
    required this.prefersProfanity,
    required this.prefersAddAI,
    required this.prefersWakelock,
    required this.maxPlayers,
    required this.theme,
  });

  static List<DropdownMenuItem<dynamic>> getGameSpeedDropDownMenuItems(BuildContext context) {
    return gameSpeedModes
        .map(
          (e) => DropdownMenuItem(
            value: e['value'],
            child: Text(
              e['name'],
              style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onSurface),
            ),
          ),
        )
        .toList();
  }

  static List<DropdownMenuItem<dynamic>> getPersonalityDropDownMenuItems(BuildContext context) {
    return preferredPersonalityType
        .map(
          (e) => DropdownMenuItem(
            value: e['value'],
            child: Text(
              e['name'],
              style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onSurface),
            ),
          ),
        )
        .toList();
  }

  static List<DropdownMenuItem<dynamic>> getHumanPlayerDropDownMenuItems(BuildContext context) {
    List<DropdownMenuItem<dynamic>> items = [];

    for (var i = 1; i <= 4; i++) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i.toString(),
            style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onSurface),
          ),
        ),
      );
    }

    return items;
  }

  UserSettings.fromJson(Map<String, dynamic> json) {
    aiPersonalityPreference = json['aiPersonalityPreference'] ?? PlayerConstants.randomPersonality;
    prefersCatchupAssist = json['prefersCatchupAssist'] ?? false;
    preferredSpeed = json['preferredSpeed'];
    prefersAudio = json['prefersAudio'];
    prefersDarkMode = json['prefersDarkMode'];
    prefersStartAssist = json['prefersStartAssist'];
    prefersAddAI = json['prefersAddAI'] ?? true;
    prefersAdaptiveAI = json['prefersAdaptiveAI'] ?? true;
    prefersAutoStart = json['prefersAutoStart'] ?? false;
    prefersProfanity = json['prefersProfanity'] ?? false;
    prefersWakelock = json['prefersWakelock'] ?? true;
    maxPlayers = json['maxPlayers'] ?? AppConstants.maxPlayerUpperLimit;
    locale = json['locale'] ?? Get.deviceLocale.toString();
    theme = json['theme'] ?? '';
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
    data['prefersProfanity'] = prefersProfanity;
    data['prefersAddAI'] = prefersAddAI;
    data['prefersWakelock'] = prefersWakelock;
    data['maxPlayers'] = maxPlayers;
    data['locale'] = locale;
    data['theme'] = theme;
    return data;
  }

  static UserSettings getDefaultSettings() {
    return UserSettings(
      preferredSpeed: normalSpeed,
      aiPersonalityPreference: PlayerConstants.randomPersonality,
      prefersAddAI: true,
      prefersAutoStart: false,
      prefersAudio: true,
      prefersDarkMode: Utils.getSystemDarkModeSetting(),
      prefersCatchupAssist: true,
      prefersAdaptiveAI: true,
      prefersStartAssist: true,
      prefersProfanity: false,
      prefersWakelock: true,
      maxPlayers: AppConstants.maxPlayerUpperLimit,
      locale: DialogueService.englishUS.toString(),
      theme: '',
    );
  }

  // static UserSettings getNoobSettings(Users user) {
  //   return UserSettings(
  //     preferredColor: user.settings.preferredColor,
  //     preferredSpeed: slowSpeed,
  //     prefersAddAI: user.settings.prefersAddAI,
  //     aiPersonalityPreference: Player.pacifist,
  //     prefersAutoStart: user.settings.prefersAutoStart,
  //     prefersAudio: user.settings.prefersAudio,
  //     prefersCatchupAssist: true,
  //     prefersDarkMode: user.settings.prefersDarkMode,
  //     prefersProfanity: user.settings.prefersProfanity,
  //     prefersAdaptiveAI: false,
  //     prefersStartAssist: true,
  //     maxPlayers: user.settings.maxPlayers,
  //     locale: user.settings.locale,
  //   );
  // }

  // static UserSettings getMediumSettings(Users user) {
  //   return UserSettings(
  //     preferredColor: user.settings.preferredColor,
  //     preferredSpeed: normalSpeed,
  //     prefersAddAI: user.settings.prefersAddAI,
  //     aiPersonalityPreference: Player.averageJoe,
  //     prefersAutoStart: user.settings.prefersAutoStart,
  //     prefersAudio: user.settings.prefersAudio,
  //     prefersCatchupAssist: false,
  //     prefersDarkMode: user.settings.prefersDarkMode,
  //     prefersProfanity: user.settings.prefersProfanity,
  //     prefersAdaptiveAI: true,
  //     prefersStartAssist: true,
  //     maxPlayers: user.settings.maxPlayers,
  //     locale: user.settings.locale,
  //   );
  // }

  // static UserSettings getHardcoreSettings(Users user) {
  //   return UserSettings(
  //     preferredColor: user.settings.preferredColor,
  //     preferredSpeed: fastSpeed,
  //     prefersAddAI: user.settings.prefersAddAI,
  //     aiPersonalityPreference: Player.vicious,
  //     prefersAutoStart: false,
  //     prefersAudio: user.settings.prefersAudio,
  //     prefersCatchupAssist: false,
  //     prefersDarkMode: user.settings.prefersDarkMode,
  //     prefersProfanity: user.settings.prefersProfanity,
  //     prefersAdaptiveAI: false,
  //     prefersStartAssist: false,
  //     maxPlayers: user.settings.maxPlayers,
  //     locale: user.settings.locale,
  //   );
  // }

  @override
  bool operator ==(other) {
    return (other is UserSettings) &&
        other.preferredSpeed == preferredSpeed &&
        other.aiPersonalityPreference == aiPersonalityPreference &&
        other.prefersAddAI == prefersAddAI &&
        other.prefersAutoStart == prefersAutoStart &&
        other.prefersAudio == prefersAudio &&
        other.prefersCatchupAssist == prefersCatchupAssist &&
        other.prefersDarkMode == prefersDarkMode &&
        other.prefersAdaptiveAI == prefersAdaptiveAI &&
        other.prefersStartAssist == prefersStartAssist &&
        other.prefersProfanity == prefersProfanity &&
        other.prefersWakelock == prefersWakelock &&
        other.maxPlayers == maxPlayers;
  }

  @override
  int get hashCode =>
      preferredSpeed.hashCode ^
      aiPersonalityPreference.hashCode ^
      prefersAutoStart.hashCode ^
      prefersAudio.hashCode ^
      prefersAddAI.hashCode ^
      prefersCatchupAssist.hashCode ^
      prefersDarkMode.hashCode ^
      prefersAdaptiveAI.hashCode ^
      prefersProfanity.hashCode ^
      prefersStartAssist.hashCode ^
      prefersWakelock.hashCode ^
      maxPlayers;
}
