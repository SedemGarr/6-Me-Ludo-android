import 'dart:math';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:six_me_ludo_android/models/user.dart';
import '../services/local_storage_service.dart';
import '../utils/utils.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _lightThemeData;
  late ThemeData _darkThemeData;
  late ThemeMode _themeMode;
  Random random = Random();

  TextTheme textTheme = GoogleFonts.workSansTextTheme();

  ThemeProvider() {
    _lightThemeData = initLightTheme();
    _darkThemeData = initDarkTheme();
    _themeMode = initThemeMode();
  }

  ThemeData initLightTheme() {
    return FlexColorScheme.light(colors: FlexColor.schemes[getScheme()]!.light).toTheme.copyWith(
          textTheme: textTheme,
          useMaterial3: true,
        );
  }

  ThemeData initDarkTheme() {
    return FlexColorScheme.dark(colors: FlexColor.schemes[getScheme()]!.dark).toTheme.copyWith(
          textTheme: textTheme,
          useMaterial3: true,
        );
  }

  ThemeMode initThemeMode() {
    return LocalStorageService.getDarkModePreference() == null ? Utils.getSystemTheme() : LocalStorageService.getThemeMode();
  }

  FlexScheme getScheme() {
    if (LocalStorageService.isThereLocalUser()) {
      Users user = LocalStorageService.getLocalUser()!;

      if (user.settings.theme.isEmpty) {
        return FlexColor.schemes.keys.toList()[random.nextInt(FlexColor.schemes.keys.toList().length)];
      } else {
        return FlexColor.schemes.keys.toList().firstWhere((element) => element.name == user.settings.theme);
      }
    } else {
      return FlexColor.schemes.keys.toList()[random.nextInt(FlexColor.schemes.keys.toList().length)];
    }
  }

  // FlexScheme getScheme() {
  //   Random random = Random();

  //   return FlexColor.schemes.keys.toList()[random.nextInt(FlexColor.schemes.keys.toList().length)];
  // }

  Color getSettingsColorListByIndex(FlexScheme flexScheme, bool isDark) {
    if (isDark) {
      return FlexColorScheme.dark(colors: FlexColor.schemes[flexScheme]!.dark).toTheme.colorScheme.primary;
    } else {
      return FlexColorScheme.light(colors: FlexColor.schemes[flexScheme]!.light).toTheme.colorScheme.primary;
    }
  }

  String getSettingsColorListNameByIndex(int i) {
    return FlexColor.schemes.keys.toList()[i].name;
  }

  void toggleDarkMode(bool isDark) {
    if (isDark) {
      Get.changeThemeMode(ThemeMode.dark);
      Get.changeTheme(_darkThemeData);
    } else {
      Get.changeThemeMode(ThemeMode.light);
      Get.changeTheme(_lightThemeData);
    }

    notifyListeners();
  }

  void setTheme(bool isDark, FlexScheme flexScheme) {
    ThemeData darkTheme = FlexColorScheme.dark(colors: FlexColor.schemes[flexScheme]!.dark).toTheme.copyWith(
          textTheme: textTheme,
          useMaterial3: true,
        );
    ThemeData lightTheme = FlexColorScheme.light(colors: FlexColor.schemes[flexScheme]!.light).toTheme.copyWith(
          textTheme: textTheme,
          useMaterial3: true,
        );

    if (isDark) {
      Get.changeTheme(darkTheme);
    } else {
      Get.changeTheme(lightTheme);
    }

    setDarkTheme(darkTheme);
    setLightTheme(lightTheme);

    notifyListeners();
  }

  void setLightTheme(ThemeData themeData) {
    _lightThemeData = themeData.copyWith(
      textTheme: textTheme,
      useMaterial3: true,
    );
  }

  void setDarkTheme(ThemeData themeData) {
    _darkThemeData = themeData.copyWith(
      textTheme: textTheme,
      useMaterial3: true,
    );
  }

  ThemeData getLightTheme() {
    return _lightThemeData;
  }

  ThemeData getDarkTheme() {
    return _darkThemeData;
  }

  ThemeMode getThemeMode() {
    return _themeMode;
  }
}
