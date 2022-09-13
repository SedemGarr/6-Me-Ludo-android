import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/join_game_button.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/custom_textfield_widget.dart';

class JoinGameView extends StatefulWidget {
  const JoinGameView({super.key});

  @override
  State<JoinGameView> createState() => _JoinGameViewState();
}

class _JoinGameViewState extends State<JoinGameView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    GameProvider gameProvider = context.watch<GameProvider>();

    return GestureDetector(
      onTap: () {
        Utils.dismissKeyboard();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextFieldWidget(
                controller: gameProvider.joinGameController,
                maxLength: AppConstants.joinGameCodeLength,
                hint: DialogueService.joinGameHintText.tr,
              ),
              const JoinGameButton()
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
