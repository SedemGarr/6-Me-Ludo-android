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
      padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
      child: TextFormField(
        controller: gameProvider.joinGameController,
        maxLength: AppConstants.joinGameCodeLength,
        cursorColor: Theme.of(context).primaryColor,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          filled: false,
          hintText: DialogueService.joinGameHintText.tr,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          hintStyle: TextStyles.listSubtitleStyle(Theme.of(context).colorScheme.primaryContainer),
          counterStyle: TextStyles.listSubtitleStyle(
            Theme.of(context).colorScheme.onSurface,
          ),
        ),
        style: TextStyles.listTitleStyle(
          Theme.of(context).colorScheme.primary,
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
