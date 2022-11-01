import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/host_game_button.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/banner_widget.dart';

import '../../profile/widgets/settings/widgets/game/widgets/adaptive_ai.dart';
import '../../profile/widgets/settings/widgets/game/widgets/add_ai_players.dart';
import '../../profile/widgets/settings/widgets/game/widgets/ai_personality.dart';
import '../../profile/widgets/settings/widgets/game/widgets/auto_start.dart';
import '../../profile/widgets/settings/widgets/game/widgets/catch_up_assist.dart';
import '../../profile/widgets/settings/widgets/game/widgets/game_speed.dart';
import '../../profile/widgets/settings/widgets/game/widgets/start_assist.dart';
import 'max_players.dart';

class HostNewGameView extends StatelessWidget {
  const HostNewGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: Get.height * 0.25),
      children: [
        BannerWidget(text: DialogueService.hostGameBannerText.tr),
        const MaxPlayers(),
        const Divider(),
        const AddAIPlayers(),
        const Divider(),
        const AutoStart(),
        const Divider(),
        const CatchUpAssist(),
        const Divider(),
        const StartAssist(),
        const Divider(),
        const AdaptiveAI(),
        const Divider(),
        const AIPersonality(),
        const Divider(),
        const GameSpeed(),
        const HostGameButton(),
      ],
    );
  }
}
