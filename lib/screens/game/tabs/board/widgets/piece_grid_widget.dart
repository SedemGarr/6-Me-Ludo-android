import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/models/board.dart';

import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/piece_widget.dart';

class PieceGridWidget extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const PieceGridWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: Board.boardGridColumnCount, mainAxisSpacing: 0.0, crossAxisSpacing: 0.0),
      scrollDirection: Axis.horizontal,
      itemCount: gameProvider.board.cells.length,
      reverse: true,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            gameProvider.handleMovePieceTap(index);
          },
          child: PieceWidget(gameProvider: gameProvider, userProvider: userProvider, index: index),
        );
      },
    );
  }
}
