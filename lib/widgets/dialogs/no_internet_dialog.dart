import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/dialogs/default_dialog.dart';
import '../../constants/textstyle_constants.dart';
import '../custom_outlined_button.dart';
import '../title_widget.dart';

showNoInternetDialog({
  required BuildContext context,
}) {
  return showDefaultDialog(
      context: context,
      isDismissible: false,
      onPop: () {
        AppProvider.exitApp();
      },
      title: Column(
        children: [
          TitleWidget(width: Get.width * 1 / 4),
          Text(
            DialogueService.noInternetErrorTitleText.tr,
            style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
      content: Text(
        DialogueService.noInternetErrorContentText.tr,
        style: TextStyles.dialogContentStyle(Theme.of(context).colorScheme.onSurface),
      ),
      actions: [
        CustomOutlinedButton(
          onPressed: () {
            NavigationService.genericGoBack();
            AppProvider.exitApp();
          },
          text: DialogueService.exitAppDialogYesText.tr,
        ),
        CustomElevatedButton(
          onPressed: () {
            NavigationService.genericGoBack();
            AppProvider.restartApp();
          },
          text: DialogueService.restartAppYesText.tr,
        ),
      ]);
}
