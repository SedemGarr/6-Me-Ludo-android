import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../services/navigation_service.dart';
import '../utils/utils.dart';
import 'custom_elevated_button.dart';
import 'custom_outlined_button.dart';

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
        titlePadding: AppConstants.dialogTitlePadding,
        actionsPadding: AppConstants.dialogActionsPadding,
        backgroundColor: Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor,
        title: Text(
          titleMessage,
          style: TextStyles.dialogTitleStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
        ),
        content: Text(
          contentMessage,
          style: TextStyles.dialogContentStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
          //  textAlign: TextAlign.center,
        ),
        actions: [
          CustomOutlinedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                onNo();
              },
              text: noMessage.tr,
              color: Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
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
