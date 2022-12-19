import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/screens/home/widgets/local_games/local_game_item.dart';
import 'package:six_me_ludo_android/screens/home/widgets/local_games/no_local_games.dart';

import '../../../../services/local_storage_service.dart';

class LocalGameWidget extends StatelessWidget {
  const LocalGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LocalStorageService.isThereLocalGame() ? const LocalGameItem() : const NoLocalGamesWidget(),
    );
  }
}
