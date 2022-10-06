import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_provider.dart';
import '../../../providers/game_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../services/translations/dialogue_service.dart';
import '../../../widgets/custom_elevated_button.dart';

class HostGameButton extends StatelessWidget {
  const HostGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();
    AppProvider appProvider = context.watch<AppProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomElevatedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                gameProvider.hostGame(userProvider.getUser(), userProvider.uuid, appProvider, userProvider.isGameOffline());
              },
              text: DialogueService.startGameButtonText.tr),
        ],
      ),
    );
  }
}
