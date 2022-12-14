import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';

import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../constants/textstyle_constants.dart';
import '../../../../../models/game.dart';
import '../../../../../models/message.dart';
import '../../../../../providers/app_provider.dart';
import '../../../../../widgets/general/custom_list_tile.dart';
import '../../../../../widgets/user/user_avatar_widget.dart';


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

    if (playerNumber == -1) {
      return const SizedBox.shrink();
    }

    bool hasLeft = game.players[playerNumber].hasLeft;
    Color playerColor = PlayerConstants.swatchList[playerNumber].playerColor;
    Color playerSelectedColor = PlayerConstants.swatchList[playerNumber].playerSelectedColor;

    if (!userProvider.getUserProfaneMessages() && AppProvider.isStringProfane(message.body)) {
      return VisibilityDetector(
        key: ValueKey(index),
        onVisibilityChanged: (visibilityInfo) {
          gameProvider.handleGameChatReadStatus(visibilityInfo, userProvider.getUserID(), index);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppConstants.appBorderRadius,
            color: Get.isDarkMode ? playerSelectedColor.withOpacity(AppConstants.appOpacity) : playerColor.withOpacity(AppConstants.appOpacity),
          ),
          child: CustomListTileWidget(
            leading: isMe
                ? null
                : UserAvatarWidget(
                    hasLeftGame: hasLeft,
                    backgroundColor: playerColor,
                    avatar: gameProvider.currentGame!.players[playerNumber].avatar,
                    borderColor: Theme.of(context).colorScheme.onBackground),
            trailing: isMe
                ? UserAvatarWidget(
                    hasLeftGame: hasLeft,
                    backgroundColor: playerColor,
                    avatar: gameProvider.currentGame!.players[playerNumber].avatar,
                    borderColor: Theme.of(context).colorScheme.onBackground)
                : null,
            title: Text(
              DialogueService.messageContainsProfanityText.tr,
              style: TextStyles.chatListSubtitleStyle(Theme.of(context).colorScheme.onBackground, true),
              textAlign: textAlign,
            ),
          ),
        ),
      );
    } else {
      return VisibilityDetector(
        key: ValueKey(index),
        onVisibilityChanged: (visibilityInfo) {
          gameProvider.handleGameChatReadStatus(visibilityInfo, userProvider.getUserID(), index);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppConstants.appBorderRadius,
            color: playerColor.withOpacity(AppConstants.appOpacity),
          ),
          child: CustomListTileWidget(
            leading: isMe
                ? null
                : UserAvatarWidget(
                    hasLeftGame: hasLeft,
                    backgroundColor: playerColor,
                    avatar: gameProvider.currentGame!.players[playerNumber].avatar,
                    borderColor: Theme.of(context).colorScheme.onBackground),
            trailing: isMe
                ? UserAvatarWidget(
                    hasLeftGame: hasLeft,
                    backgroundColor: playerColor,
                    avatar: gameProvider.currentGame!.players[playerNumber].avatar,
                    borderColor: Theme.of(context).colorScheme.onBackground)
                : null,
            title: Text(
              isMe ? DialogueService.youText.tr : gameProvider.getPlayerNameFromId(message.createdById),
              style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onBackground),
              textAlign: textAlign,
            ),
            subtitle: Text(
              message.body,
              style: TextStyles.chatListSubtitleStyle(
                Theme.of(context).colorScheme.onBackground,
                !userProvider.getUserProfaneMessages() && AppProvider.isStringProfane(message.body),
              ),
              textAlign: textAlign,
            ),
          ),
        ),
      );
    }
  }
}
