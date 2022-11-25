import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/custom_text_button.dart';

class PassButtonWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const PassButtonWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    Color color = gameProvider.playerColor;
    Color contrastingColor = Utils.getContrastingColor(color);

    return CustomTextButton(
      onPressed: () {
        gameProvider.passTurn(userProvider.getUser());
      },
      text: DialogueService.skipTurnText.tr,
      color: contrastingColor,
    );

    // return GestureDetector(
    //   onTap: () {
    //     gameProvider.passTurn(userProvider.getUser());
    //   },
    //   child: Icon(
    //     AppIcons.skipTurnIcon,
    //     color: contrastingColor,
    //   ),
    // );
  }
}
