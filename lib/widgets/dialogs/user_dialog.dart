import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/dialogs/default_dialog.dart';
import 'package:six_me_ludo_android/widgets/reputation_widget.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';
import '../../constants/textstyle_constants.dart';
import '../../models/user.dart';

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
  );
}
