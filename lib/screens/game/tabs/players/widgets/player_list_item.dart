import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/ban_player_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/kick_player_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/player_presence_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/player_progress_widget.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';

import '../../../../../constants/player_constants.dart';
import '../../../../../constants/textstyle_constants.dart';
import '../../../../../models/game.dart';
import '../../../../../models/player.dart';
import '../../../../../providers/game_provider.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_list_tile.dart';
import '../../../../../widgets/reputation_widget.dart';

class PlayerListItemWidget extends StatelessWidget {
  final int index;

  const PlayerListItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    Game game = gameProvider.currentGame!;
    List<Player> players = game.players;

    Player player = players[index];
    bool isAI = player.isAIPlayer;
    bool isMe = userProvider.isMe(player.id);
    bool isHost = gameProvider.isPlayerHost(userProvider.getUserID());
    bool isKicked = game.finishedPlayers.contains(player.id);
    bool isBanned = game.bannedPlayers.contains(player.id);
    Color playerColor = PlayerConstants.swatchList[players[index].playerColor].playerColor;
    Color playerSelectedColor = PlayerConstants.swatchList[players[index].playerColor].playerSelectedColor;
    Color contrastingColor = Utils.getContrastingColor(playerColor);

    return Container(
      key: key,
      color: Get.isDarkMode ? playerSelectedColor : playerColor,
      child: ExpansionTile(
        tilePadding: (player.playerColor == game.playerTurn && game.hasStarted && !game.hasSessionEnded) ? const EdgeInsets.all(16.0) : const EdgeInsets.symmetric(horizontal: 16),
        leading: GestureDetector(
          onTap: isAI || isMe
              ? null
              : () {
                  userProvider.handleUserAvatarOnTap(player.id, context);
                },
          child: UserAvatarWidget(
            avatar: player.avatar,
            backgroundColor: Get.isDarkMode ? playerSelectedColor : playerColor,
            borderColor: contrastingColor,
          ),
        ),
        title: Text(
          userProvider.parsePlayerNameText(player.psuedonym),
          style: TextStyles.listTitleStyle(contrastingColor),
        ),
        subtitle: PlayerProgressWidget(
          player: player,
          hasStarted: game.hasStarted,
        ),
        trailing: ReputationWidget(value: player.reputationValue, color: contrastingColor),
        children: !isAI && isHost && !isMe
            ? [
                CustomListTileWidget(
                  title: PlayerPresenceWidget(isPresent: player.isPresent, color: contrastingColor, gameProvider: gameProvider),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KickPlayerWidget(
                        color: contrastingColor,
                        isKicked: isKicked,
                      ),
                      BanPlayerWidget(
                        color: contrastingColor,
                        isBanned: isBanned,
                      ),
                    ],
                  ),
                ),
              ]
            : [],
      ),
    );
  }
}
