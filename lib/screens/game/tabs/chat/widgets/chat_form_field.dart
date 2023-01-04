import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/widgets/chat_limit_banner.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/widgets/player_banned_banner_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../constants/textstyle_constants.dart';
import '../../../../../models/player.dart';
import '../../../../../providers/game_provider.dart';
import '../../../../../widgets/general/custom_animated_crossfade.dart';

class ChatFormFieldWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;
  final SoundProvider soundProvider;

  const ChatFormFieldWidget({
    super.key,
    required this.gameProvider,
    required this.userProvider,
    required this.soundProvider,
  });

  @override
  Widget build(BuildContext context) {
    return gameProvider.getGameChatCount() > AppConstants.gameThreadMessageLimit
        ? const ChatLimitBannerWidget()
        : CustomAnimatedCrossFade(
            firstChild: const PlayerBannedBannerWidget(),
            secondChild: Column(
              children: [
                const Divider(),
                TextFormField(
                  controller: gameProvider.gameChatController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 8.0),
                    hintText: '${DialogueService.sendMessagesHereText.tr} (${gameProvider.getGameChatCount()}/${AppConstants.gameThreadMessageLimit})',
                    filled: false,
                    hintStyle: TextStyles.textFieldStyle(Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: gameProvider.playerColor)),
                    suffix: IconButton(
                      onPressed: () {
                        gameProvider.sendChatMessage(userProvider.getUserID(), soundProvider);
                      },
                      icon: Icon(
                        AppIcons.sendMessageIcon,
                        color: gameProvider.playerColor,
                      ),
                    ),
                  ),
                  style: TextStyles.textFieldStyle(Theme.of(context).colorScheme.onBackground),
                  cursorColor: gameProvider.playerColor,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  onFieldSubmitted: (value) {
                    gameProvider.sendChatMessage(userProvider.getUserID(), soundProvider);
                  },
                ),
              ],
            ),
            condition: Player.isPlayerBannedFromChat(
              gameProvider.currentGame!.bannedPlayers,
              userProvider.getUserID(),
            ),
          );
  }
}
