import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../constants/icon_constants.dart';
import '../../../../../providers/game_provider.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../utils/utils.dart';

class EndGameButtonWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const EndGameButtonWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;

    return Center(
      child: IconButton(
        onPressed: () {
          gameProvider.showLeaveOrDeleteGameDialog(game, userProvider.getUserID(), context);
        },
        icon: Icon(
          gameProvider.isPlayerHost(userProvider.getUserID()) ? AppIcons.endGameIcon : AppIcons.leaveGameIcon,
          color: Utils.getContrastingColor(gameProvider.playerColor),
        ),
        tooltip: gameProvider.isPlayerHost(userProvider.getUserID()) ? DialogueService.endGameTooltipText.tr : DialogueService.leaveGameTooltipText.tr,
      ),
    );
  }
}
