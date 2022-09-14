// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/dice_widget.dart';

import '../../../../../constants/player_constants.dart';
import '../../../../../providers/game_provider.dart';
import '../../../../../widgets/custom_fab.dart';

class DiceFABWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const DiceFABWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    return CustomFABWidget(
      color: PlayerConstants.swatchList[gameProvider.currentGame.playerTurn].playerSelectedColor,
      onPressed: () {},
      widget: DiceWidget(
        gameProvider: gameProvider,
        userProvider: userProvider,
      ),
    );
  }
}
