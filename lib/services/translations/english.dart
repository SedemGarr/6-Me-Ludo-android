import '../../constants/constants.dart';
import 'dialogue_service.dart';

class EnglishTranslation {
  static Map<String, String> getEnglishTranslation() {
    return {
      DialogueService.appName: AppConstants.appNameEnglish,
      DialogueService.genericErrorText: 'Sorry, something went wrong. Please check your internet connection and try again',
      DialogueService.animationByText: 'Animation by ',
      // welcome dialog
      DialogueService.welcomeDialogTitleText: 'Hi!',
      DialogueService.welcomeDialogContentText: 'Welcome to 6-Me-Ludo. Sign in to continue',
      DialogueService.welcomeDialogYesText: 'Sign In',
      DialogueService.welcomeDialogNoText: 'Exit',
      DialogueService.signInText: 'Sign in to continue',
      // welcome error
      DialogueService.noUserSelectedText: 'Oops! You didn\'t select an account. Please restart the app and try again',
      // home
      DialogueService.welcomeText: 'Hi, ',
      // game
      DialogueService.startGameButtonText: 'Start Game',
      DialogueService.joinGameButtonText: 'Join Game',
      DialogueService.orButtonText: 'or',
      DialogueService.noGamesText: 'No Games 😕',
      // exit dialog
      DialogueService.exitAppDialogTitleText: 'Aww...',
      DialogueService.exitAppDialogContentText: 'Are you sure you want to exit ${AppConstants.appNameEnglish}?',
      DialogueService.exitAppDialogNoText: 'Cancel',
      DialogueService.exitAppDialogYesText: 'Exit',
    };
  }
}
