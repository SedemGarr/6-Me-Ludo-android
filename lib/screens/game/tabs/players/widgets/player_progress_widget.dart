import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

class PlayerProgressWidget extends StatelessWidget {
  final Player player;
  final bool hasStarted;

  const PlayerProgressWidget({super.key, required this.player, required this.hasStarted});

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedCrossFade(
        firstChild: LinearProgressIndicator(
          value: Player.getPlayerProgess(player),
          valueColor: AlwaysStoppedAnimation<Color>(Utils.getContrastingColor(PlayerConstants.swatchList[player.playerColor].playerColor)),
          backgroundColor: PlayerConstants.swatchList[player.playerColor].playerColor,
        ),
        secondChild: const SizedBox.shrink(),
        condition: hasStarted);
  }
}
