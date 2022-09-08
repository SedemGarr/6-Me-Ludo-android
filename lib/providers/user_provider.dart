import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/theme_provider.dart';
import 'package:six_me_ludo_android/services/authentication_service.dart';
import 'package:six_me_ludo_android/services/database_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/choice_dialog.dart';
import 'package:six_me_ludo_android/widgets/user_dialog.dart';

import '../models/game.dart';
import '../models/user.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';
import '../services/translations/dialogue_service.dart';
import '../services/user_state_service.dart';

class UserProvider with ChangeNotifier {
  late Users? _user;
  late Stream<List<Game>> onGoingGamesStream;

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
        initialiseOnGoingGamesStream();
        NavigationService.goToHomeScreen();
      } else {
        setDoesUserNeedToSignIn(true);
      }
    });
  }

  Future<void> updateUser(bool shouldRebuild, bool shouldUpdateOnline) async {
    if (shouldRebuild) {
      notifyListeners();
    }
    UserStateUpdateService.updateUser(_user!, shouldUpdateOnline);
  }

  void handleNewGameTap() {
    if (hasReachedOngoingGamesLimit()) {
      Utils.showToast(DialogueService.maxGamesText.tr);
      return;
    }

    NavigationService.goToNewGameScreen();
  }

  void initialiseOnGoingGamesStream() {
    onGoingGamesStream = DatabaseService.getOngoingGames(_user!);
  }

  void setUser(Users user) {
    _user = user;
    notifyListeners();
  }

  void setDoesUserNeedToSignIn(bool value) {
    doesUserNeedToSignIn = value;
    notifyListeners();
  }

  void syncOnGoingGamesList(List<Game> games) {
    _user!.onGoingGames = games;
  }

  void handleUserAvatarOnTap(Users user, BuildContext context) {
    if (isMe(user.id)) {
      NavigationService.goToProfileScreen();
    } else {
      showUserDialog(user: user, context: context);
    }
  }

  void toggleDarkMode(BuildContext context, bool value) {
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    _user!.settings.prefersDarkMode = value;
    themeProvider.toggleDarkMode(_user!.settings.prefersDarkMode);
    updateUser(true, true);
  }

  void toggleAudio(BuildContext context, bool value) {
    _user!.settings.prefersAudio = value;
    updateUser(true, true);
  }

  void toggleAdaptiveAI(BuildContext context, bool value) {
    _user!.settings.prefersAdaptiveAI = value;
    updateUser(true, true);
  }

  void toggleAddAI(BuildContext context, bool value) {
    if (_user!.settings.maxPlayers == 1) {
      _user!.settings.prefersAddAI = true;
    } else {
      _user!.settings.prefersAddAI = value;
    }
    updateUser(true, true);
  }

  void toggleAutoStart(BuildContext context, bool value) {
    _user!.settings.prefersAutoStart = value;
    updateUser(true, true);
  }

  void toggleCatchUpAssist(BuildContext context, bool value) {
    _user!.settings.prefersCatchupAssist = value;
    updateUser(true, true);
  }

  void toggleStartAssist(BuildContext context, bool value) {
    _user!.settings.prefersStartAssist = value;
    updateUser(true, true);
  }

  void toggleProfaneMessages(BuildContext context, bool value) {
    _user!.settings.prefersProfanity = value;
    updateUser(true, true);
  }

  void setLanguageCode(Locale locale) {
    if (locale.languageCode != parseUserLocale(_user!.settings.locale).languageCode) {
      _user!.settings.locale = locale.toString();

      Get.updateLocale(locale);
      updateUser(true, true);
    }
  }

  void setGameSpeed(int value) {
    _user!.settings.preferredSpeed = value;
    updateUser(true, true);
  }

  void setHumanPlayerNumber(int value, BuildContext context) {
    _user!.settings.maxPlayers = value;

    toggleAddAI(context, !(value == 4));

    updateUser(true, true);
  }

  void setPersonalityPreference(String value) {
    _user!.settings.aiPersonalityPreference = value;
    updateUser(true, true);
  }

  void showSignOutDialog(BuildContext context) {
    showChoiceDialog(
      titleMessage: DialogueService.signOutDialogTitleText.tr,
      contentMessage: DialogueService.signOutDialogContentText.tr,
      yesMessage: DialogueService.signOutDialogYesText.tr,
      noMessage: DialogueService.signOutDialogNoText.tr,
      onYes: () {
        AuthenticationService.signOut(_user!, context);
      },
      onNo: () {},
      context: context,
    );
  }

  void showDeleteAccountDialog(BuildContext context) {
    showChoiceDialog(
      titleMessage: DialogueService.deleteAccountDialogTitleText.tr,
      contentMessage: DialogueService.deleteAccountDialogContentText.tr,
      yesMessage: DialogueService.deleteAccountDialogYesText.tr,
      noMessage: DialogueService.deleteAccountDialogNoText.tr,
      onYes: () {
        AuthenticationService.deleteAccount(_user!, context);
      },
      onNo: () {},
      context: context,
    );
  }

  String getUserPseudonym() {
    return _user!.psuedonym;
  }

  String getUserAvatar() {
    return _user!.avatar;
  }

  String getUserReputationValueAsString() {
    return _user!.reputationValue.toString();
  }

  String getUserPersonalityPreference() {
    return _user!.settings.aiPersonalityPreference;
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

  bool hasReachedOngoingGamesLimit() {
    return _user!.onGoingGames.length >= AppConstants.maxOngoingGamesNumber;
  }

  bool getUserDarkMode() {
    return _user!.settings.prefersDarkMode;
  }

  bool getUserAudio() {
    return _user!.settings.prefersAudio;
  }

  bool getUserAdaptiveAI() {
    return _user!.settings.prefersAdaptiveAI;
  }

  bool getUserAddAI() {
    return _user!.settings.prefersAddAI;
  }

  bool getUserAutoStart() {
    return _user!.settings.prefersAutoStart;
  }

  bool getUserCatchUpAssist() {
    return _user!.settings.prefersCatchupAssist;
  }

  bool getUserStartAssist() {
    return _user!.settings.prefersStartAssist;
  }

  bool getUserProfaneMessages() {
    return _user!.settings.prefersProfanity;
  }

  int getUserOngoingGamesLength() {
    return _user!.onGoingGames.length;
  }

  int getUserGameSpeed() {
    return _user!.settings.preferredSpeed;
  }

  int getUserReputationValue() {
    return _user!.reputationValue;
  }

  int getUserHumanPlayerNumber() {
    return _user!.settings.maxPlayers;
  }

  Users getUser() {
    return _user!;
  }

  List<Game> getUserOngoingGames() {
    return _user!.onGoingGames;
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
