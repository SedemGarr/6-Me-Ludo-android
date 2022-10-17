import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/widgets/custom_text_button.dart';

import '../../../providers/app_provider.dart';
import '../../../providers/game_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../services/translations/dialogue_service.dart';

class HostGameButton extends StatelessWidget {
  const HostGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();
    AppProvider appProvider = context.watch<AppProvider>();

    return CustomTextButton(
        color: Get.isDarkMode ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          NavigationService.genericGoBack();
          gameProvider.hostGame(userProvider.getUser(), userProvider.uuid, appProvider, userProvider.isGameOffline());
        },
        text: DialogueService.startGameButtonText.tr);
  }
}
