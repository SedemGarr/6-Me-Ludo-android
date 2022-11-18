import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:six_me_ludo_android/models/version.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

class AppProvider with ChangeNotifier {
  late PackageInfo _packageInfo;

  // for global loader
  bool isLoading = false;
  // for splash screen
  bool isSplashScreenLoaded = false;
  bool shouldShowAuthButton = false;

  //
  Random random = Random();

  final List<String> loadingStrings = [
    DialogueService.loading1Text.tr,
    DialogueService.loading2Text.tr,
    DialogueService.loading3Text.tr,
    DialogueService.loading4Text.tr,
    DialogueService.loading5Text.tr,
    DialogueService.loading6Text.tr,
    DialogueService.loading7Text.tr,
    DialogueService.loading8Text.tr,
    DialogueService.loading9Text.tr,
    DialogueService.loading10Text.tr,
  ];

  final List<String> welcomeStrings = [
    DialogueService.welcome1Text.tr,
    DialogueService.welcome2Text.tr,
    DialogueService.welcome3Text.tr,
    DialogueService.welcome4Text.tr,
    DialogueService.welcome5Text.tr,
    DialogueService.welcome6Text.tr,
    DialogueService.welcome7Text.tr,
    DialogueService.welcome8Text.tr,
    DialogueService.welcome9Text.tr,
    DialogueService.welcome10Text.tr,
  ];

  void setLoading(bool value, bool shouldRebuild) {
    isLoading = value;

    if (shouldRebuild) {
      notifyListeners();
    }
  }

  void setSplashScreenLoaded(bool value) {
    isSplashScreenLoaded = value;

    notifyListeners();
  }

  void setShouldShowAuthButton(bool value) {
    shouldShowAuthButton = value;

    notifyListeners();
  }

  Future<void> getPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  bool isVersionUpToDate(AppVersion appVersion) {
    return appVersion.version == getAppVersion();
  }

  String getAppName() {
    return _packageInfo.appName;
  }

  String getPackageName() {
    return _packageInfo.packageName;
  }

  String getAppVersion() {
    return _packageInfo.version;
  }

  int getAppBuildNumber() {
    return int.parse(_packageInfo.buildNumber);
  }

  String getLoadingString() {
    return loadingStrings[random.nextInt(loadingStrings.length)];
  }

  String getWelcomeString() {
    return welcomeStrings[random.nextInt(loadingStrings.length)];
  }
}
