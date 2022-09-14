import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

import '../../../../../constants/app_constants.dart';

class GameCommentaryWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const GameCommentaryWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedCrossFade(
        firstChild: const SizedBox.shrink(),
        secondChild: Container(
          color: gameProvider.playerSelectedColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: AppConstants.bannerPadding,
                  child: Text(
                    gameProvider.getGameStatusText(),
                    style: TextStyles.appBarTitleStyle(Utils.getContrastingColor(gameProvider.playerColor)),
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
