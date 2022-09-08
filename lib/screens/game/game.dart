import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();
    gameProvider.initialiseBoard(context);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(2)),
        height: Get.width * 0.99,
        width: Get.width * 0.99,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 15),
          itemCount: gameProvider.board.cells.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              columnCount: 15,
              position: index,
              duration: AppConstants.animationDuration,
              child: FlipAnimation(
                child: FadeInAnimation(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      border: gameProvider.board.cells[index].border,
                      color: gameProvider.board.cells[index].cellColor,
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
        ),
      ),
    );
  }
}
