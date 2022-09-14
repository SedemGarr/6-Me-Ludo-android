import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../../../../../constants/app_constants.dart';

class GameCommentaryWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const GameCommentaryWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gameProvider.playerSelectedColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
              padding: AppConstants.bannerPadding,
              child: Text(
                gameProvider.currentGame.reaction.reactionType,
                style: TextStyles.appBarTitleStyle(Utils.getContrastingColor(gameProvider.playerSelectedColor)),
                textAlign: TextAlign.center,
                maxLines: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
