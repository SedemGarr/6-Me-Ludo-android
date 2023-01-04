import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../providers/theme_provider.dart';
import '../../../../../widgets/general/custom_animated_crossfade.dart';

class GameCommentaryWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const GameCommentaryWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedCrossFade(
        firstChild: const SizedBox.shrink(),
        secondChild: AnimatedContainer(
          duration: AppConstants.animationDuration,
          //  color: PlayerConstants.swatchList[gameProvider.currentGame!.playerTurn].playerSelectedColor,
          color: gameProvider.playerSelectedColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: AppConstants.bannerPadding,
                  child: Text(
                    gameProvider.getGameStatusText(),
                    style: TextStyles.appBarTitleStyle(ThemeProvider.getContrastingColor(gameProvider.playerColor)),
                    textAlign: TextAlign.center,
                    maxLines: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        condition: gameProvider.getGameStatusText().isEmpty);
  }
}
