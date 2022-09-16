import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/player_list_item.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/reorder_players_banner.dart';

import '../../../../models/game.dart';
import '../../../../models/player.dart';
import '../board/widgets/game_settings_widget.dart';

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
          child: ReorderableListView.builder(
            footer: !game.hasStarted ? const ReorderPlayersBanner() : null,
            itemCount: players.length,
            onReorder: (oldIndex, newIndex) {
              gameProvider.reorderPlayerList(oldIndex, newIndex);
            },
            buildDefaultDragHandles: !game.hasStarted,
            itemBuilder: (context, index) {
              return PlayerListItemWidget(key: ValueKey(index), index: index);
            },
          ),
        ),
        GameSettingsWidget(
          gameProvider: gameProvider,
        ),
      ],
    );
  }
}
