import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/models/game.dart';

import '../../../../../models/player.dart';
import '../../../../../providers/game_provider.dart';

class KickPlayerWidget extends StatelessWidget {
  final Color color;

  final Player player;
  final GameProvider gameProvider;

  const KickPlayerWidget({super.key, required this.color, required this.player, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;
    bool isKicked = game.kickedPlayers.contains(player.id);

    return !isKicked
        ? IconButton(
            onPressed: () {
              gameProvider.showKickPlayerDialog(player, context);
            },
            icon: Icon(
              AppIcons.kickPlayerIcon,
              color: color,
            ),
          )
        : const SizedBox.shrink();
  }
}
