import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';

import '../../../../../constants/textstyle_constants.dart';

class PlayerPresenceWidget extends StatelessWidget {
  final bool isPresent;
  final Color color;
  final GameProvider gameProvider;

  const PlayerPresenceWidget({super.key, required this.isPresent, required this.color, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    return Text(
      gameProvider.parsePlayerPresenceText(isPresent),
      style: TextStyles.chatListSubtitleStyle(color, !isPresent),
    );
  }
}
