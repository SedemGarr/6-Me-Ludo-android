import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/dialogs/default_dialog.dart';

import '../../constants/textstyle_constants.dart';
import '../../models/user.dart';
import '../user/reputation_widget.dart';
import '../user/user_avatar_widget.dart';

showUserDialog({
  required Users user,
  required BuildContext context,
}) {
  return showDefaultDialog(
    context: context,
    isDismissible: true,
    onPop: null,
    title: Text(
      DialogueService.humanPlayerCaptialText.tr,
      style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
      textAlign: TextAlign.center,
    ),
    content: UserAvatarWidget(
      backgroundColor: Theme.of(context).primaryColor,
      borderColor: Theme.of(context).colorScheme.onSurface,
      avatar: user.avatar,
      shouldExpand: true,
      hasLeftGame: false,
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            user.psuedonym,
            style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
          ),
          ReputationWidget(
            value: user.reputationValue,
            color: Theme.of(context).colorScheme.onSurface,
            shouldPad: false,
          ),
        ],
      ),
    ],
  );
}
