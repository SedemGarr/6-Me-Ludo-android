import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/reputation_widget.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';
import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../models/user.dart';

showUserDialog({
  required Users user,
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: AppConstants.appShape,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        backgroundColor: Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor,
        title: Text(
          DialogueService.humanPlayerCaptialText.tr,
          style: TextStyles.dialogTitleStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
          textAlign: TextAlign.center,
        ),
        content: UserAvatarWidget(
          backgroundColor: Theme.of(context).primaryColor,
          borderColor: Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor),
          avatar: user.avatar,
          shouldExpand: true,
          hasLeftGame: false,
        ),
        actions: [
          Text(
            user.psuedonym,
            style: TextStyles.dialogTitleStyle(Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor)),
          ),
          ReputationWidget(
            value: user.reputationValue,
            color: Utils.getContrastingColor(Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor),
            shouldPad: false,
          ),
        ],
      );
    },
  );
}
