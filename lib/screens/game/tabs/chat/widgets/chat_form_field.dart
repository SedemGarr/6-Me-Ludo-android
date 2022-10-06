import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/widgets/chat_limit_banner.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/widgets/player_banned_banner_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

import '../../../../../constants/textstyle_constants.dart';
import '../../../../../models/player.dart';
import '../../../../../providers/game_provider.dart';

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: gameProvider.gameChatController,
                          decoration: InputDecoration(
                            hintText: DialogueService.sendMessagesHereText.tr,
                            filled: false,
                            hintStyle: TextStyles.textFieldStyle(Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: gameProvider.playerColor)),
                          ),
                          style: TextStyles.textFieldStyle(Theme.of(context).colorScheme.onSurface),
                          cursorColor: gameProvider.playerColor,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          onFieldSubmitted: (value) {
                            gameProvider.sendChatMessage(userProvider.getUserID(), soundProvider);
                          },
                        ),
                      ),
                      Text(
                        '${gameProvider.getGameChatCount()}/${AppConstants.gameThreadMessageLimit}',
                        style: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                      )
                    ],
                  ),
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
