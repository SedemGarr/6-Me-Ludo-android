import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/title_widget.dart';
import '../../constants/app_constants.dart';
import '../../constants/textstyle_constants.dart';
import '../../providers/theme_provider.dart';
import '../custom_outlined_button.dart';

showUpgradeDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: AppConstants.appShape,
        backgroundColor: Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor,
        title: Column(
          children: [
            TitleWidget(width: Get.width * 1 / 4),
            Text(
              DialogueService.updateNeededText.tr,
              style:
                  TextStyles.dialogTitleStyle(ThemeProvider.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
            ),
          ],
        ),
        content: Text(
          DialogueService.updatePromptText.tr,
          style:
              TextStyles.dialogContentStyle(ThemeProvider.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  AppProvider.openURL(AppConstants.playStoreURL);
                },
                text: DialogueService.updateButtonText.tr,
              ),
              CustomOutlinedButton(
                onPressed: () {
                  AppProvider.exitApp();
                },
                text: DialogueService.exitAppDialogYesText.tr,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ],
      );
    },
  );
}
