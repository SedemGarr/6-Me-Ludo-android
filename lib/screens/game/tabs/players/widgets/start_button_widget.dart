import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

import '../../../../../constants/icon_constants.dart';

class StartButtonWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const StartButtonWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;

    return CustomAnimatedCrossFade(
      firstChild: Center(
        child: IconButton(
          onPressed: () async {
            await gameProvider.forceStartGame();
          },
          icon: Icon(
            AppIcons.playIcon,
            color: Utils.getContrastingColor(gameProvider.playerColor),
          ),
          tooltip: DialogueService.startGameGamPageButtonText.tr,
        ),
      ),
      secondChild: gameProvider.isPlayerHost(userProvider.getUserID())
          ? Center(
              child: IconButton(
                onPressed: game.hasStarted && game.hasSessionEnded
                    ? null
                    : () {
                        gameProvider.endSession(game);
                      },
                icon: Icon(
                  AppIcons.stopIcon,
                  color: Utils.getContrastingColor(gameProvider.playerColor),
                ),
                tooltip: game.hasStarted && game.hasSessionEnded ? null : DialogueService.endSessionText.tr,
              ),
            )
          : const SizedBox.shrink(),
      condition: !game.hasStarted && gameProvider.isPlayerHost(userProvider.getUserID()) && game.players.length > 1,
    );
  }
}
