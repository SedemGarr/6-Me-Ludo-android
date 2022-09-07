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
      // welcome error
      DialogueService.noUserSelectedText: 'Oops! You didn\'t select an account. Please restart the app and try again',
    };
  }
}
