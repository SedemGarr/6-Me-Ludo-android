import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/widgets/title_widget.dart';

import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../providers/app_provider.dart';
import '../services/navigation_service.dart';
import '../services/translations/dialogue_service.dart';
import '../utils/utils.dart';
import 'custom_text_button.dart';

showLegalDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      AppProvider appProvider = context.read<AppProvider>();

      return AlertDialog(
        shape: AppConstants.appShape,
        backgroundColor: Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor,
        title: Column(
          children: [
            TitleWidget(
              width: MediaQuery.of(context).size.width * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                DialogueService.appName.tr,
                style: TextStyles.dialogTitleStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DialogueService.versionText.tr + appProvider.getAppVersion(),
              textAlign: TextAlign.center,
              style: TextStyles.dialogContentStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
            ),
            Text(
              DialogueService.copyrightText.tr + DateTime.now().year.toString(),
              textAlign: TextAlign.center,
              style: TextStyles.dialogContentStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
            ),
            Text(
              DialogueService.zapsplatText.tr,
              textAlign: TextAlign.center,
              style: TextStyles.dialogContentStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextButton(
                  onPressed: () {
                    Utils.openURL(AppConstants.privacyURL);
                  },
                  text: DialogueService.privacyShortText.tr,
                  color: Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
              CustomTextButton(
                  onPressed: () {
                    Utils.openURL(AppConstants.termsURL);
                  },
                  text: DialogueService.termsText.tr,
                  color: Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
              CustomTextButton(
                  onPressed: () {
                    NavigationService.genericGoBack();
                    NavigationService.goToLegalScreen();
                  },
                  text: DialogueService.licenceShortText.tr,
                  color: Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
            ],
          )
        ],
      );
    },
  );
}
