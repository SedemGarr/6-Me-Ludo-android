import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';

import '../../../../../constants/app_constants.dart';

class GameReactionWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const GameReactionWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;

    return game.reaction.hasReaction()
        ? Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16.0),
                child: SizedBox(
                  height: Get.height * 1 / 7,
                  child: ClipRRect(
                    borderRadius: AppConstants.appBorderRadius,
                    child: Image.asset(
                      game.reaction.reactionURL,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, url, error) => const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
