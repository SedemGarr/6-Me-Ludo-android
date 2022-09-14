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
              style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onSurface),
            ),
          ),
        )
        .toList();
  }

  /// ------------------------------------------------------

  static const String appName = 'appName';
  static const String genericErrorText = 'genericErrorText';
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
  // welcome dialog
  static const String welcomeDialogTitleText = 'welcomeDialogTitleText';
  static const String welcomeDialogContentText = 'welcomeDialogContentText';
  static const String welcomeDialogNoText = 'welcomeDialogNoText';
  static const String welcomeDialogYesText = 'welcomeDialogYesText';
  static const String signInGoogleText = 'signInGoogleText';
  static const String signInAnonText = 'signInAnonText';
  static const String anonWarningText = 'anonWarningText';
  static const String welcomeEmojiText = 'welcomeEmojiText';
  static const String welcomeSubtileText = 'welcomeSubtileText';
  // welcome error
  static const String noUserSelectedText = 'noUserSelectedText';
  // home
  static const String welcomeText = 'welcomeText';
  static const String newGameText = 'newGameText';
  static const String profileText = 'profileText';
  static const String homeText = 'homeText';
  // game - starting
  static const String newGameAppBarTitleText = 'newGameAppBarTitleText';
  static const String startGameButtonText = 'startGameButtonText';
  static const String joinGameButtonText = 'joinGameButtonText';
  static const String orButtonText = 'orButtonText';
  static const String noGamesText = 'noGamesText';
  static const String maxGamesText = 'maxGamesText';
  static const String hostGameFABText = 'hostGameFABText';
  static const String joinGameFABText = 'joinGameFABText';
  static const String joinGameHintText = 'joinGameHintText';
  // game - ongoing
  static const String yourGameText = 'yourGameText';
  static const String otherPlayersGameText = 'otherPlayersGameText';
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
  // game - playing
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
  static const String gameIDCopiedToClipboardText = 'gameIDCopiedToClipboardText';
  // profile
  static const String reputationValueText = 'reputationValueText';
  static const String changeAvatarText = 'changeAvatarText';
  static const String changePseudonymText = 'changePseudonymText';
  static const String closeDialogText = 'closeDialogText';
  static const String savePseudonymDialogText = 'savePseudonymDialogText';
  static const String changePseudonymHintText = 'changePseudonymHintText';
  static const String tooShortText = 'tooShortText';
  static const String tooLongText = 'tooLongText';
  static const String profaneStringText = 'profaneStringText';
  static const String youText = 'youText';
  // settings
  static const String generalSettingsText = 'generalSettingsText';
  static const String gameSettingsText = 'gameSettingsText';
  static const String accountSettingsText = 'accountSettingsText';
  // settings - max players
  static const String maxPlayersTitleText = 'maxPlayersTitleText';
  static const String maxPlayersSubtitleText = 'maxPlayersSubtitleText';
  // settings - dark mode
  static const String darkModeTitleText = 'darkModeTitleText';
  static const String darkModeSubtitleText = 'darkModeSubtitleText';
  // settings - audio
  static const String audioTitleText = 'audioTitleText';
  static const String audioSubtitleText = 'audioSubtitleText';
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
  // settings - sign out
  static const String signOutTitleText = 'signOutTitleText';
  static const String signOutSubtitleText = 'signOutSubtitleText';
  static const String signOutDialogTitleText = 'signOutDialogTitleText';
  static const String signOutDialogContentText = 'signOutDialogContentText';
  static const String signOutDialogYesText = 'signOutDialogYesText';
  static const String signOutDialogNoText = 'signOutDialogNoText';
  // settings - delete account
  static const String deleteAccountTitleText = 'deleteAccountTitleText';
  static const String deleteAccountSubtitleText = 'deleteAccountSubtitleText';
  static const String deleteAccountDialogTitleText = 'deleteAccountDialogTitleText';
  static const String deleteAccountDialogContentText = 'deleteAccountDialogContentText';
  static const String deleteAccountDialogYesText = 'deleteAccountDialogYesText';
  static const String deleteAccountDialogNoText = 'deleteAccountDialogNoText';
  // exit
  static const String exitAppDialogTitleText = 'exitAppDialogTitleText';
  static const String exitAppDialogContentText = 'exitAppDialogContentText';
  static const String exitAppDialogNoText = 'exitAppDialogNoText';
  static const String exitAppDialogYesText = 'exitAppDialogYesText';

  @override
  Map<String, Map<String, String>> get keys => {
        englishUS.toString(): EnglishTranslation.getEnglishTranslation(),
      };
}
