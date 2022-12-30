import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/screens/edit_profile/edit_avatar.dart';
import 'package:six_me_ludo_android/screens/edit_profile/edit_pseudonym.dart';
import 'package:six_me_ludo_android/screens/game/game_wrapper.dart';
import 'package:six_me_ludo_android/screens/home/home_screen.dart';
import 'package:six_me_ludo_android/screens/new_game/new_game.dart';
import 'package:six_me_ludo_android/screens/profile/profile.dart';
import 'package:six_me_ludo_android/screens/splash/splash.dart';

import '../screens/legal/legal.dart';
import '../screens/profile/widgets/settings/widgets/general/widgets/theme_selector.dart';

class NavigationService {
  static void closePanel() {
    AppProvider appProvider = Get.context!.read<AppProvider>();
    appProvider.closePanelController();
  }

  static void goToHomeScreen() {
    Get.offAll(() => const HomeScreen());
  }

  static void goToProfileScreen() {
    closePanel();
    Get.to(() => const ProfileScreen());
  }

  static Future<void> goToNewGameScreen() async {
    closePanel();
    await Get.to(() => const NewGameScreen());
  }

  static Future<void> goToGameScreen() async {
    closePanel();
    await Get.to(() => const GameScreenWrapper());
  }

  static Future<void> goToEditPseudonymScreen() async {
    closePanel();
    await Get.to(() => const EditPseudonymScreen());
  }

  static Future<void> goToEditAvatarScreen() async {
    closePanel();
    await Get.to(() => const EditAvatarScreen());
  }

  static Future<void> goToThemeSelector() async {
    await Get.to(() => const ThemeSelectionScreen());
  }

  static Future<void> goToLegalScreen() async {
    await Get.to(() => const LegalScreen());
  }

  static void genericGoBack() {
    Get.back();
  }

  static goToSplashScreenAfterLogOut() {
    Get.offAll(() => const SplashScreen());
  }
}
