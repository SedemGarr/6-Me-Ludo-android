import '../../constants/app_constants.dart';
import 'dialogue_service.dart';

class EnglishTranslation {
  static Map<String, String> getEnglishTranslation() {
    return {
      DialogueService.appName: AppConstants.appNameEnglish,
      DialogueService.genericErrorText: 'Sorry, something went wrong. Please check your internet connection and try again',
      DialogueService.animationByText: 'Animation by ',
      DialogueService.licenceText: 'Application Licences',
      DialogueService.licenceShortText: 'Licences',
      DialogueService.termsText: 'Terms',
      DialogueService.privacyText: 'Privacy Policy',
      DialogueService.privacyShortText: 'Privacy',
      DialogueService.cookieText: 'Cookie',
      DialogueService.signUpLegalese: 'By signing up, you agree to our ',
      DialogueService.signInWithGoogleText: 'Sign in with Google',
      DialogueService.andText: 'and',
      DialogueService.versionText: 'Version ',
      DialogueService.copyrightText: 'Copyright ',
      // welcome dialog
      DialogueService.welcomeDialogTitleText: 'Hi!',
      DialogueService.welcomeDialogContentText: 'Welcome to 6-Me-Ludo. Sign in to continue',
      DialogueService.welcomeDialogYesText: 'Sign In',
      DialogueService.welcomeDialogNoText: 'Exit',
      DialogueService.signInText: 'Sign in to continue',
      // welcome error
      DialogueService.noUserSelectedText: 'Oops! You didn\'t select an account',
      // home
      DialogueService.welcomeText: 'Hi, ',
      DialogueService.newGameText: 'New Game',
      DialogueService.profileText: 'Profile',
      DialogueService.homeText: 'Home',
      // game - starting
      DialogueService.newGameAppBarTitleText: 'New Game',
      DialogueService.startGameButtonText: 'Host Game',
      DialogueService.joinGameButtonText: 'Join Game',
      DialogueService.orButtonText: 'or',
      DialogueService.noGamesText: 'No Games 😕',
      DialogueService.maxGamesText: 'Sorry, you have reached the maximum number of games you can be part of',
      DialogueService.hostGameFABText: 'Host New Game',
      DialogueService.joinGameFABText: 'Join',
      DialogueService.joinGameHintText: 'Please enter a game code',
      // game - playing
      DialogueService.playerTabText: 'Players',
      DialogueService.boardTabText: 'Board',
      DialogueService.chatTabText: 'Chat',
      DialogueService.gameDeletedText: 'Sorry this game no longer exists',
      // profile
      DialogueService.reputationValueText: 'Reputation Value: ',
      DialogueService.changeAvatarText: 'Change Your Avatar',
      DialogueService.changePseudonymText: 'Change Your Pseudonym',
      DialogueService.closeDialogText: 'Close',
      DialogueService.savePseudonymDialogText: 'Save',
      DialogueService.changePseudonymHintText: 'Enter a pseudonym',
      DialogueService.tooLongText: 'Sorry, this pseudonym is too long',
      DialogueService.tooShortText: 'Sorry, this pseudonym is too short',
      DialogueService.profaneStringText: 'Sorry, this is not an appropriate pseudonym',
      DialogueService.youText: 'You',
      // settings
      DialogueService.generalSettingsText: 'General',
      DialogueService.gameSettingsText: 'Game',
      DialogueService.accountSettingsText: 'Account',
      // settings - max players
      DialogueService.maxPlayersTitleText: 'Number of Human Players',
      DialogueService.maxPlayersSubtitleText: 'Select how many human players you want to add to your game',
      // settings - dark mode
      DialogueService.darkModeTitleText: 'Dark Mode',
      DialogueService.darkModeSubtitleText: 'Toggle dark mode on or off',
      // settings - audio
      DialogueService.audioTitleText: 'Audio',
      DialogueService.audioSubtitleText: 'Toggle game sounds on or off',
      // settings - language
      DialogueService.languageTitleText: 'Language',
      DialogueService.languageSubtitleText: 'Choose application language',
      // settings - add ai players
      DialogueService.addAIPlayersTitleText: 'Add AI Players',
      DialogueService.addAIPlayersSubtitleText: 'With this enabled, empty spaces in a game will be filled with AI players',
      // settings - auto start
      DialogueService.autoStartTitleText: 'Auto Start',
      DialogueService.autoStartSubtitleText: 'With this setting enabled, the game will start as soon as all players have joined',
      // settings - catch up assist
      DialogueService.catchUpAssistTitleText: 'Catch Up Assist',
      DialogueService.catchUpAssistSubtitleText: 'With this setting enabled, a player will roll a six if all their pieces are based',
      // settings - start assist
      DialogueService.startAssistTitleText: 'Start Assist',
      DialogueService.startAssistSubtitleText: 'With this setting enabled, all players will recieve a six on their first roll',
      // settings - adaptive ai
      DialogueService.adaptiveAITitleText: 'Adaptive AI',
      DialogueService.adaptiveAISubtitleText: 'With this setting enabled, AI personalities will change during gameplay',
      // settings - ai personality type
      DialogueService.aIPersonalityTitleText: 'AI Personality Type',
      DialogueService.aIPersonalitySubtitleText: 'Determine the aggressiveness of AI Players',
      DialogueService.averagePersonalityType: 'Average',
      DialogueService.pacifistPersonalityType: 'Pacifist',
      DialogueService.viciousPersonalityType: 'Vicious',
      DialogueService.randomPersonalityType: 'Random',
      // settings - game speed
      DialogueService.gameSpeedTitleText: 'Game Speed',
      DialogueService.gameSpeedSubtitleText: 'Select your prefered game speed',
      DialogueService.gameSpeedFastText: 'Fast',
      DialogueService.gameSpeedNormalText: 'Normal',
      DialogueService.gameSpeedSlowText: 'Slow',
      // settings - profanity
      DialogueService.profaneMessagesTitleText: 'Profanity',
      DialogueService.profaneMessagesSubtitleText: 'Toggle whether chat messages containing profanity are visible to you',
      // settings - sign out
      DialogueService.signOutTitleText: 'Sign Out',
      DialogueService.signOutSubtitleText: 'Sign out this account',
      DialogueService.signOutDialogTitleText: 'Sign Out?',
      DialogueService.signOutDialogContentText: 'Are you sure you want to sign out?',
      DialogueService.signOutDialogYesText: 'Sign Out',
      DialogueService.signOutDialogNoText: 'Cancel',
      // settings - delete account
      DialogueService.deleteAccountTitleText: 'Delete Account',
      DialogueService.deleteAccountSubtitleText: 'Permantently delete your account',
      DialogueService.deleteAccountDialogTitleText: 'Delete Account?',
      DialogueService.deleteAccountDialogContentText: 'This cannot be undone. Proceed?',
      DialogueService.deleteAccountDialogYesText: 'Delete',
      DialogueService.deleteAccountDialogNoText: 'Cancel',
      // exit dialog
      DialogueService.exitAppDialogTitleText: 'Aww...',
      DialogueService.exitAppDialogContentText: 'Are you sure you want to exit ${AppConstants.appNameEnglish}?',
      DialogueService.exitAppDialogNoText: 'Cancel',
      DialogueService.exitAppDialogYesText: 'Exit',
    };
  }
}
