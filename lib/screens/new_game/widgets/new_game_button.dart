import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/widgets/custom_text_button.dart';

import '../../../providers/user_provider.dart';
import '../../../services/translations/dialogue_service.dart';

class NewGameButton extends StatelessWidget {
  const NewGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();
    AppProvider appProvider = context.watch<AppProvider>();

    return CustomTextButton(
      onPressed: () {
        gameProvider.hostGame(userProvider.getUser(), appProvider);
      },
      text: DialogueService.hostGameFABText.tr,
      color: Theme.of(context).primaryColor,
    );
  }
}
