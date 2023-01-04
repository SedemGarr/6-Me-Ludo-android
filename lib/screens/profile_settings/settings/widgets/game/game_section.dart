import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/screens/profile_settings/settings/widgets/game/widgets/profanity.dart';

import '../../../../../services/translations/dialogue_service.dart';
import '../general/widgets/audio.dart';
import '../general/widgets/music.dart';
import '../general/widgets/vibrate.dart';
import '../general/widgets/wakelock.dart';
import '../settings_header.dart';

class GameSettingsSection extends StatelessWidget {
  const GameSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsHeaderWidget(text: DialogueService.gameSettingsText.tr),
        const AudioWidget(),
        const MusicWidget(),
        const VibrateWidget(),
        const WakelockWidget(),
        const ProfaneMessages(),

        // const AddAIPlayers(),
        // const AutoStart(),
        // const CatchUpAssist(),
        // const StartAssist(),
        // const AdaptiveAI(),
        // const AIPersonality(),
        // const GameSpeed(),
      ],
    );
  }
}
