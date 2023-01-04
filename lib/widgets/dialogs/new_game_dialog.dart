import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/widgets/buttons/custom_elevated_button.dart';

import '../../constants/textstyle_constants.dart';
import '../../providers/game_provider.dart';
import '../../services/translations/dialogue_service.dart';
import '../buttons/custom_outlined_button.dart';
import 'default_dialog.dart';
import 'join_game_dialog.dart';

showNewGameDialog({
  required BuildContext context,
  required UserProvider userProvider,
  required GameProvider gameProvider,
}) {
  return showDefaultDialog(
    context: context,
    isDismissible: true,
    onPop: null,
    title: Text(
      DialogueService.newGameText.tr,
      style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!userProvider.getUserIsOffline() || (userProvider.getUserIsOffline() && !GameProvider.isThereLocalGame()))
          SizedBox(
            width: Get.width,
            child: CustomOutlinedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                userProvider.handleNewGameTap(context);
              },
              text: userProvider.getUserIsOffline() ? DialogueService.newOfflineGameText.tr : DialogueService.hostGameFABText.tr,
            ),
          ),
        if (!userProvider.getUserIsOffline())
          SizedBox(
            width: Get.width,
            child: CustomOutlinedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                gameProvider.joinOnlineMatchmakingGame();
              },
              text: DialogueService.newMatchMakingGameButtonText.tr,
            ),
          ),
        if (!userProvider.getUserIsOffline())
          SizedBox(
            width: Get.width,
            child: CustomOutlinedButton(
                onPressed: () {
                  NavigationService.genericGoBack();
                  showJoinGameDialog(context: context);
                },
                text: DialogueService.joinGameFABText.tr),
          ),
      ],
    ),
    actions: [
      SizedBox(
        width: Get.width,
        child: CustomElevatedButton(
          onPressed: () {
            NavigationService.genericGoBack();
          },
          text: DialogueService.closeDialogText.tr,
        ),
      )
    ],
  );
}
