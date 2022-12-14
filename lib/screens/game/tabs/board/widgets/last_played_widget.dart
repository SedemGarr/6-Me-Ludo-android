import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';

import '../../../../../constants/textstyle_constants.dart';
import '../../../../../models/game.dart';
import '../../../../../services/translations/dialogue_service.dart';

class LastPlayedAtWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const LastPlayedAtWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        AppProvider.parseDateFromNow(game.lastUpdatedAt) == DialogueService.inAFewSecondsText.tr ? '' : DialogueService.lastPlayedAtText.tr + AppProvider.parseDateFromNow(game.lastUpdatedAt),
        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
      ),
    );
  }
}
