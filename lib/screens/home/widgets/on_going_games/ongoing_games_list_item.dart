import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_date_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_has_started_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_name_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_owner_avatar_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_list_tile.dart';

import '../../../../models/game.dart';
import '../../../../models/player.dart';

class OnGoingGamesListItemWidget extends StatelessWidget {
  final int index;

  const OnGoingGamesListItemWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();

    Game game = userProvider.getOngoingGameAtIndex(index);
    Player host = userProvider.getOngoingGamesHostPlayerAtIndex(index);

    return CustomListTileWidget(
      leading: GameOwnerAvatarWidget(
        id: host.id,
        avatar: host.avatar,
        playerColor: host.playerColor,
      ),
      title: GameNameWidget(host: host, players: game.players),
      subtitle: GameDateWidget(lastUpdatedAt: game.lastUpdatedAt),
      trailing: GameHasStarteWidget(hasGameStarted: game.hasStarted),
      onTap: () {
        gameProvider.showRejoinGameDialog(game, userProvider.getUserID(), context);
      },
      onLongPress: () {
        gameProvider.showLeaveOrDeleteGameDialog(
          game,
          userProvider.getUserID(),
          context,
        );
      },
    );
  }
}
