import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';

import 'package:six_me_ludo_android/widgets/buttons/back_button_widget.dart';
import 'package:six_me_ludo_android/widgets/appbar/custom_appbar.dart';

import '../../providers/game_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/translations/dialogue_service.dart';
import '../../widgets/appbar/app_bar_title_widget.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../widgets/loading/loading_screen.dart';
import '../profile/widgets/settings/widgets/game/widgets/adaptive_ai.dart';
import '../profile/widgets/settings/widgets/game/widgets/add_ai_players.dart';
import '../profile/widgets/settings/widgets/game/widgets/ai_personality.dart';
import '../profile/widgets/settings/widgets/game/widgets/auto_start.dart';
import '../profile/widgets/settings/widgets/game/widgets/catch_up_assist.dart';
import '../profile/widgets/settings/widgets/game/widgets/game_speed.dart';
import '../profile/widgets/settings/widgets/game/widgets/max_players.dart';
import '../profile/widgets/settings/widgets/game/widgets/start_assist.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.read<AppProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();

    return appProvider.isLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: CustomAppBarWidget(
              leading: BackButtonWidget(onPressed: () {
                NavigationService.genericGoBack();
              }),
              title: AppBarTitleWidget(text: userProvider.getUserIsOffline() ? DialogueService.newOfflineGameAppBarTitleText.tr : DialogueService.newOnlineGameAppBarTitleText.tr),
            ),
            body: Padding(
              padding: AppConstants.listViewPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ListView(
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
                  SizedBox(
                    width: Get.width,
                    child: CustomElevatedButton(
                      onPressed: () {
                        NavigationService.genericGoBack();
                        if (userProvider.getUserIsOffline()) {
                          gameProvider.hostOfflineGame(userProvider.getUser(), userProvider.uuid, context);
                        } else {
                          gameProvider.hostGame(userProvider.getUser(), userProvider.uuid, userProvider.isGameOffline(), context);
                        }
                      },
                      text: DialogueService.startGameButtonText.tr,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
