import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/dialogs/default_dialog.dart';
import 'package:six_me_ludo_android/widgets/app/title_widget.dart';
import '../../constants/textstyle_constants.dart';
import '../../services/authentication_service.dart';
import '../buttons/custom_elevated_button.dart';
import '../buttons/custom_outlined_button.dart';

showWelcomeDialog({
  required BuildContext context,
}) {
  return showDefaultDialog(
    context: context,
    isDismissible: false,
    onPop: () {
      AppProvider.exitApp();
    },
    title: TitleWidget(width: Get.width * 1 / 5),
    content: Text(
      DialogueService.welcomeDialogTitleText.tr,
      style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
      textAlign: TextAlign.center,
    ),
    actions: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width,
            child: CustomOutlinedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                AuthenticationService.convertToGoogle(context);
              },
              text: DialogueService.signInGoogleText.tr,
              iconData: AppIcons.googleIcon,
            ),
          ),
          SizedBox(
            width: Get.width,
            child: CustomElevatedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                AuthenticationService.signInAnon(context);
              },
              text: DialogueService.signInAnonText.tr,
            ),
          ),
        ],
      ),
    ],
  );
}
