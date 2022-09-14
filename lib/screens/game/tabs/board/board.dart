import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/game_commentary_widget.dart';

import '../../../../constants/app_constants.dart';
import '../../../../models/game.dart';
import '../../../../providers/game_provider.dart';
import '../players/widgets/dice_FAB_widget.dart';

class BoardWidget extends StatefulWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;

  const BoardWidget({super.key, required this.gameProvider, required this.userProvider});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    GameProvider gameProvider = context.watch<GameProvider>();
    UserProvider userProvider = context.watch<UserProvider>();

    Game game = gameProvider.currentGame;

    return Scaffold(
      body: Column(
        children: [
          GameCommentaryWidget(gameProvider: gameProvider),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2), borderRadius: BorderRadius.circular(2)),
            height: Get.width,
            width: Get.width,
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
          const Spacer(),
        ],
      ),
      floatingActionButton: game.hasSessionEnded || !game.hasStarted
          ? null
          : DiceFABWidget(
              gameProvider: gameProvider,
              userProvider: userProvider,
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
