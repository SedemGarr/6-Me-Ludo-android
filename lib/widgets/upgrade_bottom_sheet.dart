import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/dismissible_wrapper.dart';
import 'package:six_me_ludo_android/widgets/title_widget.dart';
import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import 'custom_outlined_button.dart';

showUpgradeBottomSheet({
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
                    DialogueService.updateNeededText.tr,
                    style: TextStyles.modalTitleStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
                  ),
                  Text(
                    DialogueService.updatePromptText.tr,
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
                              onPressed: () {
                                Utils.openURL(AppConstants.playStoreURL);
                              },
                              text: DialogueService.updateButtonText.tr,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomOutlinedButton(
                                onPressed: () {
                                  Utils.exitApp();
                                },
                                text: DialogueService.exitAppDialogYesText.tr,
                                color: Theme.of(context).colorScheme.primary,
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
