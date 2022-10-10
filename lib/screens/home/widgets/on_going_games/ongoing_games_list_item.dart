import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/user.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_date_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_has_started_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_name_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_owner_avatar_widget.dart';
import 'package:six_me_ludo_android/services/database_service.dart';
import 'package:six_me_ludo_android/widgets/custom_list_tile.dart';

import '../../../../models/game.dart';
import '../../../../models/player.dart';

class OnGoingGamesListItemWidget extends StatefulWidget {
  final String id;

  const OnGoingGamesListItemWidget({super.key, required this.id});

  @override
  State<OnGoingGamesListItemWidget> createState() => _OnGoingGamesListItemWidgetState();
}

class _OnGoingGamesListItemWidgetState extends State<OnGoingGamesListItemWidget> {
  late Future<Game?> getGame;

  @override
  void initState() {
    getGame = DatabaseService.getGame(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();

    Users user = userProvider.getUser();

    return FutureBuilder<Game?>(
      future: getGame,
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        } else if (snapshot.connectionState == ConnectionState.done && snapshot.data == null) {
          user.removeOngoingGameIDFromList(widget.id);
          return const SizedBox.shrink();
        } else {
          Game game = snapshot.data!;
          Player host = userProvider.getOngoingGamesHostPlayerAtIndex(game);

          return userProvider.shouldGameShow(game)
              ? CustomListTileWidget(
                  leading: GameOwnerAvatarWidget(
                    id: host.id,
                    avatar: host.avatar,
                    playerColor: host.playerColor,
                  ),
                  title: GameNameWidget(host: host, players: game.players),
                  subtitle: GameDateWidget(lastUpdatedAt: game.lastUpdatedAt),
                  trailing: GameHasStarteWidget(hasGameStarted: game.hasStarted),
                  onTap: () {
                    gameProvider.showRejoinGameDialog(game, userProvider.getUser(), context);
                  },
                  onLongPress: () {
                    gameProvider.showLeaveOrDeleteGameDialog(
                      game,
                      userProvider.getUser(),
                      context,
                    );
                  },
                )
              : const SizedBox.shrink();
        }
      },
    );
  }
}
