import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:restart_app/restart_app.dart';
import 'package:six_me_ludo_android/models/version.dart';
import 'package:six_me_ludo_android/providers/theme_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wakelock/wakelock.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../models/license.dart';
import '../services/database_service.dart';
import '../widgets/dialogs/choice_dialog.dart';

class AppProvider with ChangeNotifier {
  late PackageInfo _packageInfo;

  // for global loader
  bool isLoading = false;

  //
  Random random = Random();

  //
  PanelController panelController = PanelController();
  bool isPanelOpen = false;

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

  void togglePanelController() {
    if (isPanelOpen) {
      closePanelController();
    } else {
      openPanelController();
    }
  }

  void openPanelController() {
    panelController.open();
    
    notifyListeners();
  }

  void closePanelController() {
    panelController.close();
    
    notifyListeners();
  }

  void setIsPanelOpen(bool value) {
    isPanelOpen = value;
    notifyListeners();
  }

  void setLoading(bool value, bool shouldRebuild) {
    isLoading = value;

    if (shouldRebuild) {
      notifyListeners();
    }
  }

  Future<void> getPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  Future<bool> isVersionUpToDate() async {
    AppVersion? appVersion = await DatabaseService.getAppVersion();
    return appVersion != null && appVersion.version == getAppVersion();
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

  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
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

  static bool isStringProfane(String value) {
    ProfanityFilter filter = ProfanityFilter();
    return filter.hasProfanity(value);
  }

  static void showToast(String message, {String? title, Duration? duration, Color? backgroundColor}) {
    Color? contrastingColor;

    if (backgroundColor != null) {
      contrastingColor = ThemeProvider.getContrastingColor(backgroundColor);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: AppConstants.appShape,
          duration: duration ?? AppConstants.snackBarDuration,
          backgroundColor: backgroundColor,
          content: title != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title + DialogueService.chatSaysText.tr,
                      style: TextStyles.listTitleStyle(contrastingColor ?? Theme.of(Get.context!).colorScheme.surface),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      message,
                      style: TextStyles.listSubtitleStyle(contrastingColor ?? Theme.of(Get.context!).colorScheme.surface),
                    ),
                  ],
                )
              : Text(
                  message,
                  style: TextStyles.listSubtitleStyle(contrastingColor ?? Theme.of(Get.context!).colorScheme.surface),
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
        showToast(DialogueService.genericErrorText.tr);
      }
    } catch (e) {
      debugPrint(e.toString());
      showToast(DialogueService.genericErrorText.tr);
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
        exitApp();
      },
    );
  }

  static void restartApp() {
    Restart.restartApp();
  }

  static void exitApp() {
    SystemNavigator.pop();
  }
}
