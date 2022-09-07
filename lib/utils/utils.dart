import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:username_generator/username_generator.dart';

import '../constants/constants.dart';
import '../services/country_service.dart';

class Utils {
  static String generateRandomUserAvatar() {
    return List.generate(12, (_) => Random().nextInt(100)).join();
  }

  static String getRandomPseudonym() {
    UsernameGenerator generator = UsernameGenerator();
    generator.separator = ' ';

    String initialpseudonym = generator.generateRandom();

    String finalpseudonym = '';

    for (int i = 0; i < initialpseudonym.length; i++) {
      if (!initialpseudonym[i].isNum) {
        finalpseudonym += initialpseudonym[i];
      }
    }

    // strip out any potentially offensive words
    if (isStringProfane(finalpseudonym) || finalpseudonym.length > AppConstants.maxPseudonymLength) {
      return getRandomPseudonym();
    }

    return convertToTitleCase(finalpseudonym.trim()).replaceAll(' ', '');
  }

  static bool isStringProfane(String value) {
    ProfanityFilter filter = ProfanityFilter();
    return filter.hasProfanity(value);
  }

  static String convertToTitleCase(String text) {
    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each word
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Merge all words back to one String
    return capitalizedWords.join(' ');
  }

  static Future<String> getDeviceCountryCode() async {
    return await CountryService.getData();
  }

  static String getDefaultcountryCode() {
    return Get.deviceLocale!.countryCode ?? AppConstants.defaultCountryCode;
  }

  static String getDeviceLanguageCode() {
    return Get.deviceLocale!.languageCode;
  }

  static ThemeMode getSystemTheme() {
    return getSystemDarkModeSetting() ? ThemeMode.dark : ThemeMode.light;
  }

  static bool getSystemDarkModeSetting() {
    return SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
  }

  static Future<void> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await addGoogleFontsLicenses();
    await Firebase.initializeApp();
    await GetStorage.init();
  }

  static Future<void> addGoogleFontsLicenses() async {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
  }
}
