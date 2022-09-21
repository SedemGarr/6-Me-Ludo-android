import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:six_me_ludo_android/models/board.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';

import '../../../../../constants/app_constants.dart';

class BoardGridWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const BoardGridWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: Board.boardGridColumnCount),
      itemCount: gameProvider.board.cells.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
          columnCount: Board.boardGridColumnCount,
          position: index,
          duration: AppConstants.animationDuration,
          child: FlipAnimation(
            child: FadeInAnimation(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  border: gameProvider.board.cells[index].border,
                  color: gameProvider.getSelectedPiecePathColour(index, gameProvider.board.cells[index].cellColor),
                ),
                child:
                    // Text(index.toString(), style: const TextStyle(color: Colors.white)),
                    Center(
                  child: Icon(
                    gameProvider.board.cells[index].icon,
                    color: gameProvider.board.cells[index].iconColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
