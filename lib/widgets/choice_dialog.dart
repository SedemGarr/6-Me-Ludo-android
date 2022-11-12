import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../services/navigation_service.dart';
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
        title: Text(
          titleMessage,
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onBackground),
        ),
        content: Text(
          contentMessage,
          style: TextStyles.dialogContentStyle(Theme.of(context).colorScheme.onBackground),
          //  textAlign: TextAlign.center,
        ),
        actions: [
          CustomOutlinedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                onNo();
              },
              text: noMessage.tr,
              color: Theme.of(context).colorScheme.onBackground),
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
