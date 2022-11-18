import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import '../constants/app_constants.dart';
import '../constants/icon_constants.dart';
import '../constants/textstyle_constants.dart';
import '../services/authentication_service.dart';
import 'custom_outlined_button.dart';
import 'custom_text_button.dart';

showAuthDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: AppConstants.appShape,
        titlePadding: AppConstants.dialogTitlePadding,
        actionsPadding: AppConstants.dialogTitlePadding,
        title: Text(
          DialogueService.signInRequiredText.tr,
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onBackground),
        ),
        content: Text(
          DialogueService.authDialogContentText.tr,
          style: TextStyles.dialogContentStyle(Theme.of(context).colorScheme.onBackground),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      iconData: AppIcons.googleIcon,
                      onPressed: () {
                        NavigationService.genericGoBack();
                        AuthenticationService.signInWithGoogle(context);
                      },
                      text: DialogueService.signInGoogleText.tr,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      iconData: AppIcons.anonIcon,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        NavigationService.genericGoBack();
                        AuthenticationService.signInAnon(context);
                      },
                      text: DialogueService.signInAnonText.tr,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        NavigationService.genericGoBack();
                        Utils.exitApp();
                      },
                      text: DialogueService.exitAppText.tr,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}
