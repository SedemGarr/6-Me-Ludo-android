import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';

import 'english.dart';

class DialogueService extends Translations {
  static const Locale englishUS = Locale('en', 'US');

  static const List<Map<String, dynamic>> locales = [
    {
      'locale': englishUS,
      'name': 'English',
    },
  ];

  static List<DropdownMenuItem<dynamic>> getLocaleDropDownMenuItems(BuildContext context) {
    return locales
        .map(
          (e) => DropdownMenuItem(
            value: e['locale'].languageCode,
            child: Text(
              e['name'],
              style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onBackground),
            ),
          ),
        )
        .toList();
  }

  /// ------------------------------------------------------

  static const String appName = 'appName';
  static const String genericErrorText = 'genericErrorText';
  static const String noInternetErrorTitleText = 'noInternetErrorTitleText';
  static const String noInternetErrorContentText = 'noInternetErrorContentText';
  static const String noInternetErrorSnackbarText = 'noInternetErrorSnackbarText';
  static const String animationByText = 'animationByText';
  static const String licenceText = 'licenceText';
  static const String licenceShortText = 'licenceShortText';
  static const String signUpLegalese = 'signUpLegalese';
  static const String termsText = 'termsText';
  static const String privacyText = 'privacyText';
  static const String privacyShortText = 'privacyShortText';
  static const String cookieText = 'cookieText';
  static const String signInWithGoogleText = 'signInWithGoogleText';
  static const String andText = 'andText';
  static const String versionText = 'versionText';
  static const String copyrightText = 'copyrightText';
  static const String wayyyoutGamesText = 'wayyyoutGamesText';
  static const String zapsplatText = 'zapsplatText';
  static const String updateNeededText = 'updateNeededText';
  static const String updatePromptText = 'updatePromptText';
  static const String updateButtonText = 'updateButtonText';
  static const String signInRequiredText = 'signInRequiredText';
  static const String authDialogContentText = 'authDialogContentText';
  static const String beginText = 'beginText';
  static const String doneText = 'doneText';
  static const String restartAppYesText = 'restartAppYesText';
  // loading strings
  static const String loading1Text = 'loading1Text';
  static const String loading2Text = 'loading2Text';
  static const String loading3Text = 'loading3Text';
  static const String loading4Text = 'loading4Text';
  static const String loading5Text = 'loading5Text';
  static const String loading6Text = 'loading6Text';
  static const String loading7Text = 'loading7Text';
  static const String loading8Text = 'loading8Text';
  static const String loading9Text = 'loading9Text';
  static const String loading10Text = 'loading10Text';
  static const String loadingDefaultText = 'loadingDefaultText';

