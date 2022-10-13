import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_actions_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_date_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_has_started_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_name_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_owner_avatar_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_player_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/custom_list_tile.dart';
import 'package:six_me_ludo_android/widgets/custom_text_button.dart';

import '../../../../models/game.dart';
import '../../../../models/player.dart';

class OnGoingGamesListItemWidget extends StatelessWidget {
  final int index;

  const OnGoingGamesListItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();

    Game game = userProvider.ongoingGames[index];
    Player host = userProvider.getOngoingGamesHostPlayerAtIndex(game);

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: GameOwnerAvatarWidget(
          id: host.id,
          avatar: host.avatar,
          playerColor: host.playerColor,
        ),
        title: GameNameWidget(host: host, players: game.players),
        subtitle: GameDateWidget(createdAt: game.createdAt),
        trailing: GameHasStarteWidget(hasGameStarted: game.hasStarted),
        children: [
          for (int i = 0; i < game.players.length; i++)
            if (game.players[i].id != host.id)
              GamePlayerWidget(
                player: game.players[i],
                game: game,
                userProvider: userProvider,
              ),
          GameActionsWidget(
            game: game,
            gameProvider: gameProvider,
            host: host,
            userProvider: userProvider,
          )
        ],
      ),
    );
  }
}
