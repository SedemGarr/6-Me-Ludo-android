import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/ongoing_games_list_item.dart';
import 'package:six_me_ludo_android/services/local_storage_service.dart';

import '../../../../models/game.dart';

class LocalGameItem extends StatefulWidget {
  const LocalGameItem({super.key});

  @override
  State<LocalGameItem> createState() => _LocalGameItemState();
}

class _LocalGameItemState extends State<LocalGameItem> {
  late Game game;

  @override
  void initState() {
    super.initState();
    game = LocalStorageService.getLocalGame()!;
  }

  @override
  Widget build(BuildContext context) {
    return OnGoingGamesListItemWidget(game: game);
  }
}
