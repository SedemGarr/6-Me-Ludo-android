import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

import '../../../../../constants/icon_constants.dart';

class RestartButtonWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const RestartButtonWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;

    return CustomAnimatedCrossFade(
      firstChild: Center(
        child: IconButton(
          onPressed: () {
            game.hasSessionEnded ? gameProvider.restartGame() : gameProvider.showRestartGameDialog(context);
          },
          icon: Icon(
            AppIcons.restartIcon,
            color: Utils.getContrastingColor(gameProvider.playerColor),
          ),
          tooltip: DialogueService.restartGameText.tr,
        ),
      ),
      secondChild: const SizedBox.shrink(),
      condition: game.hasStarted && gameProvider.isPlayerHost(userProvider.getUserID()),
    );
  }
}
