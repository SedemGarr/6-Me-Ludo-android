import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_constants.dart';
import '../../constants/textstyle_constants.dart';
import '../../providers/theme_provider.dart';
import '../../services/navigation_service.dart';
import '../custom_elevated_button.dart';
import '../custom_outlined_button.dart';

showChoiceDialog({
  required String titleMessage,
  required String contentMessage,
  required String yesMessage,
  required String noMessage,
  required VoidCallback onYes,
  required VoidCallback onNo,
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
          titleMessage,
          style: TextStyles.dialogTitleStyle(ThemeProvider.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
        ),
        content: Text(
          contentMessage,
          style:
              TextStyles.dialogContentStyle(ThemeProvider.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
        ),
        actions: [
          CustomOutlinedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                onNo();
              },
              text: noMessage.tr,
              color: ThemeProvider.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
          CustomElevatedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                onYes();
              },
              text: yesMessage.tr),
        ],
      );
    },
  );
}
