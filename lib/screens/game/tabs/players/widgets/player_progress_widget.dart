import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/models/player.dart';

import '../../../../../widgets/general/custom_animated_crossfade.dart';

class PlayerProgressWidget extends StatelessWidget {
  final Player player;
  final bool hasStarted;
  final Color playerColor;
  final Color playerSelectedColor;

  const PlayerProgressWidget({super.key, required this.player, required this.hasStarted, required this.playerColor, required this.playerSelectedColor});

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedCrossFade(
        firstChild: LinearProgressIndicator(
          value: Player.getPlayerProgess(player),
          valueColor: AlwaysStoppedAnimation<Color>(playerSelectedColor),
          backgroundColor: Colors.transparent,
        ),
        secondChild: const SizedBox.shrink(),
        condition: hasStarted);
  }
}
