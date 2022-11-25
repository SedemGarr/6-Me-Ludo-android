import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../models/game.dart';
import '../screens/game/tabs/board/widgets/game_settings/adaptive_ai.dart';
import '../screens/game/tabs/board/widgets/game_settings/ai_personality.dart';
import '../screens/game/tabs/board/widgets/game_settings/catch_up_assist.dart';
import '../screens/game/tabs/board/widgets/game_settings/game_speed.dart';
import '../screens/game/tabs/board/widgets/game_settings/start_assist.dart';
import '../services/navigation_service.dart';
import '../utils/utils.dart';
import 'custom_elevated_button.dart';
import 'dismissible_wrapper.dart';

showSettingsBottomSheet({
  required Game game,
  required bool canEdit,
  required BuildContext context,
}) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return CustomDismissableWrapper(
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: AppConstants.listViewPadding,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor,
                borderRadius: AppConstants.appBorderRadius,
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Padding(
                      padding: AppConstants.modalTitlePadding,
                      child: Text(
                        canEdit ? DialogueService.changeGameSettingsPopupText.tr : DialogueService.viewGameSettingsPopupText.tr,
                        style: TextStyles.modalTitleStyle(
                            Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
                      ),
                    ),
                  ),
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
                  ),
                  Padding(
                    padding: AppConstants.modalTitlePadding,
                    child: CustomElevatedButton(
                        onPressed: () {
                          NavigationService.genericGoBack();
                        },
                        text: DialogueService.doneText.tr),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
