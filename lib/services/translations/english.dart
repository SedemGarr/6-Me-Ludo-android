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
      DialogueService.zapsplatText: 'Sounds from Zapsplat',
      DialogueService.updateNeededText: 'Update Needed',
      DialogueService.updatePromptText: '6-Me-Ludo! requires an update. Please update the app from the Google Play store',
      DialogueService.updateButtonText: 'Update',
      // loading strings
      DialogueService.loading1Text: 'Disassembling constructors...',
      DialogueService.loading2Text: 'Barring Foos...',
      DialogueService.loading3Text: 'Unbounding vertical viewports...',
      DialogueService.loading4Text: 'Negating indexes...',
      DialogueService.loading5Text: 'Recursing loops...',
      DialogueService.loading6Text: 'Nulling pointers...',
      DialogueService.loading7Text: 'Distilling mixins...',
      DialogueService.loading8Text: 'Pushing to master branch...',
      DialogueService.loading9Text: 'Dereticulating splines...',
      DialogueService.loading10Text: 'Increasing sinusoidal depleneration...',
      DialogueService.loadingDefaultText: 'Loading...',
      // welcome dialog
      DialogueService.welcomeDialogTitleText: 'Hi!',
      DialogueService.welcomeDialogContentText: 'Welcome to 6-Me-Ludo. Sign in to continue',
      DialogueService.welcomeDialogYesText: 'Sign In',
      DialogueService.welcomeDialogNoText: 'Exit',
      DialogueService.signInGoogleText: 'Sign in with Google',
      DialogueService.signInAnonText: 'Sign in Anonymously',
      DialogueService.anonWarningText: 'Anonymous accounts do not persist and will be lost permanently if you sign out',
      DialogueService.welcomeEmojiText: 'Hello there, 👋',
      DialogueService.welcomeSubtileText: 'Welcome to 6-Me-Ludo! 👋 ',
      //
      DialogueService.anonSignInTitleText: 'Sign In?',
      DialogueService.anonSignInYesText: 'Sign In',
      DialogueService.anonSignInNoText: 'Cancel',
      // welcome error
      DialogueService.noUserSelectedText: 'Oops! You didn\'t select an account',
      // home
      DialogueService.welcomeText: 'Hi, ',
      DialogueService.newGameText: 'New Game',
      DialogueService.profileAndSettingsText: 'Profile & Settings',
      DialogueService.profileText: 'Profile',
      DialogueService.editProfileText: 'Edit Your Profile',
      DialogueService.homeText: 'Games',
      DialogueService.ongoingGamesText: 'Ongoing Games',
      DialogueService.newGamesText: 'New Game',
      // game - ongoing
      DialogueService.yourGameText: 'Your ',
      DialogueService.otherPlayersGameText: '\'s ',
      DialogueService.oneOtherPlayerText: 'one player',
      DialogueService.twoOtherPlayerText: 'two player',
      DialogueService.threeOtherPlayerText: 'three player',
      DialogueService.fourOtherPlayerText: 'four player',
      DialogueService.gameText: ' game',
      DialogueService.humanPlayerText: 'Human player',
      DialogueService.humanPlayerCaptialText: 'Human Player',
      DialogueService.aiPlayerText: 'AI player',
      DialogueService.rejoinGameDialogTitleText: 'Join Game?',
      DialogueService.rejoinGameDialogContentText: 'Are you sure you want to rejoin this game?',
      DialogueService.rejoinGameDialogYesText: 'Join',
      DialogueService.rejoinGameDialogNoText: 'Cancel',
      DialogueService.deleteGameDialogTitleText: 'Delete Game?',
      DialogueService.deleteGameDialogContentText: 'Are you sure you want to delete this game?',
      DialogueService.deleteGameDialogYesText: 'Delete',
      DialogueService.deleteGameDialogNoText: 'Cancel',
      DialogueService.leaveGameDialogTitleText: 'Leave Game',
      DialogueService.leaveGameDialogContentText: 'Are you sure you want to leave this game?',
      DialogueService.leaveGameDialogYesText: 'Leave',
      DialogueService.leaveGameDialogNoText: 'Cancel',
      DialogueService.lastPlayedAtText: 'Last played ',
      DialogueService.createdAtText: 'Game created ',
      DialogueService.createNewGameText: 'Or create a new game',
      DialogueService.playerHasLeftTheGame: 'Player has left the game',
      // game - starting
      DialogueService.newGameAppBarTitleText: 'New Game',
      DialogueService.startGameButtonText: 'Create New Game',
      DialogueService.joinGameButtonText: 'Join Game',
      DialogueService.orButtonText: 'or',
      DialogueService.noGamesText: 'No Games 😕',
      DialogueService.maxGamesText: 'Sorry, you have reached the maximum number of games you can be part of',
      DialogueService.hostGameFABText: 'Host Game',
      DialogueService.joinGameFABText: 'Join Game',
      DialogueService.joinGameHintText: 'Enter code',
      DialogueService.gameKickedText: 'Sorry, you have been kicked from this game',
      DialogueService.gameDoesNotExistText: 'Sorry this game does not exist. It may have been deleted',
      DialogueService.gameFullText: 'Sorry, this game is full',
      DialogueService.joinGameBannerText: 'Enter a game code to join an ongoing game',
      DialogueService.hostGameBannerText: 'Review your game settings and start a new game',
      // game - playing
      DialogueService.inAFewSecondsText: 'in a few seconds',
      DialogueService.playerTabText: 'Players',
      DialogueService.boardTabText: 'Game',
      DialogueService.chatTabText: 'Chat',
      DialogueService.gameDeletedText: 'Sorry this game no longer exists',
      DialogueService.sendMessagesHereText: 'Send Messages here',
      DialogueService.playerBannedBannerText: 'You have been banned from the chat',
      DialogueService.reorderPlayersBannerText: 'Long press and drag to reorder players',
      DialogueService.profaneMessageText: 'Sorry, you cannot send this message',
      DialogueService.chatLimitReachedText: 'Chat limit reached',
      DialogueService.gameDeletedToastText: 'The game has been deleted',
      DialogueService.restartGameText: 'Restart Game',
      DialogueService.yourGameHasBeenRestartedText: 'Your game has been restarted',
      DialogueService.restartGameDialogTitleText: 'Restart Game?',
      DialogueService.restartGameDialogContentText: 'Are you sure you want to restart this game?',
      DialogueService.restartGameDialogYesText: 'Restart',
      DialogueService.restartGameDialogNoText: 'Cancel',
      DialogueService.startGameGamPageButtonText: 'Start Game',
      DialogueService.endSessionText: 'End Session',
      DialogueService.copyGameTooltipText: 'Copy Game Code',
      DialogueService.endGameTooltipText: 'End Game',
      DialogueService.leaveGameTooltipText: 'Leave Game',
      DialogueService.shareGameText: 'Hi! Please join my game on 6-Me-Ludo! with the following link: \n',
      DialogueService.shareGameEmailText: 'Hi! Please join my game on 6-Me-Ludo',
      DialogueService.gameIDCopiedToClipboardText: 'The game code has been copied to your clipboard',
      DialogueService.playerHasLeftText: ' has left the game',
      DialogueService.playerHasJoinedText: ' has joined the game',
      DialogueService.gameHasStartedText: 'The game has started',
      DialogueService.gameHasRestarted: 'The host has restarted the game',
      DialogueService.messageContainsProfanityText: 'This message is hidden due to your profanity settings',
      DialogueService.playerIsPresentText: 'Present in game',
      DialogueService.playerIsNotPresentText: 'Absent from game',
      DialogueService.messageDeletedSubtitleText: 'This message is hidden because this player is no longer part of the game',
      DialogueService.playerBannedText: ' has been banned from the chat',
      DialogueService.playerUnBannedText: ' can now send messages in the chat',
      DialogueService.messageBannedText: 'This message is hidden because this player has been banned from the chat',
      DialogueService.playerKickedFromGameText: ' has been kicked from the game',
      DialogueService.banPlayerDialogTitleText: 'Ban Player?',
      DialogueService.banPlayerDialogContentText: 'Are you sure you want to ban this player from the chat? All their previous messages will be deleted',
      DialogueService.banPlayerDialogYesText: 'Ban',
      DialogueService.banPlayerDialogNoText: 'Cancel',
      DialogueService.kickPlayerDialogTitleText: 'Kick From Game?',
      DialogueService.kickPlayerDialogContentText: 'Are you sure you want to kick this player from the game? They will not be able to rejoin the game',
      DialogueService.kickPlayerDialogYesText: 'Kick',
      DialogueService.kickPlayerDialogNoText: 'Cancel',
      DialogueService.playerKickedFromGameTrailingText: 'Player kicked from game',
      DialogueService.passTurnButtonText: 'Pass Turn',
      DialogueService.noWinnerText: 'No one made it to the end',
      DialogueService.gameWinnerText: 'Winner!',
      DialogueService.gameViciousText: 'Cold-Blooded  😈',
      DialogueService.gamePunchingBagText: 'Punching Bag 🥴',
      DialogueService.statsTitleText: 'Session Stats',
      DialogueService.kickSingularText: ' kick',
      DialogueService.kickPluralText: ' kicks',
      DialogueService.kickedText: 'Kicked ',
      DialogueService.timesSingularText: ' time',
      DialogueService.timesPluralText: ' times',
      DialogueService.reputationChangedText: ' is now ',
      DialogueService.reputationChangedPluralText: ' are now ',

      // game - controls
      DialogueService.restartGamePopupText: 'Restart Game',
      DialogueService.startSessionPopupText: 'Start Session',
      DialogueService.stopSessionPopupText: 'Stop Session',
      DialogueService.endGamePopupText: 'End Game',
      DialogueService.copyGameIDPopupText: 'Copy Game Code',
      DialogueService.shareGameIDPopupText: 'Share Game Invite',
      // game - playing - commentary
      DialogueService.yourTurnText: 'It\'s your turn. Please tap the die to roll it',
      DialogueService.waitingForParticularPlayerText: 'Waiting for ',
      DialogueService.youHaveRolledTheDieText: 'You have rolled the die',
      DialogueService.yourTurnOnceMoreText: 'It\'s your turn once more',
      DialogueService.youHaveRolledAText: 'You have rolled a ',
      DialogueService.waitingForOneMoreText: 'Waiting for 1 more player',
      DialogueService.hasRolledTheDieText: ' has rolled the die',
      DialogueService.waitingForText: 'Waiting for ',
      DialogueService.morePlayersText: ' more players...',
      DialogueService.hasRolledAText: ' has rolled a ',
      // profile
      DialogueService.reputationValueText: 'Reputation Value: ',
      DialogueService.changeAvatarText: 'Change Your Avatar',
      DialogueService.changePseudonymText: 'Change Your Pseudonym',
      DialogueService.closeDialogText: 'Close',
      DialogueService.savePseudonymDialogText: 'Save',
      DialogueService.changePseudonymHintText: 'Enter a pseudonym',
      DialogueService.changePseudonymBannerText: 'This will be publicly displayed in games',
      DialogueService.changeAvatarBannerText: 'This will be publicly displayed in games',
      DialogueService.tooLongText: 'Sorry, this pseudonym is too long',
      DialogueService.tooShortText: 'Sorry, this pseudonym is too short',
      DialogueService.profaneStringText: 'Sorry, this is not an appropriate pseudonym',
      DialogueService.youText: 'You',
      DialogueService.anonAccountText: 'Anonymous Account',
      DialogueService.verifiedAccountText: 'Verified Account',
      DialogueService.visibleOnlyToYouText: ' (visible only to you)',
      // settings
      DialogueService.generalSettingsText: 'General',
      DialogueService.gameSettingsText: 'Games',
      DialogueService.gameSettingsFullText: 'Game Settings',
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
      // settings - theme
      DialogueService.themeTitleText: 'Theme',
      DialogueService.themeSubtitleText: 'Select your preferred theme',
      DialogueService.setThemeToRandomText: 'Random theme selected',
      DialogueService.setThemeToValueText: 'Set theme to ',
      DialogueService.randomThemeText: 'Random Theme Selected',
      DialogueService.currentThemeText: 'Current Theme: ',
      // settings - wakelock
      DialogueService.wakelockTitleText: 'Wakelock',
      DialogueService.wakelockSubtitleText: 'Toggle whether the screen should stay on during games',
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
