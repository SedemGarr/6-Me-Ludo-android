import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/widgets/new_game_button.dart';

import '../../../../constants/textstyle_constants.dart';
import '../../../../services/translations/dialogue_service.dart';

class NoLocalGamesWidget extends StatelessWidget {
  const NoLocalGamesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DialogueService.noLocalGamesText.tr,
              style: TextStyles.noGamesStyle(
                Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          const NewGameButton(),
        ],
      ),
    );
  }
}
