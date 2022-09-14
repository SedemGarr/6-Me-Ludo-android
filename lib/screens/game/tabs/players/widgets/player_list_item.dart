import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/player_progress_widget.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/player_constants.dart';
import '../../../../../constants/textstyle_constants.dart';
import '../../../../../models/game.dart';
import '../../../../../models/player.dart';
import '../../../../../providers/game_provider.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../utils/utils.dart';
import '../../../../../widgets/custom_list_tile.dart';
import '../../../../../widgets/multiavatar_widget.dart';
import '../../../../../widgets/reputation_widget.dart';

class PlayerListItemWidget extends StatelessWidget {
  final int index;

  const PlayerListItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    Game game = gameProvider.currentGame;
    List<Player> players = game.players;

    Player player = players[index];
    bool isAI = player.isAIPlayer;
    bool isMe = userProvider.isMe(player.id);
    Color playerColor = PlayerConstants.swatchList[players[index].playerColor].playerColor;
    Color playerSelectedColor = PlayerConstants.swatchList[players[index].playerColor].playerSelectedColor;
    Color contrastingColor = Utils.getContrastingColor(playerColor);

    return Container(
      key: key,
      color: Get.isDarkMode ? playerSelectedColor : playerColor,
      child: CustomListTileWidget(
        dense: false,
        leading: GestureDetector(
          onTap: isAI || isMe
              ? null
              : () {
                  userProvider.handleUserAvatarOnTap(player.id, context);
                },
          child: CircleAvatar(
            backgroundColor: contrastingColor,
            child: Padding(
              padding: AppConstants.userAvatarAppBarPadding,
              child: CircleAvatar(
                backgroundColor: Get.isDarkMode ? playerSelectedColor : playerColor,
                child: MultiAvatarWidget(avatar: player.avatar, isBackgroundTransparent: true),
              ),
            ),
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
      ),
    );
  }
}
