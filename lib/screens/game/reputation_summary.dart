import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';

import '../../models/player.dart';
import '../../providers/game_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/user/reputation_widget.dart';

class ReputationSummary extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;
  final bool canSkip;

  const ReputationSummary({super.key, required this.gameProvider, required this.userProvider, required this.canSkip});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: canSkip ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        for (Player player in gameProvider.currentGame!.players)
          ReputationWidget(value: player.reputationValue, color: PlayerConstants.swatchList[player.playerColor].playerColor, shouldPad: !canSkip)
      ],
    );
  }
}
