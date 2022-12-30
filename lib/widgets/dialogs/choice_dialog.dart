import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/widgets/dialogs/default_dialog.dart';

import '../../constants/textstyle_constants.dart';
import '../../services/navigation_service.dart';
import '../buttons/custom_elevated_button.dart';
import '../buttons/custom_outlined_button.dart';

showChoiceDialog({
  required String titleMessage,
  required String contentMessage,
  required String yesMessage,
  required String noMessage,
  required VoidCallback onYes,
  required VoidCallback onNo,
  required BuildContext context,
}) {
  return showDefaultDialog(
    context: context,
    isDismissible: true,
    onPop: null,
    title: Text(
      titleMessage,
      style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
    ),
    content: Text(
      contentMessage,
      style: TextStyles.dialogContentStyle(Theme.of(context).colorScheme.onSurface),
    ),
    actions: [
      Column(
        children: [
          SizedBox(
            width: Get.width,
            child: CustomOutlinedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                onNo();
              },
              text: noMessage.tr,
            ),
          ),
          SizedBox(
            width: Get.width,
            child: CustomElevatedButton(
                onPressed: () {
                  NavigationService.genericGoBack();
                  onYes();
                },
                text: yesMessage.tr),
          ),
        ],
      )
    ],
  );
}
