import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/widgets/chat_form_field.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/widgets/chat_list_item.dart';
import 'package:six_me_ludo_android/widgets/animation_wrapper.dart';

import '../../../../providers/sound_provider.dart';
import '../../../../providers/user_provider.dart';

class ChatWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;
  final SoundProvider soundProvider;

  const ChatWidget({
    super.key,
    required this.gameProvider,
    required this.userProvider,
    required this.soundProvider,
  });

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();

    return Column(
      children: [
        Expanded(
          child: AnimationLimiter(
            child: ListView.separated(
              reverse: true,
              itemCount: gameProvider.getGameChatCount(),
              padding: AppConstants.listViewPadding,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8.0,
                );
              },
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: AppConstants.animationDuration,
                  child: CustomAnimationWidget(
                    child: ChatListItem(index: index),
                  ),
                );
              },
            ),
          ),
        ),
        ChatFormFieldWidget(
          gameProvider: gameProvider,
          soundProvider: soundProvider,
          userProvider: userProvider,
        ),
      ],
    );
  }
}
