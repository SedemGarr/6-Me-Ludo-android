import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../providers/app_provider.dart';
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
    AppProvider appProvider = context.watch<AppProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 12.0,
              ),
              child: AnimatedContainer(
                height: Get.height * 0.01,
                width: Get.width * 1 / 2,
                duration: AppConstants.animationDuration,
                decoration: BoxDecoration(
                  color: appProvider.isPanelOpen ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(AppConstants.panelHeader),
                  borderRadius: AppConstants.appBorderRadius,
                ),
              ),
            ),
          ),
          if (!userProvider.getUserIsOffline() || (userProvider.getUserIsOffline() && !GameProvider.isThereLocalGame()))
            Flexible(
              child: SizedBox(
                width: Get.width,
                child: CustomElevatedButton(
                    onPressed: () {
                      userProvider.handleNewGameTap(context);
                    },
                    text: userProvider.getUserIsOffline() ? DialogueService.newOfflineGameText.tr : DialogueService.newOnlineGameAppBarTitleText.tr),
              ),
            ),
          if (!userProvider.getUserIsOffline())
            Flexible(
              child: SizedBox(
                width: Get.width,
                child: CustomOutlinedButton(
                    onPressed: () {
                      showJoinGameDialog(context: context);
                    },
                    text: DialogueService.joinGameFABText.tr),
              ),
            ),
        ],
      ),
    );
  }
}
