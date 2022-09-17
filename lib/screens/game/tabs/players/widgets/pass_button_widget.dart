import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/textstyle_constants.dart';

class PassButtonWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const PassButtonWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    Color color = Get.isDarkMode ? gameProvider.playerSelectedColor : gameProvider.playerColor;
    Color contrastingColor = Utils.getContrastingColor(color);

    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(color),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all(
          AppConstants.appShape,
        ),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8.0)),
      ),
      onPressed: () {
        gameProvider.passTurn();
      },
      child: Text(
        DialogueService.passTurnButtonText.tr,
        style: TextStyles.elevatedButtonStyle(contrastingColor),
      ),
    );
  }
}
