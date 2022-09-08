import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/home/home.dart';
import 'package:six_me_ludo_android/screens/profile/profile.dart';
import 'package:six_me_ludo_android/screens/splash/splash.dart';

class NavigationService {
  static void goToHomeScreen() {
    Get.offAll(() => const HomeScreen());
  }

  static void goToProfileScreen() {
    Get.to(() => const ProfileScreen());
  }

  static void genericGoBack() {
    Get.back();
  }

  static goToSplashScreenAfterLogOut() {
    Get.off(() => const SplashScreen());
  }
}
