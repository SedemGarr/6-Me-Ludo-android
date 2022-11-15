import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
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
        title: Text(
          DialogueService.humanPlayerCaptialText.tr,
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onBackground),
          textAlign: TextAlign.center,
        ),
        content: UserAvatarWidget(
          backgroundColor: Theme.of(context).primaryColor,
          borderColor: Theme.of(context).colorScheme.onBackground,
          avatar: user.avatar,
          shouldExpand: true,
          hasLeftGame: false,
        ),
        actions: [
          Text(
            user.psuedonym,
            style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onBackground),
          ),
          ReputationWidget(
            value: user.reputationValue,
            color: Theme.of(context).colorScheme.onBackground,
            shouldPad: false,
          ),
        ],
      );
    },
  );
}
