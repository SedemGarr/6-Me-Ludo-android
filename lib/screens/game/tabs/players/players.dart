import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/player_list_item.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/reorder_players_banner.dart';
import 'package:six_me_ludo_android/widgets/animation_wrapper.dart';

import '../../../../models/game.dart';
import '../../../../models/player.dart';

class PlayersWidget extends StatelessWidget {
  final GameProvider gameProvider;

  const PlayersWidget({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    Game game = gameProvider.currentGame!;
    List<Player> players = game.players;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: AnimationLimiter(
              child: ReorderableListView.builder(
                footer: !game.hasStarted ? const ReorderPlayersBanner() : null,
                itemCount: players.length,
                onReorder: (oldIndex, newIndex) {
                  gameProvider.reorderPlayerList(oldIndex, newIndex);
                },
                buildDefaultDragHandles: !game.hasStarted,
                itemBuilder: (context, index) {
                  Key key = ValueKey(index);

                  return AnimationConfiguration.staggeredList(
                    key: key,
                    position: index,
                    duration: AppConstants.animationDuration,
                    child: CustomAnimationWidget(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        child: PlayerListItemWidget(key: key, index: index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
