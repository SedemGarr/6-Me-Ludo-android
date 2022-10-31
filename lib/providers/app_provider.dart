import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:six_me_ludo_android/models/version.dart';

class AppProvider with ChangeNotifier {
  late PackageInfo _packageInfo;

  // for global loader
  bool isLoading = false;
  // for splash screen
  bool isSplashScreenLoaded = false;

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

  String getAppBuildName() {
    return _packageInfo.buildNumber;
  }
}
