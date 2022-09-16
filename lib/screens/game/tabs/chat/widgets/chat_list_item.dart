import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
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
    Game game = gameProvider.currentGame;

    Message message = game.thread[index];
    bool isMe = message.createdById == userProvider.getUserID();
    TextAlign textAlign = isMe ? TextAlign.end : TextAlign.start;

    return VisibilityDetector(
      key: ValueKey(index),
      onVisibilityChanged: (visibilityInfo) {
        gameProvider.handleGameChatReadStatus(visibilityInfo, userProvider.getUserID(), index);
      },
      child: CustomListTileWidget(
        title: Text(
          isMe ? DialogueService.youText.tr : gameProvider.getPlayerNameFromId(message.createdById),
          style: TextStyles.listTitleStyle(Theme.of(context).colorScheme.onSurface),
          textAlign: textAlign,
        ),
        subtitle: Text(
          !userProvider.getUserProfaneMessages() && Utils.isStringProfane(message.body) ? DialogueService.messageContainsProfanityText.tr : message.body,
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
