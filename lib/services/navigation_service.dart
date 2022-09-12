import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/game/game.dart';
import 'package:six_me_ludo_android/screens/home/home_pageview_wrapper.dart';
import 'package:six_me_ludo_android/screens/splash/splash.dart';

import '../screens/legal/legal.dart';

class NavigationService {
  static void goToHomeScreen() {
    Get.offAll(() => const HomePageViewWrapper());
  }

  static Future<void> goToGameScreen() async {
    await Get.to(() => const GameScreen());
  }

  static Future<void> goToLegalScreen() async {
    await Get.to(() => const LegalScreen());
  }

  static void genericGoBack() {
    Get.back();
  }

  static goToSplashScreenAfterLogOut() {
    Get.off(() => const SplashScreen());
  }
}
