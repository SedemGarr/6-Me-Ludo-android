import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:six_me_ludo_android/widgets/custom_elevated_button.dart';
import 'package:six_me_ludo_android/widgets/dismissible_wrapper.dart';
import '../constants/app_constants.dart';
import '../constants/textstyle_constants.dart';
import '../providers/game_provider.dart';
import '../providers/user_provider.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/max_players.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/adaptive_ai.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/add_ai_players.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/ai_personality.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/auto_start.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/catch_up_assist.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/game_speed.dart';
import '../screens/profile/widgets/settings/widgets/game/widgets/start_assist.dart';

showNewGameDialog({
  required BuildContext context,
}) {
  return showModalBottomSheet(
    context: context,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      UserProvider userProvider = context.watch<UserProvider>();
      GameProvider gameProvider = context.watch<GameProvider>();

      return CustomDismissableWrapper(
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: AppConstants.listViewPadding,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: AppConstants.appBorderRadius,
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Padding(
                      padding: AppConstants.modalTitlePadding,
                      child: Text(
                        DialogueService.newGameAppBarTitleText.tr,
                        style: TextStyles.modalTitleStyle(Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  const MaxPlayers(shouldShowIcon: false),
                  const AddAIPlayers(shouldShowIcon: false),
                  const AutoStart(shouldShowIcon: false),
                  const CatchUpAssist(shouldShowIcon: false),
                  const StartAssist(shouldShowIcon: false),
                  const AdaptiveAI(shouldShowIcon: false),
                  const AIPersonality(shouldShowIcon: false),
                  const GameSpeed(shouldShowIcon: false),
                  Padding(
                    padding: AppConstants.modalTitlePadding,
                    child: CustomElevatedButton(
                      onPressed: () {
                        NavigationService.genericGoBack();
                        gameProvider.hostGame(userProvider.getUser(), userProvider.uuid, userProvider.isGameOffline(), context);
                      },
                      text: DialogueService.startGameButtonText.tr,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
