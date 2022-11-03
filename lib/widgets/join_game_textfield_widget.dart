import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../constants/textstyle_constants.dart';

class JoinGameTextFieldWidget extends StatelessWidget {
  const JoinGameTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    AppProvider appProvider = context.watch<AppProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
      child: TextFormField(
        controller: gameProvider.joinGameController,
        maxLength: AppConstants.joinGameCodeLength,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: false,
          hintText: DialogueService.joinGameHintText.tr,
          hintStyle: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.tertiary),
          counterStyle: TextStyles.listSubtitleStyle(
            Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        style: TextStyles.listTitleStyle(
          Theme.of(context).colorScheme.onBackground,
        ),
        onChanged: (value) {
          if (value.length == AppConstants.joinGameCodeLength) {
            gameProvider.joinGameWithCode(userProvider.getUser(), appProvider);
          }
        },
      ),
    );
  }
}
