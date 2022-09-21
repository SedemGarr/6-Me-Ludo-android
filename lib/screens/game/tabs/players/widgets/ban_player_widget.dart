import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';

import '../../../../../models/game.dart';

class BanPlayerWidget extends StatelessWidget {
  final Color color;
  final Player player;
  final GameProvider gameProvider;

  const BanPlayerWidget({super.key, required this.color, required this.gameProvider, required this.player});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;
    bool isBanned = game.bannedPlayers.contains(player.id);

    return IconButton(
      onPressed: () {
        gameProvider.togglePlayerBanFromChat(player, context);
      },
      icon: Icon(
        isBanned ? AppIcons.unBanPlayerIcon : AppIcons.banPlayerIcon,
        color: color,
      ),
    );
  }
}
