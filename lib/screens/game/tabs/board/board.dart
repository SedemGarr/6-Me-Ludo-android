import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/game_commentary_widget.dart';

import '../../../../constants/app_constants.dart';
import '../../../../providers/game_provider.dart';

class BoardWidget extends StatefulWidget {
  final GameProvider gameProvider;

  const BoardWidget({super.key, required this.gameProvider});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    GameProvider gameProvider = context.watch<GameProvider>();

    return Column(
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
