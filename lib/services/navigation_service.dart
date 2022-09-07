import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/home/home.dart';

import '../screens/auth/auth.dart';

class NavigationService {
  static void goToHomeScreen() {
    Get.offAll(() => const HomeScreen());
  }

  static void goToAuthScreen() {
    Get.offAll(() => const AuthScreen());
  }
}
