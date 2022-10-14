import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/host_game_button.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/max_players.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/back_button_widget.dart';

import '../../constants/app_constants.dart';
import '../../widgets/app_bar_title_widget.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/loading_screen.dart';
import '../profile/widgets/settings/widgets/game/widgets/adaptive_ai.dart';
import '../profile/widgets/settings/widgets/game/widgets/add_ai_players.dart';
import '../profile/widgets/settings/widgets/game/widgets/ai_personality.dart';
import '../profile/widgets/settings/widgets/game/widgets/auto_start.dart';
import '../profile/widgets/settings/widgets/game/widgets/catch_up_assist.dart';
import '../profile/widgets/settings/widgets/game/widgets/game_speed.dart';
import '../profile/widgets/settings/widgets/game/widgets/start_assist.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.watch<AppProvider>();

    return appProvider.isLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: CustomAppBarWidget(
              centerTitle: true,
              leading: BackButtonWidget(
                onPressed: () {
                  NavigationService.genericGoBack();
                },
              ),
              title: AppBarTitleWidget(text: DialogueService.newGameAppBarTitleText.tr),
            ),
            body: ListView(
              padding: AppConstants.listViewPadding,
              children: const [
                MaxPlayers(),
                Divider(),
                AddAIPlayers(),
                Divider(),
                AutoStart(),
                Divider(),
                CatchUpAssist(),
                Divider(),
                StartAssist(),
                Divider(),
                AdaptiveAI(),
                Divider(),
                AIPersonality(),
                Divider(),
                GameSpeed(),
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: HostGameButton(),
                ),
              ],
            ),
          );
  }
}
