import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppProvider with ChangeNotifier {
  late PackageInfo _packageInfo;

  // for loader
  bool isLoading = false;

  Future<void> getPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
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

  void setLoading(bool value, bool shouldRebuild) {
    isLoading = value;

    if (shouldRebuild) {
      notifyListeners();
    }
  }
}
