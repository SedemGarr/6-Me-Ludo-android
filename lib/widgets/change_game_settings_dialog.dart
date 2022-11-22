import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/game_settings_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../models/game.dart';
import '../services/navigation_service.dart';
import 'custom_elevated_button.dart';

showSettingsDialog({
  required Game currentGame,
  required bool canEdit,
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: AppConstants.appShape,
        titlePadding: AppConstants.dialogTitlePadding,
        contentPadding: EdgeInsets.zero,
        actionsPadding: AppConstants.dialogTitlePadding,
        title: Text(
          canEdit ? DialogueService.changeGameSettingsPopupText.tr : DialogueService.viewGameSettingsPopupText.tr,
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onBackground),
        ),
        content: GameSettingsWidget(
          canEdit: canEdit,
          game: currentGame,
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
