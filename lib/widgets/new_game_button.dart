import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/dialogs/new_game_dialog.dart';

import 'custom_elevated_button.dart';

class NewGameButton extends StatelessWidget {
  const NewGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    if (userProvider.getUserIsOffline()) {
      if (GameProvider.isThereLocalGame()) {
        return CustomElevatedButton(
          onPressed: () {},
          text: DialogueService.continueOfflineGameText.tr,
        );
      } else {
        return CustomElevatedButton(
          onPressed: () {
            showNewGameDialog(context: context);
          },
          text: DialogueService.newOfflineGameText.tr,
        );
      }
    } else {
      return CustomElevatedButton(
        onPressed: () {
          showNewGameDialog(context: context);
        },
        text: DialogueService.hostGameFABText.tr,
      );
    }
  }
}
