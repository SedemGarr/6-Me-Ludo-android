// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/dice_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/pass_button_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

import '../../../../../providers/game_provider.dart';
import '../../../../../widgets/custom_fab.dart';

class DiceFABWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const DiceFABWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;
    int value = game.die.rolledValue;
    bool isDieRolling = game.die.isRolling;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: CustomAnimatedCrossFade(
            firstChild: PassButtonWidget(gameProvider: gameProvider),
            secondChild: const SizedBox.shrink(),
            condition: gameProvider.isPlayerTurn() && !game.die.isRolling && game.die.rolledValue != 0 && game.canPass,
          ),
        ),
        CustomFABWidget(
          color: Colors.transparent,
          onPressed: gameProvider.canPlayerRollDie()
              ? () {
                  gameProvider.rollDie(userProvider.getUserID());
                }
              : null,
          widget: DiceWidget(
            gameProvider: gameProvider,
            playerNumber: game.playerTurn,
            shouldAnimate: isDieRolling,
            value: isDieRolling ? 0 : value,
            key: UniqueKey(),
          ),
        ),
      ],
    );
  }
}
