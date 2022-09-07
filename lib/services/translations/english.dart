import '../../constants/constants.dart';
import 'dialogue_service.dart';

class EnglishTranslation {
  static Map<String, String> getEnglishTranslation() {
    return {
      DialogueService.appName: AppConstants.appNameEnglish,
      DialogueService.genericErrorText: 'Sorry, something went wrong. Please check your internet connection and try again',
      DialogueService.animationByText: 'Animation by ',
    };
  }
}
