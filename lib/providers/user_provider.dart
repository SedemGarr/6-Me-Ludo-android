import 'dart:math';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/providers/theme_provider.dart';
import 'package:six_me_ludo_android/screens/home/home_screen.dart';
import 'package:six_me_ludo_android/services/authentication_service.dart';
import 'package:six_me_ludo_android/services/database_service.dart';
import 'package:six_me_ludo_android/widgets/dialogs/welcome_dialog.dart';
import 'package:six_me_ludo_android/widgets/dialogs/choice_dialog.dart';
import 'package:six_me_ludo_android/widgets/dialogs/no_internet_dialog.dart';
import 'package:six_me_ludo_android/widgets/dialogs/upgrade_dialog.dart';
import 'package:six_me_ludo_android/widgets/dialogs/user_dialog.dart';
import 'package:username_generator/username_generator.dart';
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
  Users? tempUser;
  late Stream<List<Game>> onGoingGamesStream;
  late List<Game> ongoingGames = [];

  //
  late String selectedAvatar;
  late List<String> avatarList;

  // ai player uuid
  Uuid uuid = const Uuid();

  // text editing controller
  TextEditingController pseudonymController = TextEditingController();

  static String generateRandomUserAvatar() {
    return List.generate(12, (_) => Random().nextInt(100)).join();
  }

  static String getRandomPseudonym() {
    UsernameGenerator generator = UsernameGenerator();
    generator.separator = ' ';

    String initialPseudonym = generator.generateRandom();

    String finalPseudonym = '';

    for (int i = 0; i < initialPseudonym.length; i++) {
      if (!initialPseudonym[i].isNum) {
        finalPseudonym += initialPseudonym[i];
      }
    }

    // strip out any potentially offensive words
    if (AppProvider.isStringProfane(finalPseudonym) || finalPseudonym.length > AppConstants.maxPseudonymLength) {
      return getRandomPseudonym();
    }

    return convertToTitleCase(finalPseudonym.trim());
  }

  static String convertToTitleCase(String text) {
    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each word
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Merge all words back to one String
    return capitalizedWords.join(' ');
  }

  static String getInitials(String name) {
    int numberOfWords = name.trim().split(RegExp(' +')).length;
    return name.isNotEmpty ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(numberOfWords).join() : '';
  }

  static List<String> generateAvatarSelectionCodes(String avatar) {
    List<String> avatars = [];

    for (int i = 0; i < 20; i++) {
      avatars.add(generateRandomUserAvatar());
    }

    avatars[0] = avatar;

    return avatars;
  }

  static String parsePsuedonymName(String value) {
    bool endsWithS = value[value.length - 1].toLowerCase() == 's';

    if (endsWithS) {
      value += "' ";
    } else {
      value += '\'s ';
    }

    return value;
  }

  Future<void> initUser(BuildContext context) async {
    AppProvider appProvider = context.read<AppProvider>();
    SoundProvider soundProvider = context.read<SoundProvider>();

    await appProvider.getPackageInfo();

    if (LocalStorageService.isAppOffline()) {
      offlineModeInit(appProvider, soundProvider);
      return;
    }

    if (!(await AppProvider.hasNetwork())) {
      showNoInternetDialog(context: Get.context!);
      return;
    }

    if (await appProvider.isVersionUpToDate()) {
      tempUser = await LocalStorageService.getUser();
      completeInit(appProvider, soundProvider);
    } else {
      showUpgradeDialog(context: context);
    }
  }

  void completeInit(AppProvider appProvider, SoundProvider soundProvider) {
    Future.delayed(AppConstants.lottieDuration, () async {
      if (tempUser != null) {
        setUser(tempUser, appProvider, soundProvider);
        NavigationService.goToHomeScreen();
      } else {
        showWelcomeDialog(context: Get.context!);
      }
    });
  }

  void offlineModeInit(AppProvider appProvider, SoundProvider soundProvider) async {
    tempUser = await LocalStorageService.getUser();
    completeInit(appProvider, soundProvider);
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

  void handleNewGameTap(BuildContext context) {
    if (hasReachedOngoingGamesLimit()) {
      AppProvider.showToast(DialogueService.maxGamesText.tr);
      return;
    }

    NavigationService.goToNewGameScreen();
  }

  void assignUser(Users? user) {
    _user = user;
  }

  void setUser(Users? user, AppProvider appProvider, SoundProvider soundProvider) {
    assignUser(user);
    _user!.appVersion = appProvider.getAppVersion();
    _user!.appBuildNumber = appProvider.getAppBuildNumber();

    tempUser = _user;

    onGoingGamesStream = DatabaseService.getOngoingGamesStream(_user!.id);

    notifyListeners();
  }

  void intialiseAvatarList(bool shouldRebuild) {
    avatarList = generateAvatarSelectionCodes(getUserAvatar());

    selectedAvatar = _user!.avatar;

    if (shouldRebuild) {
      notifyListeners();
    }
  }

  void syncOngoingGamesStreamData(List<Game> games) {
    ongoingGames = games;
  }

  void removeGameFromOngoingGamesList(Game game) {
    ongoingGames.removeWhere((element) => element.id == game.id);
    notifyListeners();
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
        if (Get.currentRoute == HomeScreen.routeName) {
          NavigationService.goToEditAvatarScreen();
        } else {
          AppProvider.showToast(DialogueService.youText.tr);
        }
      } else {
        showUserDialog(user: (await DatabaseService.getUser(id))!, context: context);
      }
    }
  }

  void setOfflineMode(bool value) async {
    _user!.settings.isOffline = value;
    AppProvider.showToast(value ? DialogueService.offlineModeToastOnText.tr : DialogueService.offlineModeToastOffText.tr);
    updateUser(true, true);

    AppProvider appProvider = Get.context!.read<AppProvider>();
    if (!(await appProvider.isVersionUpToDate())) {
      showUpgradeDialog(context: Get.context!);
    }
  }

  void toggleDarkMode(BuildContext context, bool value) {
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    _user!.settings.prefersDarkMode = value;
    themeProvider.toggleDarkMode(_user!.settings.prefersDarkMode);
    updateUser(true, true);
  }

  void toggleOfflineMode(BuildContext context, bool value) {
    if (value) {
      showOfflineDialog(context);
      return;
    }

    _user!.settings.isOffline = value;
    AppProvider.showToast(value ? DialogueService.offlineModeToastOnText.tr : DialogueService.offlineModeToastOffText.tr);
    syncUser(true);
  }

  void toggleAudio(BuildContext context, bool value) {
    _user!.settings.prefersAudio = value;

    updateUser(true, true);

    if (value) {
      AppProvider.showToast(DialogueService.zapsplatText.tr);
    }
  }

  void toggleMusic(BuildContext context, bool value) {
    _user!.settings.prefersMusic = value;

    updateUser(true, true);

    if (value) {
      AppProvider.showToast(DialogueService.zapsplatText.tr);
    }
  }

  void toggleAdaptiveAI(BuildContext context, bool value) {
    _user!.settings.prefersAdaptiveAI = value;
    updateUser(true, true);
  }

  void toggleAddAI(BuildContext context, bool value) {
    if (getUserIsOffline()) {
      return;
    }

    if (_user!.settings.maxPlayers == 1) {
      _user!.settings.prefersAddAI = true;
    } else if (_user!.settings.maxPlayers == 4) {
      _user!.settings.prefersAddAI = false;
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

  void toggleIsPrivate(BuildContext context, bool value) {
    _user!.isPrivate = value;
    updateUser(true, true);
  }

  void toggleVibrate(BuildContext context, bool value) {
    _user!.settings.prefersVibrate = value;
    updateUser(true, true);
  }

  Future<void> setCustomTheme(FlexScheme flexScheme, BuildContext context) async {
    //NavigationService.genericGoBack();
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    _user!.settings.theme = flexScheme.name;
    themeProvider.setTheme(_user!.settings.prefersDarkMode, flexScheme);
    await updateUser(true, true);
  }

  Future<void> setThemeToRandom(BuildContext context) async {
    NavigationService.genericGoBack();
    ThemeProvider themeProvider = context.read<ThemeProvider>();
    _user!.settings.theme = '';
    themeProvider.setTheme(_user!.settings.prefersDarkMode, themeProvider.getRandomScheme());
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
      AppProvider.showToast(DialogueService.tooShortText.tr);
      return;
    }

    if (value.length > AppConstants.maxPseudonymLength) {
      AppProvider.showToast(DialogueService.tooLongText.tr);
      return;
    }

    if (AppProvider.isStringProfane(value)) {
      AppProvider.showToast(DialogueService.profaneStringText.tr);
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
      AppProvider.setWakeLock(value);
    }
  }

  void syncUser(bool shouldRebuild) async {
    if (!getUserIsOffline()) {
      if (shouldRebuild) {
        notifyListeners();
      }

      Users? tempUser = await DatabaseService.getUser(_user!.id);

      if (tempUser != null) {
        if (_user!.stats.counter < tempUser.stats.counter) {
          _user!.stats = tempUser.stats;
          _user!.rankingValue = tempUser.rankingValue;
          LocalStorageService.setUser(_user!);
        } else if (_user!.stats.counter > tempUser.stats.counter) {
          updateUser(shouldRebuild, true);
        }
      }
    }
  }

  void showOfflineDialog(BuildContext context) {
    showChoiceDialog(
      titleMessage: DialogueService.offlineModeTitleText.tr,
      contentMessage: DialogueService.offlineModeContentText.tr,
      yesMessage: DialogueService.offlineModeYesText.tr,
      noMessage: DialogueService.offlineModeNoText.tr,
      onYes: () {
        setOfflineMode(true);
      },
      onNo: () {},
      context: context,
    );
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

  void showConvertAccountDialog(BuildContext context) {
    showChoiceDialog(
      titleMessage: DialogueService.convertAccountDialogTitleText.tr,
      contentMessage: DialogueService.convertAccountDialogContentText.tr,
      yesMessage: DialogueService.convertAccountDialogYesText.tr,
      noMessage: DialogueService.convertAccountDialogNoText.tr,
      onYes: () {
        AuthenticationService.convertToGoogle(context);
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
        AuthenticationService.deleteAccount(true);
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
    return Player.getPlayerReputationName(_user!.reputationValue);
  }

  String getUserPersonalityPreference() {
    return _user!.settings.aiPersonalityPreference;
  }

  String getThemeName() {
    if (_user!.settings.theme == '') {
      return DialogueService.randomThemeText.tr;
    } else {
      return DialogueService.currentThemeText.tr + convertToTitleCase(_user!.settings.theme);
    }
  }

  String parseGameNameText(Player host, List<Player> players) {
    String gameName = '';
    bool isHost = host.id == _user!.id;

    gameName += isHost ? DialogueService.yourGameText.tr : parsePsuedonymName(host.psuedonym);

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

  String parseNumberOfGamesText(int value) {
    if (value < 25) {
      return DialogueService.numberOfGamesNoobText.tr;
    } else if (value < 50) {
      return DialogueService.numberOfGamesExperiencedText.tr;
    } else if (value < 100) {
      return DialogueService.numberOfGamesVeteranText.tr;
    }

    return DialogueService.numberOfGamesSleepText.tr;
  }

  String parsePercentageFinishedText(double value) {
    if (value < 25) {
      return DialogueService.percentageFinishedNoobText.tr;
    } else if (value < 50) {
      return DialogueService.percentageFinishedExperiencedText.tr;
    } else if (value < 75) {
      return DialogueService.percentageFinishedVeteranText.tr;
    }

    return DialogueService.percentageFinishedSleepText.tr;
  }

  String parsePercentageWonText(double value) {
    if (value < 25) {
      return DialogueService.percentageWonNoobText.tr;
    } else if (value < 50) {
      return DialogueService.percentageWonExperiencedText.tr;
    } else if (value < 75) {
      return DialogueService.percentageWonVeteranText.tr;
    }

    return DialogueService.percentageWonSleepText.tr;
  }

  String parsePercentageHumanText(double value) {
    if (value < 25) {
      return DialogueService.percentageHumanNoobText.tr;
    } else if (value < 50) {
      return DialogueService.percentageHumanExperiencedText.tr;
    } else if (value < 75) {
      return DialogueService.percentageHumanVeteranText.tr;
    }

    return DialogueService.percentageHumanSleepText.tr;
  }

  String parsePercentagePunchingBagText(double value) {
    if (value < 25) {
      return DialogueService.percentagePunchingBagNoobText.tr;
    } else if (value < 50) {
      return DialogueService.percentagePunchingBagExperiencedText.tr;
    } else if (value < 75) {
      return DialogueService.percentagePunchingBagVeteranText.tr;
    }

    return DialogueService.percentagePunchingBagSleepText.tr;
  }

  String parsePercentageViciousText(double value) {
    if (value < 25) {
      return DialogueService.percentageViciousNoobText.tr;
    } else if (value < 50) {
      return DialogueService.percentageViciousExperiencedText.tr;
    } else if (value < 75) {
      return DialogueService.percentageViciousVeteranText.tr;
    }

    return DialogueService.percentageViciousSleepText.tr;
  }

  String parsePercentageMixedText(double value) {
    if (value < 25) {
      return DialogueService.percentageMixedNoobText.tr;
    } else if (value < 50) {
      return DialogueService.percentageMixedExperiencedText.tr;
    } else if (value < 75) {
      return DialogueService.percentageMixedVeteranText.tr;
    }

    return DialogueService.percentageMixedSleepText.tr;
  }

  String parsePercentageAIText(double value) {
    if (value < 25) {
      return DialogueService.percentageAINoobText.tr;
    } else if (value < 50) {
      return DialogueService.percentageAIExperiencedText.tr;
    } else if (value < 75) {
      return DialogueService.percentageAIVeteranText.tr;
    }

    return DialogueService.percentageAISleepText.tr;
  }

  String parseFavouriteColorText(int value) {
    try {
      return PlayerConstants.swatchListNames[value];
    } catch (e) {
      return '';
    }
  }

  String parseCummulativeTimeText(String value) {
    Duration duration = GameProvider.convertCummulativeTimeToDuration(value);

    if (duration.inHours < const Duration(hours: 48).inHours) {
      return DialogueService.cummulativeTimeNoobText.tr;
    } else if (duration.inHours < const Duration(hours: 96).inHours) {
      return DialogueService.cummulativeTimeExperiencedText.tr;
    } else if (duration.inHours < const Duration(hours: 192).inHours) {
      return DialogueService.cummulativeTimeVeteranText.tr;
    }

    return DialogueService.cummulativeTimeSleepText.tr;
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

  bool getUserIsOffline() {
    return _user!.settings.isOffline;
  }

  static bool isUserOfflineStatic() {
    BuildContext context = Get.context!;
    UserProvider userProvider = context.read<UserProvider>();
    return userProvider.getUserIsOffline();
  }

  bool getUserAudio() {
    return _user!.settings.prefersAudio;
  }

  bool getUserMusic() {
    return _user!.settings.prefersMusic;
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

  bool getUserIsPrivate() {
    return _user!.isPrivate;
  }

  bool getUserVibrate() {
    return _user!.settings.prefersVibrate;
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

  int getGameIndex(Game game) {
    return ongoingGames.indexWhere((element) => element.id == game.id);
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

  void rebuild() {
    notifyListeners();
  }
}
