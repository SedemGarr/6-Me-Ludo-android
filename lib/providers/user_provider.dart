import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';
import '../services/translations/dialogue_service.dart';

class UserProvider with ChangeNotifier {
  late Users? _user;

  bool doesUserNeedToSignIn = false;

  Future<void> initUser(BuildContext context) async {
    try {
      _user = await LocalStorageService.getUser();
    } catch (e) {
      debugPrint(e.toString());
      _user = null;
    }

    Future.delayed(const Duration(seconds: 5), () {
      if (hasUser()) {
        NavigationService.goToHomeScreen();
      } else {
        setDoesUserNeedToSignIn(true);
      }
    });
  }

  void setUser(Users user) {
    _user = user;
    notifyListeners();
  }

  void setDoesUserNeedToSignIn(bool value) {
    doesUserNeedToSignIn = value;
    notifyListeners();
  }

  void handleUserAvatarOnTap(Users user) {
    if (isMe(user.id)) {
      NavigationService.goToProfileScreen();
    } else {
      // TODO show avatar dialog
    }
  }

  String getUserPseudonym() {
    return _user!.psuedonym;
  }

  String getUserAvatar() {
    return _user!.avatar;
  }

  bool hasUser() {
    return _user != null;
  }

  bool isMe(String id) {
    return id == _user!.id;
  }

  bool hasOngoingGames() {
    return _user!.onGoingGames.isNotEmpty;
  }

  int getUserOngoingGamesLength() {
    return _user!.onGoingGames.length;
  }

  Users getUser() {
    return _user!;
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
