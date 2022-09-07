import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/home/home.dart';
import 'package:six_me_ludo_android/screens/splash/splash.dart';

class NavigationService {
  static void goToHomeScreen() {
    Get.offAll(() => const HomeScreen());
  }

  static void genericGoBack() {
    Get.back();
  }

  static goToSplashScreenAfterLogOut() {
    Get.off(() => const SplashScreen());
  }
}
