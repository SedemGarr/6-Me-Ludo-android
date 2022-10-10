import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/board.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/piece_widget.dart';

import '../../../../../constants/app_constants.dart';

class BoardGridWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const BoardGridWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Board.boardGridColumnCount,
      ),
      itemCount: gameProvider.board.cells.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredGrid(
          columnCount: Board.boardGridColumnCount,
          position: index,
          duration: AppConstants.animationDuration,
          child: FlipAnimation(
            child: FadeInAnimation(
              child: AnimatedContainer(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  border: gameProvider.board.cells[index].border,
                  color: gameProvider.getSelectedPiecePathColour(index, gameProvider.board.cells[index].cellColor),
                ),
                child:
                    // Center(child: Text(index.toString(), style: const TextStyle(color: Colors.white))),
                    PieceWidget(gameProvider: gameProvider, userProvider: userProvider, index: index),
              ),
            ),
          ),
        );
      },
    );
  }
}
