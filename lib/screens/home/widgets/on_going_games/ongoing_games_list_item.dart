import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_actions_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_date_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_has_started_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_name_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_owner_avatar_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_player_widget.dart';

import '../../../../models/game.dart';
import '../../../../models/player.dart';
import '../../../../widgets/custom_divider.dart';

class OnGoingGamesListItemWidget extends StatelessWidget {
  final Game game;

  const OnGoingGamesListItemWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();

    Player host = userProvider.getOngoingGamesHostPlayerAtIndex(game);

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ClipRRect(
        borderRadius: AppConstants.appBorderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppConstants.appBorderRadius,
          ),
          child: ExpansionTile(
            collapsedBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(AppConstants.appOpacity),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            childrenPadding: const EdgeInsets.only(bottom: 8.0),
            key: PageStorageKey(userProvider.getGameIndex(game)),
            leading: GameOwnerAvatarWidget(
              id: host.id,
              avatar: host.avatar,
              playerColor: host.playerColor,
              hasLeft: host.hasLeft,
            ),
            title: GameNameWidget(host: host, players: game.players),
            subtitle: GameDateWidget(createdAt: game.createdAt),
            trailing: GameHasStarteWidget(hasGameStarted: game.hasStarted),
            children: [
              Column(
                children: [
                  const CustomDividerWidget(),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
