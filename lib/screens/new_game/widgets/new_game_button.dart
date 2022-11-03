import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_text_button.dart';

class NewGameButton extends StatelessWidget {
  const NewGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();



    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: CustomTextButton(
        isOutlined: false,
        color: Get.isDarkMode ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          userProvider.handleNewGameTap();
        },
        text: DialogueService.newGameText.tr,
      ),
    );
  }
}
