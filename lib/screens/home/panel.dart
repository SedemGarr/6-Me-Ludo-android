import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../providers/game_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/translations/dialogue_service.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../widgets/buttons/custom_outlined_button.dart';
import '../../widgets/dialogs/join_game_dialog.dart';

class GameOptionsPanel extends StatelessWidget {
  const GameOptionsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 12.0,
            ),
            child: Container(
              height: Get.height * 0.01,
              width: Get.width * 1 / 3,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: AppConstants.appBorderRadius,
              ),
            ),
          ),
          if (!userProvider.getUserIsOffline() || (userProvider.getUserIsOffline() && !GameProvider.isThereLocalGame()))
            SizedBox(
              width: Get.width,
              child: CustomElevatedButton(
                  onPressed: () {
                    userProvider.handleNewGameTap(context);
                  },
                  text: userProvider.getUserIsOffline() ? DialogueService.newOfflineGameText.tr : DialogueService.newOnlineGameAppBarTitleText.tr),
            ),
          if (!userProvider.getUserIsOffline())
            SizedBox(
              width: Get.width,
              child: CustomOutlinedButton(
                  onPressed: () {
                    showJoinGameDialog(context: context);
                  },
                  text: DialogueService.joinGameFABText.tr),
            ),
        ],
      ),
    );
  }
}
