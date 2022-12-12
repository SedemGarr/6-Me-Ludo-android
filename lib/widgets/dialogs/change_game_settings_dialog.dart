import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../constants/app_constants.dart';
import '../../constants/textstyle_constants.dart';
import '../../models/game.dart';
import '../../providers/theme_provider.dart';
import '../../screens/game/tabs/board/widgets/game_settings/adaptive_ai.dart';
import '../../screens/game/tabs/board/widgets/game_settings/ai_personality.dart';
import '../../screens/game/tabs/board/widgets/game_settings/catch_up_assist.dart';
import '../../screens/game/tabs/board/widgets/game_settings/game_speed.dart';
import '../../screens/game/tabs/board/widgets/game_settings/start_assist.dart';
import '../../services/navigation_service.dart';
import '../custom_elevated_button.dart';

showSettingsDialog({
  required Game game,
  required bool canEdit,
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: AppConstants.appShape,
        backgroundColor: Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor,
        title: Text(
          canEdit ? DialogueService.changeGameSettingsPopupText.tr : DialogueService.viewGameSettingsPopupText.tr,
          style: TextStyles.dialogTitleStyle(ThemeProvider.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              GameCatchUpAssist(
                canEdit: canEdit,
                game: game,
              ),
              GameStartAssist(
                canEdit: canEdit,
                game: game,
              ),
              GameAdaptiveAI(
                canEdit: canEdit,
                game: game,
              ),
              GameAIPersonality(
                canEdit: canEdit,
                game: game,
              ),
              GameGameSpeed(
                canEdit: canEdit,
                game: game,
              )
            ],
          ),
        ),
        actions: [
          CustomElevatedButton(
              onPressed: () {
                NavigationService.genericGoBack();
              },
              text: DialogueService.doneText.tr),
        ],
      );
    },
  );
}
