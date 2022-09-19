import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/providers/theme_provider.dart';
import 'package:six_me_ludo_android/screens/home/home_pageview_wrapper.dart';
import 'package:six_me_ludo_android/screens/profile/profile.dart';
import 'package:six_me_ludo_android/services/authentication_service.dart';
import 'package:six_me_ludo_android/services/database_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/choice_dialog.dart';
import 'package:six_me_ludo_android/widgets/user_dialog.dart';
import 'package:uuid/uuid.dart';

import '../models/game.dart';
import '../models/user.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';
import '../services/translations/dialogue_service.dart';
import '../services/user_state_service.dart';

class UserProvider with ChangeNotifier {
  late Users? _user;
  late Stream<List<Game>> onGoingGamesStream;

  // ai player uuid
  Uuid uuid = const Uuid();

  // text editing controller
  TextEditingController pseudonymController = TextEditingController();

  Future<void> initUser(BuildContext context) async {
    late Users? tempUser;

    try {
      tempUser = await LocalStorageService.getUser();
    } catch (e) {
      debugPrint(e.toString());
      tempUser = null;
    }

    Future.delayed(const Duration(seconds: 5), () {
      if (tempUser != null) {
        setUser(tempUser, context.read<SoundProvider>());
        NavigationService.goToHomeScreen();
      } else {
        NavigationService.goToAuthScreen();
      }
    });
  }

  Future<void> updateUser(bool shouldRebuild, bool shouldUpdateOnline) async {
    if (shouldRebuild) {
      notifyListeners();
    }
    UserStateUpdateService.updateUser(_user!, shouldUpdateOnline);
  }

  void handleNewGameTap(BuildContext context) {
    GameProvider gameProvider = context.read<GameProvider>();
    AppProvider appProvider = context.read<AppProvider>();

    if (hasReachedOngoingGamesLimit()) {
      Utils.showToast(DialogueService.maxGamesText.tr);
      return;
    }

    gameProvider.hostGame(_user!, appProvider);
  }

  void initialiseOnGoingGamesStream() {
    onGoingGamesStream = DatabaseService.getOngoingGames(_user!);
  }

  void setUser(Users user, SoundProvider soundProvider) {
    _user = user;
    soundProvider.setPrefersSound(_user!.settings.prefersAudio);
    initialiseOnGoingGamesStream();
    notifyListeners();
  }

  void syncOnGoingGamesList(List<Game> games) {
    _user!.onGoingGames = [];

    for (Game element in games) {
      if (!element.kickedPlayers.contains(_user!.id) || !(element.players[element.players.indexWhere((element) => element.id == _user!.id)].hasLeft)) {
        _user!.onGoingGames.add(element);
      }
    }

    _user!.onGoingGames.sort((b, a) => a.lastUpdatedAt.compareTo(b.lastUpdatedAt));
  }

  Future<void> handleUserAvatarOnTap(String id, BuildContext context) async {
    if (isMe(id)) {
      if (Get.currentRoute == HomePageViewWrapper.routeName) {
        context.read<NavProvider>().setBottomNavBarIndex(ProfileScreen.routeIndex, true);
      } else {
        Utils.showToast(DialogueService.youText.tr);
      }
    } else {
      showUserDialog(user: (await DatabaseService.getUser(id))!, context: context);
    }
  }

  void toggleDarkMode(BuildContext context, bool value) {
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    _user!.settings.prefersDarkMode = value;
    themeProvider.toggleDarkMode(_user!.settings.prefersDarkMode);
    updateUser(true, true);
  }

  void toggleAudio(BuildContext context, bool value) {
    SoundProvider soundProvider = context.read<SoundProvider>();
    _user!.settings.prefersAudio = value;
    soundProvider.setPrefersSound(_user!.settings.prefersAudio);
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

  void setAvatar(String avatar) {
    _user!.avatar = avatar;
    updateUser(true, true);
    DatabaseService.updateOngoingGamesAfterUserChange(_user!);
  }

  void setPseudonymControllerValue(String value) {
    pseudonymController.text = value;
  }

  void setUserPseudonym() {
    String value = pseudonymController.text.trim();

    if (value == _user!.psuedonym) {
      NavigationService.genericGoBack();
      return;
    }

    if (value.length < AppConstants.minPseudonymLength) {
      Utils.showToast(DialogueService.tooShortText.tr);
      return;
    }

    if (value.length > AppConstants.maxPseudonymLength) {
      Utils.showToast(DialogueService.tooLongText.tr);
      return;
    }

    if (Utils.isStringProfane(value)) {
      Utils.showToast(DialogueService.profaneStringText.tr);
      return;
    }

    _user!.psuedonym = value;
    pseudonymController.clear();
    updateUser(true, true);
    DatabaseService.updateOngoingGamesAfterUserChange(_user!);
    NavigationService.genericGoBack();
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

  String getUserID() {
    return _user!.id;
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

  String parseGameNameText(Player host, List<Player> players) {
    if (host.id == _user!.id) {
      switch (players.length) {
        case 1:
          return DialogueService.yourGameText.tr;
        case 2:
          return DialogueService.yourGameText.tr + DialogueService.oneOtherPlayerText.tr;
        case 3:
          return DialogueService.yourGameText.tr + DialogueService.twoOtherPlayerText.tr;
        case 4:
          return DialogueService.yourGameText.tr + DialogueService.threeOtherPlayerText.tr;
        default:
          return '';
      }
    } else {
      return host.psuedonym + DialogueService.otherPlayersGameText.tr;
    }
  }

  String parsePlayerNameText(String name) {
    return name == _user!.psuedonym ? 'You' : name;
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

  bool isAvatarSelected(String avatar) {
    return _user!.avatar == avatar;
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

  Game getOngoingGameAtIndex(int index) {
    return _user!.onGoingGames[index];
  }

  Player getOngoingGamesHostPlayerAtIndex(int index) {
    return _user!.onGoingGames[index].players[_user!.onGoingGames[index].players.indexWhere((player) => player.id == _user!.onGoingGames[index].hostId)];
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
