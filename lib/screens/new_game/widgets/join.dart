import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/custom_textfield_widget.dart';

class JoinGameView extends StatelessWidget {
  const JoinGameView({super.key});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();

    return GestureDetector(
      onTap: () {
        Utils.dismissKeyboard();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFieldWidget(
              controller: gameProvider.joinGameController,
              maxLength: AppConstants.joinGameCodeLength,
              hint: DialogueService.joinGameHintText.tr,
            ),
          ),
        ),
      ),
    );
  }
}
