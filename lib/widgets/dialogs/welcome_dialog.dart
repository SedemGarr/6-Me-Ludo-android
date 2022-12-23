import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/dialogs/default_dialog.dart';
import 'package:six_me_ludo_android/widgets/title_widget.dart';
import '../../constants/textstyle_constants.dart';
import '../../services/authentication_service.dart';
import '../custom_elevated_button.dart';

showWelcomeDialog({
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
          DialogueService.welcomeDialogTitleText.tr,
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    content: CustomElevatedButton(
      onPressed: () {
        NavigationService.genericGoBack();
        AuthenticationService.signInAnon(context);
      },
      text: DialogueService.signInAnonText.tr,
    ),
    actions: [
      Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                NavigationService.genericGoBack();
                AuthenticationService.convertToGoogle(context);
              },
              child: Text(
                DialogueService.signInGoogleText.tr,
                style: TextStyles.listTitleStyle(Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
