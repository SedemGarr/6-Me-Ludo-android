import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../../../constants/textstyle_constants.dart';
import '../../../../../models/game.dart';
import '../../../../../services/translations/dialogue_service.dart';
import '../../../../../widgets/custom_list_tile.dart';
import 'game_owner_avatar_widget.dart';

class GamePlayerWidget extends StatelessWidget {
  final Player player;
  final Game game;
  final UserProvider userProvider;

  const GamePlayerWidget({super.key, required this.player, required this.game, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    bool isMe = player.id == userProvider.getUserID();
    bool hasLeft = player.hasLeft;
    bool isKicked = game.kickedPlayers.contains(player.id);

    return CustomListTileWidget(
      leading: GameOwnerAvatarWidget(
        id: isMe
            ? userProvider.getUserID()
            : player.isAIPlayer
                ? null
                : player.id,
        avatar: isMe ? userProvider.getUserAvatar() : player.avatar,
        playerColor: player.playerColor,
        hasLeft: hasLeft,
      ),
      title: Text(
        isMe ? DialogueService.youText.tr : player.psuedonym,
        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        isKicked
            ? DialogueService.playerKickedFromGameTrailingText.tr
            : hasLeft
                ? DialogueService.playerHasLeftTheGame.tr
                : player.isAIPlayer
                    ? DialogueService.aiPlayerText.tr
                    : DialogueService.humanPlayerText.tr,
        style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onBackground),
      ),
      trailing: null,
    );
  }
}
