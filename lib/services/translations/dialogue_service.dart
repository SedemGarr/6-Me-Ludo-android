import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'english.dart';

class DialogueService extends Translations {
  static const Locale englishUS = Locale('en', 'US');

  static const List<Map<String, dynamic>> locales = [
    {
      'locale': englishUS,
      'name': 'English',
    },
  ];

  static List<DropdownMenuItem<dynamic>> getLocaleDropDownMenuItems(BuildContext context) {
    return locales
        .map(
          (e) => DropdownMenuItem(
            value: e['locale'].languageCode,
            child: Text(
              e['name'],
            ),
          ),
        )
        .toList();
  }

  /// ------------------------------------------------------

  static const String appName = 'appName';
  static const String genericErrorText = 'genericErrorText';
  static const String animationByText = 'animationByText';

  @override
  Map<String, Map<String, String>> get keys => {
        englishUS.toString(): EnglishTranslation.getEnglishTranslation(),
      };
}
