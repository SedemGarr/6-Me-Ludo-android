import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list_item.dart';

import '../../../../models/game.dart';

class LocalGameItem extends StatelessWidget {
  const LocalGameItem({super.key});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();

    Game game = gameProvider.getLocalGame()!;

    return OnGoingGamesListItemWidget(game: game);
  }
}
