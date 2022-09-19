import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

class PassButtonWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const PassButtonWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    Color color = Get.isDarkMode ? gameProvider.playerSelectedColor : gameProvider.playerColor;
    Color contrastingColor = Utils.getContrastingColor(color);

    return GestureDetector(
      onTap: () {
        gameProvider.passTurn();
      },
      child: Icon(
        AppIcons.skipTurnIcon,
        color: contrastingColor,
      ),
    );
  }
}
