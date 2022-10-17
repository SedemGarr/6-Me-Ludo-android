import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../constants/textstyle_constants.dart';
import '../../../../../models/game.dart';
import '../../../../../models/message.dart';
import '../../../../../widgets/custom_list_tile.dart';

class ChatListItem extends StatelessWidget {
  final int index;

  const ChatListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();
    Game game = gameProvider.currentGame!;
    Message message = gameProvider.currentThread!.messages[index];
    bool isMe = message.createdById == userProvider.getUserID();
    TextAlign textAlign = isMe ? TextAlign.end : TextAlign.start;

    int playerNumber = game.playerIds.indexWhere((element) => element == message.createdById);
    Color playerColor = Get.isDarkMode ? PlayerConstants.swatchList[playerNumber].playerSelectedColor : PlayerConstants.swatchList[playerNumber].playerColor;

    if (!userProvider.getUserProfaneMessages() && Utils.isStringProfane(message.body)) {
      return VisibilityDetector(
        key: ValueKey(index),
        onVisibilityChanged: (visibilityInfo) {
          gameProvider.handleGameChatReadStatus(visibilityInfo, userProvider.getUserID(), index);
        },
        child: CustomListTileWidget(
          leading: isMe
              ? null
              : UserAvatarWidget(
                  backgroundColor: playerColor, avatar: gameProvider.currentGame!.players[playerNumber].avatar, borderColor: Theme.of(context).colorScheme.onSurface),
          trailing: isMe
              ? UserAvatarWidget(backgroundColor: playerColor, avatar: gameProvider.currentGame!.players[playerNumber].avatar, borderColor: Theme.of(context).colorScheme.onSurface)
              : null,
          title: Text(
            DialogueService.messageContainsProfanityText.tr,
            style: TextStyles.chatListSubtitleStyle(Theme.of(context).colorScheme.onSurface, true),
            textAlign: textAlign,
          ),
        ),
      );
    } else {
      return VisibilityDetector(
        key: ValueKey(index),
        onVisibilityChanged: (visibilityInfo) {
          gameProvider.handleGameChatReadStatus(visibilityInfo, userProvider.getUserID(), index);
        },
        child: CustomListTileWidget(
          leading: isMe
              ? null
              : UserAvatarWidget(
                  backgroundColor: playerColor, avatar: gameProvider.currentGame!.players[playerNumber].avatar, borderColor: Theme.of(context).colorScheme.onSurface),
          trailing: isMe
              ? UserAvatarWidget(backgroundColor: playerColor, avatar: gameProvider.currentGame!.players[playerNumber].avatar, borderColor: Theme.of(context).colorScheme.onSurface)
              : null,
          title: Text(
            isMe ? DialogueService.youText.tr : gameProvider.getPlayerNameFromId(message.createdById),
            style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface),
            textAlign: textAlign,
          ),
          subtitle: Text(
            message.body,
            style: TextStyles.chatListSubtitleStyle(
              Theme.of(context).colorScheme.onSurface,
              !userProvider.getUserProfaneMessages() && Utils.isStringProfane(message.body),
            ),
            textAlign: textAlign,
          ),
        ),
      );
    }
  }
}
