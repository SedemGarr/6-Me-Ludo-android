import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../constants/icon_constants.dart';
import '../../../../../models/game.dart';

class GameSettingsWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const GameSettingsWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Tooltip(
            message: DialogueService.startAssistTitleText.tr,
            child: Icon(
              AppIcons.autoStartIcon,
              color: game.hostSettings.prefersAutoStart
                  ? Get.isDarkMode
                      ? gameProvider.playerSelectedColor
                      : gameProvider.playerColor
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Tooltip(
            message: DialogueService.catchUpAssistTitleText.tr,
            child: Icon(
              AppIcons.catchUpAssistIcon,
              color: game.hostSettings.prefersCatchupAssist
                  ? Get.isDarkMode
                      ? gameProvider.playerSelectedColor
                      : gameProvider.playerColor
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Tooltip(
            message: DialogueService.startAssistTitleText.tr,
            child: Icon(
              AppIcons.startAssistIcon,
              color: game.hostSettings.prefersStartAssist
                  ? Get.isDarkMode
                      ? gameProvider.playerSelectedColor
                      : gameProvider.playerColor
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Tooltip(
            message: DialogueService.adaptiveAITitleText.tr,
            child: Icon(
              AppIcons.adaptiveAIIcon,
              color: game.hostSettings.prefersAdaptiveAI && game.players.where((element) => element.isAIPlayer).isNotEmpty
                  ? Get.isDarkMode
                      ? gameProvider.playerSelectedColor
                      : gameProvider.playerColor
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Tooltip(
            message: DialogueService.aIPersonalityTitleText.tr,
            child: Icon(
              game.players.where((element) => element.isAIPlayer).isNotEmpty
                  ? gameProvider.getAIPreferenceIcon(game.hostSettings.aiPersonalityPreference)
                  : AppIcons.aIPersonalityTypeIcon,
              color: game.players.where((element) => element.isAIPlayer).isNotEmpty
                  ? Get.isDarkMode
                      ? gameProvider.playerSelectedColor
                      : gameProvider.playerColor
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Tooltip(
            message: DialogueService.gameSpeedTitleText.tr,
            child: Icon(
              gameProvider.gameSpeedPreferenceIcon(game.hostSettings.preferredSpeed),
              color: Get.isDarkMode ? gameProvider.playerSelectedColor : gameProvider.playerColor,
            ),
          ),
        ),
      ],
    );
  }
}
