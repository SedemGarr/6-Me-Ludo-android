import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:css_colors/css_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:username_generator/username_generator.dart';
import 'package:uuid/uuid.dart';
import 'package:clipboard/clipboard.dart';
import 'package:wakelock/wakelock.dart';

import '../constants/app_constants.dart';
import '../models/license.dart';

import '../widgets/choice_dialog.dart';

class Utils {
  static String generateRandomUserAvatar() {
    return List.generate(12, (_) => Random().nextInt(100)).join();
  }

  static String getRandomPseudonym() {
    UsernameGenerator generator = UsernameGenerator();
    generator.separator = ' ';

    String initialPseudonym = generator.generateRandom();

    String finalPseudonym = '';

    for (int i = 0; i < initialPseudonym.length; i++) {
      if (!initialPseudonym[i].isNum) {
        finalPseudonym += initialPseudonym[i];
      }
    }

    // strip out any potentially offensive words
    if (isStringProfane(finalPseudonym) || finalPseudonym.length > AppConstants.maxPseudonymLength) {
      return getRandomPseudonym();
    }

    return convertToTitleCase(finalPseudonym.trim());
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

  static String getInitials(String name) {
    int numberOfWords = name.trim().split(RegExp(' +')).length;
    return name.isNotEmpty ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(numberOfWords).join() : '';
  }

  static List<String> generateAvatarSelectionCodes(String avatar) {
    List<String> avatars = [];

    for (int i = 0; i < 1000; i++) {
      avatars.add(Utils.generateRandomUserAvatar());
    }

    avatars[0] = avatar;

    return avatars;
  }

  static String parsePsuedonymName(String value) {
    bool endsWithS = value[value.length - 1].toLowerCase() == 's';

    if (endsWithS) {
      value += "' ";
    } else {
      value += '\'s ';
    }

    return value;
  }

  static String getOfflineGameId(Uuid uuid) {
    return uuid.v1();
  }

  static String getAIPlayerId(Uuid uuid) {
    return uuid.v1();
  }

  static String getDefaultcountryCode() {
    return Get.deviceLocale!.countryCode ?? AppConstants.defaultCountryCode;
  }

  static String getDeviceLanguageCode() {
    return Get.deviceLocale!.languageCode;
  }

  static String parseDate(String value) {
    return Jiffy(value.isEmpty ? DateTime.now() : value).MMMMEEEEd;
  }

  static String parseDateFromNow(String value) {
    return Jiffy(value.isEmpty ? DateTime.now() : value).fromNow();
  }

  static String getGameSessionDuration(String sessionStartedAt, String sessionEndedAt) {
    try {
      DateTime startedAt = DateTime.parse(sessionStartedAt);
      DateTime endedAt = DateTime.parse(sessionEndedAt);

      return parseDuration(endedAt.difference(startedAt));
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  static String parseDuration(Duration duration) {
    try {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  static ThemeMode getSystemTheme() {
    return getSystemDarkModeSetting() ? ThemeMode.dark : ThemeMode.light;
  }

  static bool getSystemDarkModeSetting() {
    return SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
  }

  static Color getContrastingColor(Color color) {
    return color.computeLuminance() > 0.5 ? CSSColors.black : CSSColors.white;
  }

  static String getDeviceTime() {
    return DateTime.now().toString();
  }

  static dynamic getRTDBServerTimestamp() {
    return ServerValue.timestamp;
  }

  static dynamic getFireStoreServerTimestamp() {
    return FieldValue.serverTimestamp();
  }

  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void showToast(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: AppConstants.snackBarDuration,
          content: Text(
            message,
            style: TextStyles.listSubtitleStyle(Theme.of(Get.context!).colorScheme.surface),
          ),
        ),
      );
    });
  }

  static void openURL(String url) async {
    if (await launchUrlString(url, mode: LaunchMode.externalApplication)) {
    } else {
      showToast(DialogueService.genericErrorText.tr);
    }
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  static Future<void> sendFeedback() async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: DialogueService.emailAddressText.tr,
        query: encodeQueryParameters(<String, String>{
          'subject': DialogueService.subjectText.tr,
        }),
      );

      if (await canLaunchUrl(emailLaunchUri)) {
        launchUrl(emailLaunchUri);
      } else {
        Utils.showToast(DialogueService.genericErrorText.tr);
      }
    } catch (e) {
      debugPrint(e.toString());
      Utils.showToast(DialogueService.genericErrorText.tr);
    }
  }

  static void copyToClipboard(String value) {
    FlutterClipboard.copy(value);
  }

  static void setWakeLock(bool value) {
    Wakelock.toggle(enable: value);
  }

  static Future<void> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await addGoogleFontsLicenses();
    await Firebase.initializeApp();
    listenForAppErrors();
    listenForAsyncAppErrors();
    await GetStorage.init();
  }

  static Future<List<License>> loadLicenses() async {
    return LicenseRegistry.licenses.asyncMap<License>((license) async {
      final title = license.packages.join('\n');
      final text = license.paragraphs.map<String>((paragraph) => paragraph.text).join('\n\n');
      return License(title: title, text: text);
    }).toList();
  }

  static Future<void> addGoogleFontsLicenses() async {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
  }

  static void listenForAppErrors() {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };
  }

  static void listenForAsyncAppErrors() {
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static void clearCache() async {
    await DefaultCacheManager().emptyCache();
  }

  static showExitDialog(BuildContext context) {
    return showChoiceDialog(
      context: context,
      titleMessage: DialogueService.exitAppDialogTitleText.tr,
      contentMessage: DialogueService.exitAppDialogContentText.tr,
      yesMessage: DialogueService.exitAppDialogYesText.tr,
      noMessage: DialogueService.exitAppDialogNoText.tr,
      onNo: () {},
      onYes: () {
        Utils.exitApp();
      },
    );
  }

  static void exitApp() {
    SystemNavigator.pop();
  }
}
