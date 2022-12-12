import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import '../../constants/app_constants.dart';
import '../../constants/textstyle_constants.dart';
import '../../providers/game_provider.dart';
import '../../providers/user_provider.dart';
import '../../screens/profile/widgets/settings/widgets/game/widgets/max_players.dart';
import '../../screens/profile/widgets/settings/widgets/game/widgets/adaptive_ai.dart';
import '../../screens/profile/widgets/settings/widgets/game/widgets/add_ai_players.dart';
import '../../screens/profile/widgets/settings/widgets/game/widgets/ai_personality.dart';
import '../../screens/profile/widgets/settings/widgets/game/widgets/auto_start.dart';
import '../../screens/profile/widgets/settings/widgets/game/widgets/catch_up_assist.dart';
import '../../screens/profile/widgets/settings/widgets/game/widgets/game_speed.dart';
import '../../screens/profile/widgets/settings/widgets/game/widgets/start_assist.dart';

showNewGameDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      UserProvider userProvider = context.watch<UserProvider>();
      GameProvider gameProvider = context.watch<GameProvider>();

      return AlertDialog(
        shape: AppConstants.appShape,
        backgroundColor: Get.isDarkMode ? AppConstants.darkDialogBackgroundColor : AppConstants.lightDialogBackgroundColor,
        title: Text(
          DialogueService.newGameAppBarTitleText.tr,
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onBackground),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: const [
              MaxPlayers(),
              AddAIPlayers(),
              AutoStart(),
              CatchUpAssist(),
              StartAssist(),
              AdaptiveAI(),
              AIPersonality(),
              GameSpeed(),
            ],
          ),
        ),
        actions: [
          CustomElevatedButton(
            onPressed: () {
              NavigationService.genericGoBack();
              gameProvider.hostGame(userProvider.getUser(), userProvider.uuid, userProvider.isGameOffline(), context);
            },
            text: DialogueService.startGameButtonText.tr,
          )
        ],
      );
    },
  );
}
