import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/widgets/user_avatar_widget.dart';

class GameOwnerAvatarWidget extends StatelessWidget {
  final String id;
  final String avatar;
  final int playerColor;

  const GameOwnerAvatarWidget({super.key, required this.avatar, required this.id, required this.playerColor});

  @override
  Widget build(BuildContext context) {
    return UserAvatarWidget(
      id: id,
      avatar: avatar,
      backgroundColor: PlayerConstants.swatchList[playerColor].playerColor,
      borderColor: Theme.of(context).colorScheme.onSurface,
    );
  }
}
