import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';

import '../../../../../models/game.dart';
import '../../../../../providers/theme_provider.dart';

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
          bool isSelected = gameProvider.isPieceSelected(game.players[i].pieces[j]);

          return FadeIn(
            duration: AppConstants.animationDuration,
            curve: AppConstants.animationCurve,
            child: GestureDetector(
              onTap: () {
                if (gameProvider.getIndexHitDefermentStatus(index)) {
                  gameProvider.handleMovePieceTap(index, userProvider.getUser());
                } else {
                  gameProvider.selectPiece(game.players[i].pieces[j]);
                }
              },
              child: AnimatedContainer(
                duration: AppConstants.animationDuration,
                margin: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? PlayerConstants.swatchList[game.players[i].pieces[j].owner].playerSelectedColor
                      //  : PlayerConstants.swatchList[game.players[i].pieces[j].owner].playerColor,
                      : null,
                  gradient: AppConstants.getLinearGradient([
                    isSelected
                        ? PlayerConstants.swatchList[game.players[i].pieces[j].owner].playerSelectedColor
                        : PlayerConstants.swatchList[game.players[i].pieces[j].owner].playerColor,
                    PlayerConstants.swatchList[game.players[i].pieces[j].owner].playerSelectedColor,
                  ]),
                  border: Border.all(
                    color: CSSColors.black,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: AppConstants.appBorderRadius,
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        UserProvider.getInitials(game.players[i].psuedonym),
                        style: TextStyle(
                          color: isSelected ? AppConstants.blackColor : ThemeProvider.getContrastingColor(PlayerConstants.swatchList[game.players[i].pieces[j].owner].playerColor),
                          fontStyle: isSelected ? FontStyle.italic : FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
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
        gameProvider.handleMovePieceTap(index, userProvider.getUser());
      },
      child: Center(
        child: Icon(
          gameProvider.board.cells[index].icon,
          color: gameProvider.board.cells[index].iconColor,
        ),
      ),
    );
  }
}
