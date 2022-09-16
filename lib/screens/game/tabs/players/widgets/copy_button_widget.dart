import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../../../../constants/icon_constants.dart';
import '../../../../../providers/game_provider.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../utils/utils.dart';

class CopyGameIDButtonWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const CopyGameIDButtonWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    return gameProvider.isPlayerHost(userProvider.getUserID())
        ? Center(
            child: IconButton(
              onPressed: () {
                gameProvider.copyGameID();
              },
              icon: Icon(
                AppIcons.copyGameCodeIcon,
                color: Utils.getContrastingColor(gameProvider.playerColor),
              ),
              tooltip: DialogueService.copyGameTooltipText.tr,
            ),
          )
        : const SizedBox.shrink();
  }
}
