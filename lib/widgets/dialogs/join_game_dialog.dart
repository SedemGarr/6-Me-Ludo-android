import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/dialogs/default_dialog.dart';
import '../../constants/textstyle_constants.dart';

import '../join_game_textfield_widget.dart';

showJoinGameDialog({
  required BuildContext context,
}) {
  return showDefaultDialog(
    context: context,
    isDismissible: true,
    onPop: null,
    title: Text(
      DialogueService.joinGameButtonText.tr,
      style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
    ),
    content: const JoinGameTextFieldWidget(),
    contentPadding: AppConstants.dialogContentPaddingNarrow,
    actions: [],
  );
}
