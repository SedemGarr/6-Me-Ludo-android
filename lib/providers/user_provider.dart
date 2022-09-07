import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';
import '../services/translations/dialogue_service.dart';

class UserProvider with ChangeNotifier {
  late Users? _user;

  Future<void> initUser() async {
    try {
      _user = await LocalStorageService.getUser();
    } catch (e) {
      debugPrint(e.toString());
      _user = null;
    }

    if (hasUser()) {
      NavigationService.goToHomeScreen();
    } else {
      NavigationService.goToAuthScreen();
    }
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
