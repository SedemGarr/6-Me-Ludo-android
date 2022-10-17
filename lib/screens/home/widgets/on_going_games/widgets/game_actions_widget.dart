import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../../../services/translations/dialogue_service.dart';
import '../../../../../widgets/custom_text_button.dart';

class GameActionsWidget extends StatelessWidget {
  final Player host;
  final Game game;
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const GameActionsWidget({super.key, required this.game, required this.gameProvider, required this.userProvider, required this.host});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextButton(
            onPressed: () {
              gameProvider.showLeaveOrDeleteGameDialog(
                game,
                userProvider.getUser(),
                context,
              );
            },
            text: host.id == userProvider.getUserID() ? DialogueService.deleteGameDialogYesText.tr : DialogueService.leaveGameDialogYesText.tr,
            color: Theme.of(context).primaryColor),
        CustomTextButton(
            onPressed: () {
              gameProvider.showRejoinGameDialog(game, userProvider.getUser(), context);
            },
            text: DialogueService.rejoinGameDialogYesText.tr,
            color: Theme.of(context).primaryColor),
      ],
    );
  }
}
