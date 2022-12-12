import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import '../../constants/app_constants.dart';
import '../../constants/textstyle_constants.dart';

import '../../providers/theme_provider.dart';
import '../join_game_textfield_widget.dart';

showJoinGameDialog({
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
          DialogueService.joinGameButtonText.tr,
          style: TextStyles.dialogTitleStyle(ThemeProvider.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
        ),
        content: const JoinGameTextFieldWidget(),
      );
    },
  );
}
