import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/icon_constants.dart';
import '../../../widgets/new_game_dialog.dart';

class NewGameButton extends StatelessWidget {
  const NewGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showNewGameDialog(context: context);
      },
      icon: Icon(AppIcons.newGameActiveIcon, color: Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary),
    );
  }
}
