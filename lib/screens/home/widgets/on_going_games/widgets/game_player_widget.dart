import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../../../constants/icon_constants.dart';
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

    return CustomListTileWidget(
      leading: GameOwnerAvatarWidget(
        id: isMe ? userProvider.getUserID() : player.id,
        avatar: isMe ? userProvider.getUserAvatar() : player.avatar,
        playerColor: player.playerColor,
      ),
      title: Text(
        isMe ? DialogueService.youText.tr : player.psuedonym,
        style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface),
      ),
      subtitle: Text(
        player.isAIPlayer ? DialogueService.aiPlayerText.tr : DialogueService.humanPlayerText.tr,
        style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onSurface),
      ),
      trailing: game.kickedPlayers.contains(player.id)
          ? Icon(
              AppIcons.kickPlayerIcon,
              color: Theme.of(context).primaryColor,
            )
          : null,
    );
  }
}
