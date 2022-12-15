import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/local_games/no_local_games.dart';

class LocalGameWidget extends StatelessWidget {
  const LocalGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();

    return gameProvider.isThereLocalGame() ? Container() : const NoLocalGamesWidget();
  }
}
