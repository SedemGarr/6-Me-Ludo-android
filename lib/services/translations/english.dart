import '../../constants/app_constants.dart';
import 'dialogue_service.dart';

class EnglishTranslation {
  static Map<String, String> getEnglishTranslation() {
    return {
      DialogueService.appName: AppConstants.appNameEnglish,
      DialogueService.genericErrorText: 'Sorry, something went wrong. Please check your internet connection and try again',
      DialogueService.noInternetErrorTitleText: 'No Internet',
      DialogueService.noInternetErrorContentText: 'Sorry, it seems you do not have an internet connection. Please check your connection and restart the app',
      DialogueService.noInternetErrorSnackbarText: 'Sorry, there seems to be something wrong with your internet connection. Retrying...',
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
      DialogueService.copyrightText: 'Copyright © ',
      DialogueService.wayyyoutGamesText: ' wayyy out! games',
      DialogueService.zapsplatText: 'Sounds from zapsplat.com',
      DialogueService.updateNeededText: 'Update Needed',
      DialogueService.updatePromptText: '6-Me-Ludo! requires an update. Please update the app from the Google Play store',
      DialogueService.updateButtonText: 'Update',
      DialogueService.signInRequiredText: 'Sign In Required',
      DialogueService.authDialogContentText: 'To continue, please choose a sign in option. Please note that anonymous accounts will be permanently lost if you sign out',
      DialogueService.beginText: 'Begin',
      DialogueService.doneText: 'Done',
      DialogueService.restartAppYesText: 'Restart',
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
      // welcome strings
      DialogueService.welcome1Text: 'Hi, ',
      DialogueService.welcome2Text: 'Hey there, ',
      DialogueService.welcome3Text: 'Welcome back, ',
      DialogueService.welcome4Text: 'Hullo, ',
      DialogueService.welcome5Text: 'Hullo, ',
      DialogueService.welcome6Text: 'Welcome, ',
      DialogueService.welcome7Text: 'Howdy, ',
      DialogueService.welcome8Text: 'Hello there, ',
      DialogueService.welcome9Text: 'Hey, ',
      DialogueService.welcome10Text: 'Hello, ',
      // welcome dialog
      DialogueService.welcomeDialogTitleText: 'Welcome to 6-Me-Ludo!',
      DialogueService.welcomeDialogContentText: 'We hope you enjoy this ad-free Ludo game. Select one of the following options to begin',
      DialogueService.signInGoogleText: 'Sign In With Google',
      DialogueService.signInAnonText: 'Begin',
      //
      DialogueService.anonSignInTitleText: 'Sign In?',
      DialogueService.anonSignInYesText: 'Sign In',
      DialogueService.anonSignInNoText: 'Cancel',
      // welcome error
      DialogueService.noUserSelectedText: 'Oops! You didn\'t select an account',
      // home
      DialogueService.welcomeToastText: 'Hi, welcome to 6-Me-Ludo!',
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
      DialogueService.createdAtText: 'Created ',
      DialogueService.createNewGameText: 'Or create a new game',
      DialogueService.playerHasLeftTheGame: 'Player has left the game',
      // game - starting
      DialogueService.newOnlineGameAppBarTitleText: 'New Online Game',
      DialogueService.newOfflineGameAppBarTitleText: 'New Offline Game',
      DialogueService.startGameButtonText: 'Start Game',
      DialogueService.joinGameButtonText: 'Join Game',
      DialogueService.orButtonText: 'or',
      DialogueService.noGamesText: 'No Online Games',
      DialogueService.errorGamesText: 'Something went wrong',
      DialogueService.noLocalGamesText: 'No Local Game',
      DialogueService.noLeaderboardText: 'No Leaderboard Entries',
      DialogueService.maxGamesText: 'Sorry, you have reached the maximum number of games you can be part of',
      DialogueService.hostGameFABText: 'Host New Online Game',
      DialogueService.joinGameFABText: 'Join Game With Code',
      DialogueService.joinGameHintText: 'Enter code',
      DialogueService.gameKickedText: 'Sorry, you have been kicked from this game',
      DialogueService.gameDoesNotExistText: 'Sorry this game does not exist. It may have been deleted',
      DialogueService.gameFullText: 'Sorry, this game is full',
      DialogueService.joinGameBannerText: 'Enter a game code to join an ongoing game',
      DialogueService.hostGameBannerText: 'Review your game settings and start a new game',
      DialogueService.gameVersionMismatchText: 'Sorry, game versions do not match',
      // game - playing
      DialogueService.skipTurnText: 'Skip Turn',
      DialogueService.inAFewSecondsText: 'in a few seconds',
      DialogueService.playerTabText: 'Players',
      DialogueService.boardTabText: 'Game',
      DialogueService.chatTabText: 'Chat',
      DialogueService.chatSaysText: ' says: ',
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
      DialogueService.gameSettingsChangedText: 'The host has changed the game settings',
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
      DialogueService.gameWinnerText: 'Winner! 😎',
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
      DialogueService.gameSessionLengthText: 'Session length:',
      DialogueService.gameSessionNumberOfTurnsText: 'Number of Turns:',
      DialogueService.gameSessionEndedText: 'Session Ended',
      // game settings
      DialogueService.catchUpAssistEnabledText: 'Host has enabled catch up assist',
      DialogueService.catchUpAssistDisabledText: 'Host has disabled catch up assist',
      DialogueService.startAssistEnabledText: 'Host has enabled start assist',
      DialogueService.startAssistDisabledText: 'Host has disabled start assist',
      DialogueService.adaptiveAIEnabledText: 'Host has enabled adaptive AI',
      DialogueService.adaptiveAIDisabledText: 'Host has disabled adaptive AI',
      DialogueService.hostSetAIPersonalityText: 'Host has set the AI personality to ',
      DialogueService.hostSetGameSpeedText: 'Host has set the game speed to ',
      // game - controls
      DialogueService.restartGamePopupText: 'Restart Game',
      DialogueService.startSessionPopupText: 'Start Session',
      DialogueService.stopSessionPopupText: 'Stop Session',
      DialogueService.endGamePopupText: 'Delete Game',
      DialogueService.copyGameIDPopupText: 'Copy Game Code',
      DialogueService.shareGameIDPopupText: 'Share Game Invite',
      DialogueService.viewGameSettingsPopupText: 'View Game Settings',
      DialogueService.changeGameSettingsPopupText: 'Change Game Settings',
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
      DialogueService.refreshAvatarText: 'Refresh List',
      DialogueService.changePseudonymText: 'Change Your Pseudonym',
      DialogueService.savePseudonymText: 'Save Changes',
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
      DialogueService.personalisationSettingsText: 'Personalisation',
      DialogueService.appSettingsText: 'App',
      DialogueService.aboutSettingsText: 'About',
      // settings - max players
      DialogueService.maxPlayersTitleText: 'Number of Human Players',
      DialogueService.maxPlayersOfflineTitleText: 'Number of Players',
      DialogueService.maxPlayersSubtitleText: 'Select how many human players, including yourself, you want in your game',
      // settings - dark mode
      DialogueService.darkModeTitleText: 'Dark Mode',
      DialogueService.darkModeSubtitleText: 'Toggle dark mode on or off',
      // settings - audio
      DialogueService.audioTitleText: 'Game Sounds',
      DialogueService.audioSubtitleText: 'Toggle game sounds on or off',
      // settings - music
      DialogueService.musicTitleText: 'Game Music',
      DialogueService.musicSubtitleText: 'Toggle game music on or off',
      // settings - music
      DialogueService.vibrateTitleText: 'Game Vibrations',
      DialogueService.vibrateSubtitleText: 'Toggle game vibrations on or off',
      // settings - theme
      DialogueService.themeTitleText: 'Theme',
      DialogueService.themeSubtitleText: 'Select your preferred theme',
      DialogueService.setThemeToRandomText: 'Random theme selected',
      DialogueService.setThemeToValueText: 'Set theme to ',
      DialogueService.randomThemeText: 'Random Theme Selected',
      DialogueService.randomiseThemeText: 'Randomise Theme',
      DialogueService.currentThemeText: 'Current Theme: ',
      // settings - wakelock
      DialogueService.wakelockTitleText: 'Screen Always On',
      DialogueService.wakelockSubtitleText: 'Toggle whether the screen should stay on during games',
      // settings - visibility
      DialogueService.visibilityTitleText: 'Private Mode',
      DialogueService.visibilitySubtitleText: 'Toggle whether you want to appear on the leaderbaord',
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
      DialogueService.profaneMessagesTitleText: 'Sensitive Language',
      DialogueService.profaneMessagesSubtitleText: 'Toggle whether chat messages containing profanity are visible to you',
      // settings - offline
      DialogueService.offlineText: 'Offline',
      DialogueService.offlineModeTitleText: 'Offline Mode',
      DialogueService.offlineModeSubtitleText: 'Toggle offline mode on or off',
      DialogueService.offlineModeContentText:
          'You are about to take the application offline. All online features will be disabled and you will only be able to play games against the AI',
      DialogueService.offlineModeYesText: 'Go Offline',
      DialogueService.offlineModeNoText: 'Cancel',
      DialogueService.offlineModeToastOnText: 'Offline mode enabled',
      DialogueService.offlineModeToastOffText: 'Application back online',
      DialogueService.newOfflineGameText: 'New Offline Game',
      DialogueService.continueOfflineGameText: 'Continue Offline Game',
      DialogueService.offlineJoiningGameTitleText: 'You are offline',
      DialogueService.offlineJoiningGameContentText: 'Joining this game requires that offline mode be disabled. Do you want to continue?',
      DialogueService.offlineJoiningGameYesText: 'Join Game',
      DialogueService.offlineJoiningGameNoText: 'Cancel',
      // settings - sign out
      DialogueService.signOutTitleText: 'Sign Out',
      DialogueService.signOutSubtitleText: 'Sign out this account',
      DialogueService.signInSubtitleText: 'Sign in with Google',
      DialogueService.signOutDialogTitleText: 'Sign Out?',
      DialogueService.signOutDialogContentText: 'Are you sure you want to sign out?',
      DialogueService.signOutAnonDialogContentText: 'Are you sure you want to sign out? Your account is anonymous and cannot be recovered',
      DialogueService.signOutDialogYesText: 'Sign Out',
      DialogueService.signOutDialogNoText: 'Cancel',
      // settings - convert account
      DialogueService.convertAccountTitleText: 'Sign In',
      DialogueService.convertAccountSubtitleText: 'Convert your account to a permanent account',
      DialogueService.convertAccountDialogTitleText: 'Sign In With Google?',
      DialogueService.convertAccountDialogContentText: 'Do you want to sign in with Google? This will allow you to keep your games should you reinstall the app',
      DialogueService.convertAccountDialogYesText: 'Sign In',
      DialogueService.convertAccountDialogNoText: 'Cancel',
      // settings - delete account
      DialogueService.deleteAccountTitleText: 'Delete Account',
      DialogueService.deleteAccountSubtitleText: 'Permantently delete your account',
      DialogueService.deleteAccountDialogTitleText: 'Delete Account?',
      DialogueService.deleteAccountDialogContentText: 'This cannot be undone. Proceed?',
      DialogueService.deleteAccountDialogYesText: 'Delete',
      DialogueService.deleteAccountDialogNoText: 'Cancel',
      // settings - about
      DialogueService.versionTitleText: 'Version',
      DialogueService.privacyTitleText: 'Privacy Policy',
      DialogueService.termsTitleText: 'Terms and Conditions',
      DialogueService.privacySubtitleText: 'View our privacy policy',
      DialogueService.termsSubtitleText: 'View our terms and conditions',
      DialogueService.licenseTitleText: 'Application Licenses',
      DialogueService.licenseSubTitleText: 'Nerrrrrrrd!',
      // feedback
      DialogueService.sendFeedbackText: 'Send Feedback',
      DialogueService.sendFeedbackSubtitleText: 'Please be kind, we\'re fragile',
      DialogueService.subjectText: 'Feedback on ${AppConstants.appNameEnglish}',
      DialogueService.emailAddressText: 'wayyy.out.games@gmail.com',
      // special text
      DialogueService.specialText: 'You found me! Lol. I\'m Sedem, a developer from Ghana. Nice to meet you',
      // exit dialog
      DialogueService.exitAppDialogTitleText: 'Aww...',
      DialogueService.exitAppDialogContentText: 'Are you sure you want to exit?',
      DialogueService.exitAppDialogNoText: 'Cancel',
      DialogueService.exitAppDialogYesText: 'Exit',
      DialogueService.exitAppTitleText: 'Exit App',
      DialogueService.exitAppSubtitleText: 'Bad things will happen if you tap this',
      // stats
      DialogueService.seeMoreStatsButtonText: 'See More Statistics',
      DialogueService.statsAppBarTitleText: 'Statistics',
      DialogueService.statsTabText: 'Stats',
      DialogueService.leaderboardTabText: 'Leaderboard',
      DialogueService.leaderboardFindMeButtonText: 'Find Me',
      DialogueService.leaderboardOfflineText: 'The leaderboard is not available when you\'re offline',
      DialogueService.leaderBoardBannerText: 'Showing the first ${AppConstants.maxLeaderboardNumber} entires',
      // cummulative time
      DialogueService.cummulativeTimeTitleText: 'Total length of all games',
      DialogueService.cummulativeTimeNoobText: 'Practice makes perfect, you know',
      DialogueService.cummulativeTimeExperiencedText: 'You\'re getting there',
      DialogueService.cummulativeTimeVeteranText: 'That\'s the spirit!',
      DialogueService.cummulativeTimeSleepText: 'We think an intervention is in order',
      // number of Games
      DialogueService.numberOfGamesText: 'Number of Games',
      DialogueService.numberOfGamesNoobText: 'Noob',
      DialogueService.numberOfGamesExperiencedText: 'Experienced',
      DialogueService.numberOfGamesVeteranText: 'Veteran',
      DialogueService.numberOfGamesSleepText: 'Don\'t you ever sleep!?',
      // percentage finished
      DialogueService.percentageFinishedTitleText: 'Percentage of Games Finished',
      DialogueService.percentageFinishedNoobText: 'Oh dear. Is this too hard for you?',
      DialogueService.percentageFinishedExperiencedText: 'Meh',
      DialogueService.percentageFinishedVeteranText: 'Great job!',
      DialogueService.percentageFinishedSleepText: 'You finish what you start 💃',
      // percentage won
      DialogueService.percentageWonTitleText: 'Percentage of Games Won',
      DialogueService.percentageWonNoobText: '😬',
      DialogueService.percentageWonExperiencedText: 'Meh, we\'ve seen better',
      DialogueService.percentageWonVeteranText: '👍',
      DialogueService.percentageWonSleepText: 'Wow! You\'re great at this',
      // percentage Human
      DialogueService.percentageHumanTitleText: 'Percentage of Games Against Humans',
      DialogueService.percentageHumanNoobText: 'Don\'t be shy. They don\'t bite -- sometimes',
      DialogueService.percentageHumanExperiencedText: 'That\'s a nice balance',
      DialogueService.percentageHumanVeteranText: 'Do you have something against AI?',
      DialogueService.percentageHumanSleepText: 'We put lots of work into our AI logic, you know',
      // percentage AI
      DialogueService.percentageAITitleText: 'Percentage of Games Against AI',
      DialogueService.percentageAINoobText: 'The intelligence in our "AI" is greatly exaggerated lol',
      DialogueService.percentageAIExperiencedText: 'That\'s a nice balance',
      DialogueService.percentageAIVeteranText: 'Do you have something against humans?',
      DialogueService.percentageAISleepText: 'Have you even ever heard of humans? 😅',
      // fav color
      DialogueService.favouriteColorTitleText: 'Favourite Colour',
      DialogueService.favouriteColorSubtitleText: 'We\'re not sure why this matters lol',
      DialogueService.redText: 'Red',
      DialogueService.yellowText: 'Yellow',
      DialogueService.greenText: 'Green',
      DialogueService.blueText: 'Blue',
      DialogueService.orangeText: 'Orange',
      // k -ratio
      DialogueService.kickerRatioTitleText: 'Kicker to Kickee Ratio',
      DialogueService.kickerRatioSubtitleText: 'Yes, we know this name sounds ridiculous',
      // reputation
      DialogueService.reputationTitleText: 'Your Reputation',
      DialogueService.reputationSubtitleText: 'Negative is Vicious, positive is Pacifist',
      // percentage mixed
      DialogueService.percentageMixedTitleText: 'Percentage of Games Against Humans and AI',
      DialogueService.percentageMixedNoobText: 'You have strong preferences, we can see',
      DialogueService.percentageMixedExperiencedText: 'Very vanilla',
      DialogueService.percentageMixedVeteranText: 'Looks like you\'re a cocktail person',
      DialogueService.percentageMixedSleepText: 'Variety is the spice of life! 😊',
      // percentage pb
      DialogueService.percentagePunchingBagTitleText: 'Percentage of Games Where You Were The Punching Bag',
      DialogueService.percentagePunchingBagNoobText: 'Savvy play 😏',
      DialogueService.percentagePunchingBagExperiencedText: 'Win some, lose some',
      DialogueService.percentagePunchingBagVeteranText: 'Oh dear, we\'re really sorry',
      DialogueService.percentagePunchingBagSleepText: '😢',
      // percentage v
      DialogueService.percentageViciousTitleText: 'Percentage of Games Where You Were The Vicious Player',
      DialogueService.percentageViciousNoobText: 'You keep it clean. Nice!',
      DialogueService.percentageViciousExperiencedText: 'Win some, lose some',
      DialogueService.percentageViciousVeteranText: 'Violence begets violence',
      DialogueService.percentageViciousSleepText: 'Please have mercy 😕',
      DialogueService.allowMatchMakingPopupText: 'Allow Matchmaking',
      DialogueService.enabledMatchMakingToastText: 'Your game is now open for random online players to join',
      DialogueService.noGamesMatchMakingText: 'No games available',
      DialogueService.newMatchMakingGameButtonText: 'Join Random Online Game',
    };
  }
}
