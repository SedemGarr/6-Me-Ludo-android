import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/title_widget.dart';
import '../../constants/app_constants.dart';
import '../../constants/icon_constants.dart';
import '../../constants/textstyle_constants.dart';
import '../../providers/theme_provider.dart';
import '../../services/authentication_service.dart';
import '../custom_outlined_button.dart';

showAuthDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          AppProvider.exitApp();
          return false;
        },
        child: AlertDialog(
          shape: AppConstants.appShape,
          backgroundColor: Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor,
          title: Column(
            children: [
              TitleWidget(width: Get.width * 1 / 4),
              Text(
                DialogueService.welcomeBottomSheetTitleText.tr,
                style: TextStyles.dialogTitleStyle(
                    ThemeProvider.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
              ),
            ],
          ),
          content: Text(
            DialogueService.authDialogContentText.tr,
            style:
                TextStyles.dialogContentStyle(ThemeProvider.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomElevatedButton(
                  iconData: AppIcons.googleIcon,
                  onPressed: () {
                    NavigationService.genericGoBack();
                    AuthenticationService.signInWithGoogle(context);
                  },
                  text: DialogueService.signInGoogleText.tr,
                ),
                CustomOutlinedButton(
                  iconData: AppIcons.anonIcon,
                  color: ThemeProvider.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor),
                  onPressed: () {
                    NavigationService.genericGoBack();
                    AuthenticationService.signInAnon(context);
                  },
                  text: DialogueService.signInAnonText.tr,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
