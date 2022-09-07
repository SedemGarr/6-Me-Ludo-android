import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/choice_dialog.dart';

import '../models/user.dart';
import '../services/authentication_service.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';
import '../services/translations/dialogue_service.dart';

class UserProvider with ChangeNotifier {
  late Users? _user;

  Future<void> initUser(BuildContext context) async {
    try {
      _user = await LocalStorageService.getUser();
    } catch (e) {
      debugPrint(e.toString());
      _user = null;
    }

    if (hasUser()) {
      NavigationService.goToHomeScreen();
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        showChoiceDialog(
          titleMessage: DialogueService.welcomeDialogTitleText.tr,
          contentMessage: DialogueService.welcomeDialogContentText.tr,
          yesMessage: DialogueService.welcomeDialogYesText.tr,
          noMessage: DialogueService.welcomeDialogNoText.tr,
          onYes: () async {
            await AuthenticationService.signInWithGoogle(context);
          },
          onNo: () {
            Utils.exitApp();
          },
          context: context,
        );
      });
    }
  }

  void setUser(Users user) {
    _user = user;
    notifyListeners();
  }

  bool hasUser() {
    return _user != null;
  }

  Locale getLocale() {
    if (LocalStorageService.isThereLocalUser()) {
      Users user = LocalStorageService.getLocalUser()!;

      return parseUserLocale(user.settings.locale);
    } else {
      return Get.deviceLocale ?? DialogueService.englishUS;
    }
  }

  Locale parseUserLocale(String locale) {
    List<String> localeCodes = locale.split('_');
    return Locale(localeCodes[0], localeCodes[1]);
  }
}
