import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/player.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

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
          valueColor: AlwaysStoppedAnimation<Color>(Utils.getContrastingColor(playerColor)),
          backgroundColor: Get.isDarkMode ? playerSelectedColor : playerColor,
        ),
        secondChild: const SizedBox.shrink(),
        condition: hasStarted);
  }
}
