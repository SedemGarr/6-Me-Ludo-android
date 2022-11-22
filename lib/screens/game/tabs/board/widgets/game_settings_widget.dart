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
            shouldShowIcon: false,
            canEdit: canEdit,
            game: game,
          ),
          GameStartAssist(
            shouldShowIcon: false,
            canEdit: canEdit,
            game: game,
          ),
          GameAdaptiveAI(
            shouldShowIcon: false,
            canEdit: canEdit,
            game: game,
          ),
          GameAIPersonality(
            shouldShowIcon: false,
            canEdit: canEdit,
            game: game,
          ),
          GameGameSpeed(
            shouldShowIcon: false,
            canEdit: canEdit,
            game: game,
          ),
        ],
      ),
    );
  }
}
