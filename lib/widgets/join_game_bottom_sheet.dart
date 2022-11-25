import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/dismissible_wrapper.dart';
import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';

import 'join_game_textfield_widget.dart';

showJoinGameBottomSheet({
  required BuildContext context,
}) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return CustomDismissableWrapper(
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: AppConstants.listViewPadding,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor,
                borderRadius: AppConstants.appBorderRadius,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: AppConstants.modalTitlePadding,
                    child: Text(
                      DialogueService.joinGameButtonText.tr,
                      style:
                          TextStyles.modalTitleStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
                    ),
                  ),
                  const JoinGameTextFieldWidget(),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
