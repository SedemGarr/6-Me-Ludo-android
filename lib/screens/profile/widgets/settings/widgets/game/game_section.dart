import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/game/widgets/adaptive_ai.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/game/widgets/add_ai_players.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/game/widgets/ai_personality.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/game/widgets/auto_start.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/game/widgets/catch_up_assist.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/game/widgets/game_speed.dart';
import 'package:six_me_ludo_android/screens/profile/widgets/settings/widgets/game/widgets/start_assist.dart';

import '../../../../../../services/translations/dialogue_service.dart';
import '../settings_header.dart';

class GameSettingsSection extends StatelessWidget {
  const GameSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsHeaderWidget(text: DialogueService.gameSettingsText.tr),
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
      ],
    );
  }
}
