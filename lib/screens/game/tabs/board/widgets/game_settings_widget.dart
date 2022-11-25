import 'package:flutter/material.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../models/game.dart';
import 'game_settings/adaptive_ai.dart';
import 'game_settings/ai_personality.dart';
import 'game_settings/catch_up_assist.dart';
import 'game_settings/game_speed.dart';
import 'game_settings/start_assist.dart';

class GameSettingsWidget extends StatelessWidget {
  final bool canEdit;
  final Game game;

  const GameSettingsWidget({super.key, required this.canEdit, required this.game});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppConstants.listViewPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GameCatchUpAssist(
            canEdit: canEdit,
            game: game,
          ),
          GameStartAssist(
            canEdit: canEdit,
            game: game,
          ),
          GameAdaptiveAI(
            canEdit: canEdit,
            game: game,
          ),
          GameAIPersonality(
            canEdit: canEdit,
            game: game,
          ),
          GameGameSpeed(
            canEdit: canEdit,
            game: game,
          ),
        ],
      ),
    );
  }
}
