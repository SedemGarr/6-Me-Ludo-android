import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/dialogs/default_dialog.dart';
import 'package:six_me_ludo_android/widgets/title_widget.dart';
import '../../constants/icon_constants.dart';
import '../../constants/textstyle_constants.dart';
import '../../services/authentication_service.dart';
import '../custom_outlined_button.dart';

showAuthDialog({
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
            DialogueService.welcomeBottomSheetTitleText.tr,
            style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
      content: Text(
        DialogueService.authDialogContentText.tr,
        style: TextStyles.dialogContentStyle(Theme.of(context).colorScheme.onSurface),
      ),
      actions: [
        CustomOutlinedButton(
          iconData: AppIcons.anonIcon,
          onPressed: () {
            NavigationService.genericGoBack();
            AuthenticationService.signInAnon(context);
          },
          text: DialogueService.signInAnonText.tr,
        ),
        CustomElevatedButton(
          iconData: AppIcons.googleIcon,
          onPressed: () {
            NavigationService.genericGoBack();
            AuthenticationService.signInWithGoogle(context);
          },
          text: DialogueService.signInGoogleText.tr,
        ),
      ]);
}
