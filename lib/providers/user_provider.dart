import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/models/version.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/providers/theme_provider.dart';
import 'package:six_me_ludo_android/screens/home/home.dart';
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
import 'app_provider.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  late Stream<List<Game>> onGoingGamesStream;
  late List<Game> ongoingGames = [];

  //
  late String selectedAvatar;
  late List<String> avatarList;

  // ai player uuid
  Uuid uuid = const Uuid();

  // text editing controller
  TextEditingController pseudonymController = TextEditingController();

  Future<void> initUser(BuildContext context) async {
    NavProvider navProvider = context.read<NavProvider>();
    AppProvider appProvider = context.read<AppProvider>();

    await appProvider.getPackageInfo();

    AppVersion? appVersion = await DatabaseService.getAppVersion();

    if (appVersion != null && appProvider.isVersionUpToDate(appVersion)) {
      late Users? tempUser;

      try {
        tempUser = await LocalStorageService.getUser();
      } catch (e) {
        debugPrint(e.toString());
        tempUser = null;
      }

      Future.delayed(const Duration(seconds: 4), () async {
        if (tempUser != null) {
          setUser(tempUser, appProvider, context.read<SoundProvider>());
          navProvider.setBottomNavBarIndex(HomeScreen.routeIndex, false);
          NavigationService.goToHomeScreen();
        } else {
          NavigationService.goToAuthScreen();
        }
      });
    } else {
      NavigationService.goToUpgradeScreen();
    }
  }

  Future<void> updateUser(bool shouldRebuild, bool shouldUpdateOnline) async {
    if (shouldRebuild) {
      notifyListeners();
    }

    UserStateUpdateService.updateUser(_user!, shouldUpdateOnline);
  }

  Future<void> setAndUpdateUser(Users user, bool shouldRebuild, bool shouldUpdateOnline) async {
    _user = user;

    if (shouldRebuild) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }

    await UserStateUpdateService.updateUser(_user!, shouldUpdateOnline);
  }

  void handleNewGameTap() {
    if (hasReachedOngoingGamesLimit()) {
      Utils.showToast(DialogueService.maxGamesText.tr);
      return;
    }

    NavigationService.goToNewGameScreen();
  }

  void setUser(Users? user, AppProvider appProvider, SoundProvider soundProvider) {
    _user = user;
    _user!.appVersion = appProvider.getAppVersion();
    _user!.appBuildNumber = appProvider.getAppBuildNumber();

    onGoingGamesStream = DatabaseService.getOngoingGamesStream(_user!.id);
    soundProvider.setPrefersSound(_user!.settings.prefersAudio);

    notifyListeners();
  }

  void intialiseAvatarList(bool shouldRebuild) {
    avatarList = Utils.generateAvatarSelectionCodes(getUserAvatar());

    selectedAvatar = _user!.avatar;

    if (shouldRebuild) {
      notifyListeners();
    }
  }

  void syncOngoingGamesStreamData(List<Game> games) {
    ongoingGames = games;
  }

  bool shouldGameShow(Game game) {
    return !game.kickedPlayers.contains(_user!.id) || !(game.players[game.players.indexWhere((element) => element.id == _user!.id)].hasLeft);
  }

  bool isUserInitialised() {
    return _user != null;
  }

  Future<void> handleUserAvatarOnTap(String? id, BuildContext context) async {
    if (id == null) {
      return;
    } else {
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

  void toggleWakelock(BuildContext context, bool value) {
    _user!.settings.prefersWakelock = value;
    updateUser(true, true);
  }

  Future<void> setCustomTheme(FlexScheme flexScheme, BuildContext context) async {
    //NavigationService.genericGoBack();
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    _user!.settings.theme = flexScheme.name;
    themeProvider.setTheme(_user!.settings.prefersDarkMode, flexScheme);
    Utils.showToast(DialogueService.setThemeToValueText.tr + flexScheme.name.capitalizeFirst!);
    await updateUser(true, true);
  }

  Future<void> setThemeToRandom(BuildContext context) async {
    NavigationService.genericGoBack();
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    _user!.settings.theme = '';
    themeProvider.setTheme(_user!.settings.prefersDarkMode, themeProvider.getScheme());
    Utils.showToast(DialogueService.setThemeToRandomText.tr);
    await updateUser(true, true);
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
    if (avatar != _user!.avatar) {
      _user!.avatar = avatar;
      updateUser(true, true);
      DatabaseService.updateOngoingGamesAfterUserChange(_user!);
    }
  }

  void setSelectedAvatar(String avatar) {
    selectedAvatar = avatar;
    notifyListeners();
  }

  void setPseudonymControllerValue(String value, bool shouldRebuild) {
    if (shouldRebuild) {
      notifyListeners();
    } else {
      pseudonymController.text = value;
    }
  }

  void setUserPseudonym() {
    String value = pseudonymController.text.trim();

    if (value.isEmpty) {
      return;
    }

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

  void handleWakelockLogic(bool value) {
    if (getUserWakelock()) {
      Utils.setWakeLock(value);
    }
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

  String getAppVersion() {
    return _user!.appVersion;
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

  String getThemeName() {
    if (_user!.settings.theme == '') {
      return DialogueService.randomThemeText.tr;
    } else {
      return DialogueService.currentThemeText.tr + Utils.convertToTitleCase(_user!.settings.theme);
    }
  }

  String parseGameNameText(Player host, List<Player> players) {
    String gameName = '';
    bool isHost = host.id == _user!.id;

    gameName += isHost ? DialogueService.yourGameText.tr : Utils.parsePsuedonymName(host.psuedonym);

    switch (players.length) {
      case 1:
        gameName += DialogueService.oneOtherPlayerText.tr;
        break;
      case 2:
        gameName += DialogueService.twoOtherPlayerText.tr;
        break;
      case 3:
        gameName += DialogueService.threeOtherPlayerText.tr;
        break;
      case 4:
        gameName += DialogueService.fourOtherPlayerText.tr;
        break;
      default:
        break;
    }

    gameName += DialogueService.gameText.tr;

    return gameName;
  }

  String parsePlayerNameText(String name) {
    return name == _user!.psuedonym ? 'You' : name;
  }

  String getUserEmail() {
    return _user!.email;
  }

  bool hasUser() {
    return _user != null;
  }

  bool isMe(String id) {
    return id == _user!.id;
  }

  bool isUserAnon() {
    return _user!.isAnon;
  }

  bool hasReachedOngoingGamesLimit() {
    return ongoingGames.length >= AppConstants.maxOngoingGamesNumber;
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

  bool isThemeSelected(String value) {
    return _user!.settings.theme == value;
  }

  bool getUserProfaneMessages() {
    return _user!.settings.prefersProfanity;
  }

  bool getUserWakelock() {
    return _user!.settings.prefersWakelock;
  }

  bool isAvatarSelected(String avatar) {
    return selectedAvatar == avatar;
  }

  bool isGameOffline() {
    return _user!.settings.maxPlayers == 1;
  }

  bool hasUserPseudonymChanged() {
    return _user!.psuedonym != pseudonymController.text && pseudonymController.text.isNotEmpty;
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

  Player getOngoingGamesHostPlayerAtIndex(Game game) {
    return game.players[game.players.indexWhere((player) => player.id == game.hostId)];
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
