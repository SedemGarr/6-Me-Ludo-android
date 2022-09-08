import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/max_players.dart';
import 'package:six_me_ludo_android/widgets/custom_fab.dart';

import '../../../constants/app_constants.dart';
import '../../../services/translations/dialogue_service.dart';
import '../../profile/widgets/settings/widgets/game/widgets/adaptive_ai.dart';
import '../../profile/widgets/settings/widgets/game/widgets/add_ai_players.dart';
import '../../profile/widgets/settings/widgets/game/widgets/ai_personality.dart';
import '../../profile/widgets/settings/widgets/game/widgets/auto_start.dart';
import '../../profile/widgets/settings/widgets/game/widgets/catch_up_assist.dart';
import '../../profile/widgets/settings/widgets/game/widgets/game_speed.dart';
import '../../profile/widgets/settings/widgets/game/widgets/profanity.dart';
import '../../profile/widgets/settings/widgets/game/widgets/start_assist.dart';

class HostGameView extends StatelessWidget {
  const HostGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: AppConstants.listViewBottomPadding,
        children: const [
          MaxPlayers(),
          Divider(),
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
      floatingActionButton: CustomFABWidget(onPressed: () {}, text: DialogueService.hostGameFABText.tr),
    );
  }
}
