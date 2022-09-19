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

    return TextFormField(
      controller: gameProvider.joinGameController,
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        hintText: DialogueService.joinGameHintText.tr,
        filled: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        hintStyle: TextStyles.textFieldStyle(
          Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
        ),
        counterStyle: TextStyles.textFieldStyle(
          Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      style: TextStyles.textFieldStyle(
        Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary,
      ),
      cursorColor: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.length == AppConstants.joinGameCodeLength) {
          gameProvider.joinGameWithCode(userProvider.getUser(), appProvider);
        }
      },
    );
  }
}