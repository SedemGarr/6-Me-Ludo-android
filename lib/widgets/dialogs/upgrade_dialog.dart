import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/dialogs/default_dialog.dart';
import 'package:six_me_ludo_android/widgets/title_widget.dart';
import '../../constants/app_constants.dart';
import '../../constants/textstyle_constants.dart';

import '../custom_outlined_button.dart';

showUpgradeDialog({
  required BuildContext context,
}) {
  return showDefaultDialog(
    context: context,
    isDismissible: false,
    onPop: () {},
    title: Column(
      children: [
        TitleWidget(width: Get.width * 1 / 4),
        Text(
          DialogueService.updateNeededText.tr,
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    content: Text(
      DialogueService.updatePromptText.tr,
      style: TextStyles.dialogContentStyle(Theme.of(context).colorScheme.onSurface),
    ),
    actions: [
      CustomOutlinedButton(
        onPressed: () {
          AppProvider.exitApp();
        },
        text: DialogueService.exitAppDialogYesText.tr,
      ),
      CustomElevatedButton(
        onPressed: () {
          AppProvider.openURL(AppConstants.playStoreURL);
        },
        text: DialogueService.updateButtonText.tr,
      ),
    ],
  );
}
