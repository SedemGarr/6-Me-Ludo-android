import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/auth/auth.dart';
import 'package:six_me_ludo_android/screens/game/game_wrapper.dart';
import 'package:six_me_ludo_android/screens/home/home_pageview_wrapper.dart';

import '../screens/legal/legal.dart';
import '../screens/new_game/new_game.dart';
import '../screens/profile/widgets/settings/widgets/general/widgets/theme_selector.dart';

class NavigationService {
  static void goToAuthScreen() {
    Get.offAll(() => const AuthScreen());
  }

  static void goToHomeScreen() {
    Get.offAll(() => const HomePageViewWrapper());
  }

  static Future<void> goToNewGameScreen() async {
    await Get.to(() => const NewGameScreen());
  }

  static Future<void> goToGameScreen() async {
    await Get.to(() => const GameScreenWrapper());
  }

  static Future<void> goToThemeSelector() async {
    await Get.to(() => const ThemeSelectionScreen());
  }

  static Future<void> goToLegalScreen() async {
    await Get.to(() => const LegalScreen());
  }

  static void goToBackToHomeScreen() {
    Get.offAll(() => const HomePageViewWrapper());
  }

  static void genericGoBack() {
    Get.back();
  }

  static goToAuthScreenAfterLogOut() {
    Get.offAll(() => const AuthScreen());
  }
}
