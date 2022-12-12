import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/widgets/dialogs/default_dialog.dart';

import '../../constants/textstyle_constants.dart';
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
      CustomOutlinedButton(
        onPressed: () {
          NavigationService.genericGoBack();
          onNo();
        },
        text: noMessage.tr,
      ),
      CustomElevatedButton(
          onPressed: () {
            NavigationService.genericGoBack();
            onYes();
          },
          text: yesMessage.tr),
    ],
  );
}
