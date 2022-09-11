import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/widgets/custom_text_button.dart';

import '../../../providers/user_provider.dart';
import '../../../services/translations/dialogue_service.dart';

class NewGameButton extends StatelessWidget {
  const NewGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return CustomTextButton(
      onPressed: () {
        userProvider.handleNewGameTap();
      },
      text: DialogueService.newGameText.tr,
      color: Get.isDarkMode ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
    );
  }
}
