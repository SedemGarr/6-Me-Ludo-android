import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';


class LocalStorageService {
  static void setUser(Users user) {
    GetStorage box = GetStorage();
    box.write('user', user.toJson());
  }

  static bool? getDarkModePreference() {
    if (!isThereLocalUser()) {
      return null;
    } else {
      return getLocalUser()?.settings.prefersDarkMode;
    }
  }

  static ThemeMode getThemeMode() {
    if (getLocalUser()!.settings.prefersDarkMode) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  static bool isThereLocalUser() {
    GetStorage box = GetStorage();
    return box.read('user') != null;
  }

  static Future<Users?> getUser() async {
    return getLocalUser();
  }

  static Users? getLocalUser() {
    GetStorage box = GetStorage();
    return isThereLocalUser() ? Users.fromJson(box.read('user')) : null;
  }

  static String? getAppVersion() {
    GetStorage box = GetStorage();
    return box.read('version');
  }

  static void clearUser() async {
    GetStorage box = GetStorage();
    box.erase();
  }
}
