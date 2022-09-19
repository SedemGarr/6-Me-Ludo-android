import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../providers/app_provider.dart';
import '../providers/game_provider.dart';
import '../providers/user_provider.dart';
import '../screens/new_game/widgets/max_players.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/adaptive_ai.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/add_ai_players.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/ai_personality.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/auto_start.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/catch_up_assist.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/game_speed.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/profanity.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/start_assist.dart';

showNewGameDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      UserProvider userProvider = context.watch<UserProvider>();
      GameProvider gameProvider = context.watch<GameProvider>();
      AppProvider appProvider = context.watch<AppProvider>();

      return AlertDialog(
        shape: AppConstants.appShape,
        titlePadding: const EdgeInsets.all(24.0),
        contentPadding: EdgeInsets.zero,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        title: Text(
          DialogueService.hostGameFABText.tr,
          style: TextStyles.dialogTitleStyle(Theme.of(context).colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              const MaxPlayers(),
              const Divider(),
              Expanded(
                child: ListView(
                  children: const [
                    AddAIPlayers(),
                    AutoStart(),
                    CatchUpAssist(),
                    StartAssist(),
                    AdaptiveAI(),
                    AIPersonality(),
                    GameSpeed(),
                    ProfaneMessages(),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          CustomElevatedButton(
              onPressed: () {
                NavigationService.genericGoBack();
                gameProvider.hostGame(userProvider.getUser(), userProvider.uuid, appProvider);
              },
              text: DialogueService.startGameButtonText.tr)
        ],
      );
    },
  );
}
