import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../../../../../models/game.dart';

class PieceWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;
  final int index;

  const PieceWidget({super.key, required this.gameProvider, required this.userProvider, required this.index});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;

    for (int i = 0; i < game.players.length; i++) {
      for (int j = 0; j < game.players[i].pieces.length; j++) {
        if (game.players[i].pieces[j].position == index && !game.players[i].pieces[j].isHome) {
          return FadeIn(
            duration: AppConstants.animationDuration,
            curve: AppConstants.animationCurve,
            child: GestureDetector(
              onTap: () {
                if (gameProvider.getIndexHitDefermentStatus(index)) {
                  gameProvider.handleMovePieceTap(index);
                } else {
                  gameProvider.selectPiece(game.players[i].pieces[j]);
                }
              },
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.all(3.0),
                color: gameProvider.isPieceSelected(game.players[i].pieces[j])
                    ? PlayerConstants.swatchList[game.players[i].pieces[j].owner].playerSelectedColor
                    : PlayerConstants.swatchList[game.players[i].pieces[j].owner].playerColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: CSSColors.black),
                  borderRadius: AppConstants.appBorderRadius,
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        Utils.getInitials(game.players[i].psuedonym),
                        style: TextStyle(color: Utils.getContrastingColor(PlayerConstants.swatchList[game.players[i].pieces[j].owner].playerColor), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    return GestureDetector(
      onTap: () {
        gameProvider.handleMovePieceTap(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              index.toString(),
              style: const TextStyle(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
