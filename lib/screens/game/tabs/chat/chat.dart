

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/widgets/chat_form_field.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/widgets/chat_list_item.dart';

import '../../../../providers/sound_provider.dart';
import '../../../../providers/user_provider.dart';

class ChatWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;
  final SoundProvider soundProvider;

  const ChatWidget({super.key, required this.gameProvider, required this.userProvider, required this.soundProvider,});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();
    Game game = gameProvider.currentGame;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: game.thread.length,
            itemBuilder: (context, index) {
              return ChatListItem(index: index);
            },
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
