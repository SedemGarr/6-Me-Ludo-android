import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/dismissible_wrapper.dart';
import 'package:six_me_ludo_android/widgets/title_widget.dart';
import '../constants/app_constants.dart';
import '../constants/icon_constants.dart';
import '../constants/textstyle_constants.dart';
import '../services/authentication_service.dart';
import 'custom_outlined_button.dart';
import 'custom_text_button.dart';

showAuthBottomSheet({
  required BuildContext context,
}) {
  return showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return CustomDismissableWrapper(
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: AppConstants.dialogTitlePadding,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor,
                borderRadius: AppConstants.appBorderRadius,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleWidget(width: Get.width * 1 / 4),
                  Text(
                    DialogueService.welcomeBottomSheetTitleText.tr,
                    style: TextStyles.modalTitleStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
                  ),
                  Text(
                    DialogueService.authDialogContentText.tr,
                    style:
                        TextStyles.dialogContentStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
                    textAlign: TextAlign.center,
                  ),
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
                              color: Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor),
                              onPressed: () {
                                NavigationService.genericGoBack();
                                AuthenticationService.signInAnon(context);
                              },
                              text: DialogueService.signInAnonText.tr,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextButton(
                                color: Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor),
                                onPressed: () {
                                  NavigationService.genericGoBack();
                                  Utils.exitApp();
                                },
                                text: DialogueService.exitAppText.tr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
