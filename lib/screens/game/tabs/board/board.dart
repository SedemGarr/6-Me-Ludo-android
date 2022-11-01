import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/board_grid_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/game_commentary_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/game_reaction_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/last_played_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/die_wrapper.dart';
import 'package:six_me_ludo_android/widgets/custom_animated_crossfade.dart';

import '../../../../models/game.dart';
import '../../../../providers/game_provider.dart';

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

    Game game = gameProvider.currentGame!;

    return Scaffold(
      body: AbsorbPointer(
        absorbing: !gameProvider.isPlayerTurn(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GameCommentaryWidget(gameProvider: gameProvider),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: CSSColors.black),
              ),
              height: Get.width,
              width: Get.width,
              child: BoardGridWidget(
                gameProvider: gameProvider,
              ),
            ),
            const Spacer(),
            CustomAnimatedCrossFade(
              firstChild: GameReactionWidget(gameProvider: gameProvider),
              secondChild: LastPlayedAtWidget(gameProvider: gameProvider),
              condition: game.reaction.hasReaction(),
            )
          ],
        ),
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