// welcome strings
  static const String welcome1Text = 'welcome1Text';
  static const String welcome2Text = 'welcome2Text';
  static const String welcome3Text = 'welcome3Text';
  static const String welcome4Text = 'welcome4Text';
  static const String welcome5Text = 'welcome5Text';
  static const String welcome6Text = 'welcome6Text';
  static const String welcome7Text = 'welcome7Text';
  static const String welcome8Text = 'welcome8Text';
  static const String welcome9Text = 'welcome9Text';
  static const String welcome10Text = 'welcome10Text';

  // welcome dialog
  static const String welcomeBottomSheetTitleText = 'welcomeBottomSheetTitleText';
  static const String welcomeDialogContentText = 'welcomeDialogContentText';
  static const String welcomeDialogNoText = 'welcomeDialogNoText';
  static const String welcomeDialogYesText = 'welcomeDialogYesText';
  static const String signInGoogleText = 'signInGoogleText';
  static const String signInAnonText = 'signInAnonText';
  static const String anonWarningText = 'anonWarningText';
  static const String welcomeEmojiText = 'welcomeEmojiText';
  static const String welcomeSubtileText = 'welcomeSubtileText';
  //
  static const String anonSignInTitleText = 'anonSignInTitleText';
  static const String anonSignInYesText = 'anonSignInYesText';
  static const String anonSignInNoText = 'anonSignInNoText';

  // welcome error
  static const String noUserSelectedText = 'noUserSelectedText';
  // home
  static const String welcomeText = 'welcomeText';
  static const String newGameText = 'newGameText';
  static const String profileAndSettingsText = 'profileAndSettingsText';
  static const String profileText = 'profileText';
  static const String editProfileText = 'editProfileText';
  static const String homeText = 'homeText';
  static const String ongoingGamesText = 'ongoingGamesText';
  static const String newGamesText = 'newGamesText';
  static const String createNewGameText = 'createNewGameText';
  // game - starting
  static const String newGameAppBarTitleText = 'newGameAppBarTitleText';
  static const String startGameButtonText = 'startGameButtonText';
  static const String joinGameButtonText = 'joinGameButtonText';
  static const String orButtonText = 'orButtonText';
  static const String noGamesText = 'noGamesText';
  static const String noLocalGamesText = 'noLocalGamesText';
  static const String maxGamesText = 'maxGamesText';
  static const String hostGameFABText = 'hostGameFABText';
  static const String joinGameFABText = 'joinGameFABText';
  static const String joinGameHintText = 'joinGameHintText';
  static const String joinGameBannerText = 'joinGameBannerText';
  static const String hostGameBannerText = 'hostGameBannerText';
  static const String gameVersionMismatchText = 'gameVersionMismatchText';
  // game - ongoing
  static const String inAFewSecondsText = 'inAFewSecondsText';
  static const String yourGameText = 'yourGameText';
  static const String otherPlayersGameText = 'otherPlayersGameText';
  static const String oneOtherPlayerText = 'oneOtherPlayerText';
  static const String twoOtherPlayerText = 'twoOtherPlayerText';
  static const String threeOtherPlayerText = 'threeOtherPlayerText';
  static const String fourOtherPlayerText = 'fourOtherPlayerText';
  static const String gameText = 'gameText';
  static const String humanPlayerText = 'humanPlayerText';
  static const String humanPlayerCaptialText = 'humanPlayerCaptialText';
  static const String aiPlayerText = 'aiPlayerText';
  static const String rejoinGameDialogTitleText = 'rejoinGameDialogTitleText';
  static const String rejoinGameDialogContentText = 'rejoinGameDialogContentText';
  static const String rejoinGameDialogYesText = 'rejoinGameDialogYesText';
  static const String rejoinGameDialogNoText = 'rejoinGameDialogNoText';
  static const String deleteGameDialogTitleText = 'deleteGameDialogTitleText';
  static const String deleteGameDialogContentText = 'deleteGameDialogContentText';
  static const String deleteGameDialogYesText = 'deleteGameDialogYesText';
  static const String deleteGameDialogNoText = 'deleteGameDialogNoText';
  static const String leaveGameDialogTitleText = 'leaveGameDialogTitleText';
  static const String leaveGameDialogContentText = 'leaveGameDialogContentText';
  static const String leaveGameDialogYesText = 'leaveGameDialogYesText';
  static const String leaveGameDialogNoText = 'leaveGameDialogNoText';
  static const String gameDoesNotExistText = 'gameDoesNotExistText';
  static const String gameFullText = 'gameFullText';
  static const String gameKickedText = 'gameKickedText';
  static const String gameDeletedToastText = 'gameDeletedToastText';
  static const String lastPlayedAtText = 'lastPlayedAtText';
  static const String createdAtText = 'createdAtText';
  static const String playerHasLeftTheGame = 'playerHasLeftTheGame';
  // game - playing
  static const String skipTurnText = 'skipTurnText';
  static const String playerTabText = 'playerTabText';
  static const String boardTabText = 'boardTabText';
  static const String chatTabText = 'chatTabText';
  static const String gameDeletedText = 'gameDeletedText';
  static const String sendMessagesHereText = 'sendMessagesHereText';
  static const String playerBannedBannerText = 'playerBannedBannerText';
  static const String reorderPlayersBannerText = 'reorderPlayersBannerText';
  static const String profaneMessageText = 'profaneMessageText';
  static const String chatLimitReachedText = 'chatLimitReachedText';
  static const String restartGameText = 'restartGameText';
  static const String yourGameHasBeenRestartedText = 'yourGameHasBeenRestartedText';
  static const String restartGameDialogTitleText = 'restartGameDialogTitleText';
  static const String restartGameDialogContentText = 'restartGameDialogContentText';
  static const String restartGameDialogYesText = 'restartGameDialogYesText';
  static const String restartGameDialogNoText = 'restartGameDialogNoText';
  static const String startGameGamPageButtonText = 'startGameGamPageButtonText';
  static const String endSessionText = 'endSessionText';
  static const String copyGameTooltipText = 'copyGameTooltipText';
  static const String endGameTooltipText = 'endGameTooltipText';
  static const String leaveGameTooltipText = 'leaveGameTooltipText';
  static const String shareGameText = 'shareGameText';
  static const String shareGameEmailText = 'shareGameEmailText';
  static const String gameIDCopiedToClipboardText = 'gameIDCopiedToClipboardText';
  static const String playerHasLeftText = 'playerHasLeftText';
  static const String playerHasJoinedText = 'playerHasJoinedText';
  static const String gameHasStartedText = 'gameHasStartedText';
  static const String gameSettingsChangedText = 'gameSettingsChangedText';
  static const String gameHasRestarted = 'gameHasRestarted';
  static const String messageContainsProfanityText = 'messageContainsProfanityText';
  static const String playerIsPresentText = 'playerIsPresentText';
  static const String playerIsNotPresentText = 'playerIsNotPresentText';
  static const String messageDeletedSubtitleText = 'messageDeletedSubtitleText';
  static const String playerBannedText = 'playerBannedText';
  static const String playerUnBannedText = 'playerUnBannedText';
  static const String messageBannedText = 'messageBannedText';
  static const String playerKickedFromGameText = 'playerKickedFromGameText';
  static const String banPlayerDialogTitleText = 'banPlayerDialogTitleText';
  static const String banPlayerDialogContentText = 'banPlayerDialogContentText';
  static const String banPlayerDialogYesText = 'banPlayerDialogYesText';
  static const String banPlayerDialogNoText = 'banPlayerDialogNoText';
  static const String kickPlayerDialogTitleText = 'kickPlayerDialogTitleText';
  static const String kickPlayerDialogContentText = 'kickPlayerDialogContentText';
  static const String kickPlayerDialogYesText = 'kickPlayerDialogYesText';
  static const String kickPlayerDialogNoText = 'kickPlayerDialogNoText';
  static const String playerKickedFromGameTrailingText = 'playerKickedFromGameTrailingText';
  static const String passTurnButtonText = 'passTurnButtonText';
  static const String noWinnerText = 'noWinnerText';
  static const String gameWinnerText = 'gameWinnerText';
  static const String gameViciousText = 'gameViciousText';
  static const String gamePunchingBagText = 'gamePunchingBagText';
  static const String statsTitleText = 'statsTitleText';
  static const String kickSingularText = 'kickSingularText';
  static const String kickPluralText = 'kickPluralText';
  static const String kickedText = 'kickedText';
  static const String timesSingularText = 'timesSingularText';
  static const String timesPluralText = 'timesPluralText';
  static const String reputationChangedText = 'reputationChangedText';
  static const String reputationChangedPluralText = 'reputationChangedPluralText';
  static const String gameSessionLengthText = 'gameSessionLengthText';
  static const String gameSessionNumberOfTurnsText = 'gameSessionNumberOfTurnsText';
  static const String gameSessionEndedText = 'gameSessionEndedText';
  // game settings
  static const String catchUpAssistEnabledText = 'catchUpAssistEnabledText';
  static const String catchUpAssistDisabledText = 'catchUpAssistDisabledText';
  static const String startAssistEnabledText = 'startAssistEnabledText';
  static const String startAssistDisabledText = 'startAssistDisabledText';
  static const String adaptiveAIEnabledText = 'adaptiveAIEnabledText';
  static const String adaptiveAIDisabledText = 'adaptiveAIDisabledText';
  static const String hostSetAIPersonalityText = 'hostSetAIPersonalityText';
  static const String hostSetGameSpeedText = 'hostSetGameSpeedText';
  // game - controls
  static const String restartGamePopupText = 'restartGamePopupText';
  static const String startSessionPopupText = 'startSessionPopupText';
  static const String stopSessionPopupText = 'stopSessionPopupText';
  static const String endGamePopupText = 'endGamePopupText';
  static const String copyGameIDPopupText = 'copyGameIDPopupText';
  static const String shareGameIDPopupText = 'shareGameIDPopupText';
  static const String viewGameSettingsPopupText = 'viewGameSettingsPopupText';
  static const String changeGameSettingsPopupText = 'changeGameSettingsPopupText';
  // game - playing - commentary
  static const String yourTurnText = 'yourTurnText';
  static const String waitingForParticularPlayerText = 'waitingForParticularPlayerText';
  static const String youHaveRolledTheDieText = 'youHaveRolledTheDieText';
  static const String yourTurnOnceMoreText = 'yourTurnOnceMoreText';
  static const String youHaveRolledAText = 'youHaveRolledAText';
  static const String waitingForOneMoreText = 'waitingForOneMoreText';
  static const String hasRolledTheDieText = 'hasRolledTheDieText';
  static const String waitingForText = 'waitingForText';
  static const String morePlayersText = 'morePlayersText';
  static const String hasRolledAText = 'hasRolledAText';
  // profile
  static const String reputationValueText = 'reputationValueText';
  static const String changeAvatarText = 'changeAvatarText';
  static const String changePseudonymText = 'changePseudonymText';
  static const String closeDialogText = 'closeDialogText';
  static const String savePseudonymDialogText = 'savePseudonymDialogText';
  static const String changePseudonymHintText = 'changePseudonymHintText';
  static const String changePseudonymBannerText = 'changePseudonymBannerText';
  static const String changeAvatarBannerText = 'changeAvatarBannerText';
  static const String tooShortText = 'tooShortText';
  static const String tooLongText = 'tooLongText';
  static const String profaneStringText = 'profaneStringText';
  static const String youText = 'youText';
  static const String anonAccountText = 'anonAccountText';
  static const String verifiedAccountText = 'verifiedAccountText';
  static const String visibleOnlyToYouText = 'visibleOnlyToYouText';
  // settings
  static const String generalSettingsText = 'generalSettingsText';
  static const String gameSettingsText = 'gameSettingsText';
  static const String gameSettingsFullText = 'gameSettingsFullText';
  static const String accountSettingsText = 'accountSettingsText';
  static const String personalisationSettingsText = 'personalisationSettingsText';
  static const String aboutSettingsText = 'aboutSettingsText';
  // settings - max players
  static const String maxPlayersTitleText = 'maxPlayersTitleText';
  static const String maxPlayersOfflineTitleText = 'maxPlayersOfflineTitleText';
  static const String maxPlayersSubtitleText = 'maxPlayersSubtitleText';
  // settings - dark mode
  static const String darkModeTitleText = 'darkModeTitleText';
  static const String darkModeSubtitleText = 'darkModeSubtitleText';
  // settings - audio
  static const String audioTitleText = 'audioTitleText';
  static const String audioSubtitleText = 'audioSubtitleText';
  // settings - theme
  static const String themeTitleText = 'themeTitleText';
  static const String themeSubtitleText = 'themeSubtitleText';
  static const String setThemeToRandomText = 'setThemeToRandomText';
  static const String setThemeToValueText = 'setThemeToValueText';
  static const String randomThemeText = 'randomThemeText';
  static const String currentThemeText = 'curentThemeText';
  // settings - wakelock
  static const String wakelockTitleText = 'wakelockTitleText';
  static const String wakelockSubtitleText = 'wakelockSubtitleText';
  // settings - language
  static const String languageTitleText = 'languageTitleText';
  static const String languageSubtitleText = 'languageSubtitleText';
  // settings - add ai players
  static const String addAIPlayersTitleText = 'addAIPlayersTitleText';
  static const String addAIPlayersSubtitleText = 'addAIPlayersSubtitleText';
  // settings - auto start
  static const String autoStartTitleText = 'autoStartTitleText';
  static const String autoStartSubtitleText = 'autoStartSubtitleText';
  // settings - catch up assist
  static const String catchUpAssistTitleText = 'catchUpAssistTitleText';
  static const String catchUpAssistSubtitleText = 'catchUpAssistSubtitleText';
  // settings - start assist
  static const String startAssistTitleText = 'startAssistTitleText';
  static const String startAssistSubtitleText = 'startAssistSubtitleText';
  // settings - adaptive ai
  static const String adaptiveAITitleText = 'adaptiveAITitleText';
  static const String adaptiveAISubtitleText = 'adaptiveAISubtitleText';
  // settings - ai personality type
  static const String aIPersonalityTitleText = 'aIPersonalityTitleText';
  static const String aIPersonalitySubtitleText = 'aIPersonalitySubtitleText';
  static const String averagePersonalityType = 'averagePersonalityType';
  static const String pacifistPersonalityType = 'pacifistPersonalityType';
  static const String viciousPersonalityType = 'viciousPersonalityType';
  static const String randomPersonalityType = 'randomPersonalityType';
  // settings - game speed
  static const String gameSpeedTitleText = 'gameSpeedTitleText';
  static const String gameSpeedSubtitleText = 'gameSpeedSubtitleText';
  static const String gameSpeedSlowText = 'gameSpeedSlowText';
  static const String gameSpeedNormalText = 'gameSpeedNormalText';
  static const String gameSpeedFastText = 'gameSpeedFastText';
  // settings - profanity
  static const String profaneMessagesTitleText = 'profaneMessagesTitleText';
  static const String profaneMessagesSubtitleText = 'profaneMessagesSubtitleText';
  // settings - offline
  static const String offlineText = 'offlineText';
  static const String offlineModeTitleText = 'offlineModeTitleText';
  static const String offlineModeContentText = 'offlineModeContentText';
  static const String offlineModeYesText = 'offlineModeYesText';
  static const String offlineModeNoText = 'offlineModeNoText';
  static const String offlineModeToastOnText = 'offlineModeToastOnText';
  static const String offlineModeToastOffText = 'offlineModeToastOffText';
  static const String newOfflineGameText = 'newOfflineGameText';
  static const String continueOfflineGameText = 'continueOfflineGameText';
  static const String offlineJoiningGameTitleText = 'offlineJoiningGameTitleText';
  static const String offlineJoiningGameContentText = 'offlineJoiningGameContentText';
  static const String offlineJoiningGameYesText = 'offlineJoiningGameYesText';
  static const String offlineJoiningGameNoText = 'offlineJoiningGameNoText';
  // settings - sign out
  static const String signOutTitleText = 'signOutTitleText';
  static const String signOutSubtitleText = 'signOutSubtitleText';
  static const String signOutDialogTitleText = 'signOutDialogTitleText';
  static const String signOutDialogContentText = 'signOutDialogContentText';
  static const String signOutAnonDialogContentText = 'signOutAnonDialogContentText';
  static const String signOutDialogYesText = 'signOutDialogYesText';
  static const String signOutDialogNoText = 'signOutDialogNoText';
  // settings - delete account
  static const String deleteAccountTitleText = 'deleteAccountTitleText';
  static const String deleteAccountSubtitleText = 'deleteAccountSubtitleText';
  static const String deleteAccountDialogTitleText = 'deleteAccountDialogTitleText';
  static const String deleteAccountDialogContentText = 'deleteAccountDialogContentText';
  static const String deleteAccountDialogYesText = 'deleteAccountDialogYesText';
  static const String deleteAccountDialogNoText = 'deleteAccountDialogNoText';
  // settings - about
  static const String versionTitleText = 'versionTitleText';
  static const String privacyTitleText = 'privacyTitleText';
  static const String termsTitleText = 'termsTitleText';
  static const String licenseTitleText = 'licenseTitleText';
  // feedback
  static const String sendFeedbackText = 'sendFeedbackText';
  static const String subjectText = 'subjectText';
  static const String emailAddressText = 'emailAddressText';
  //
  static const String specialText = 'specialText';
  // exit
  static const String exitAppDialogTitleText = 'exitAppDialogTitleText';
  static const String exitAppDialogContentText = 'exitAppDialogContentText';
  static const String exitAppDialogNoText = 'exitAppDialogNoText';
  static const String exitAppDialogYesText = 'exitAppDialogYesText';
  static const String exitAppText = 'exitAppText';

  @override
  Map<String, Map<String, String>> get keys => {
        englishUS.toString(): EnglishTranslation.getEnglishTranslation(),
      };
}
