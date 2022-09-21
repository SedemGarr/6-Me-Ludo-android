import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../services/navigation_service.dart';
import 'custom_elevated_button.dart';
import 'custom_text_button.dart';

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
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
        ),
        content: Text(
          contentMessage,
          style: TextStyles.dialogContentStyle(Theme.of(context).colorScheme.onSurface),
          //  textAlign: TextAlign.center,
        ),
        actions: [
          CustomTextButton(
              onPressed: () {
                NavigationService.genericGoBack();
                onNo();
              },
              text: noMessage.tr,
              color: Theme.of(context).colorScheme.onSurface),
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
