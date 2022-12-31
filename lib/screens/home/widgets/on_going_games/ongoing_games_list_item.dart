import 'package:advance_expansion_tile/advance_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_date_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_name_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_owner_avatar_widget.dart';
import 'package:six_me_ludo_android/screens/home/widgets/on_going_games/widgets/game_player_widget.dart';

import '../../../../models/game.dart';
import '../../../../models/player.dart';
import '../../../../providers/app_provider.dart';
import '../../../../services/translations/dialogue_service.dart';
import '../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../widgets/buttons/custom_outlined_button.dart';
import '../../../../widgets/general/custom_divider.dart';

class OnGoingGamesListItemWidget extends StatelessWidget {
  final Game game;

  const OnGoingGamesListItemWidget({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    GameProvider gameProvider = context.watch<GameProvider>();

    Player host = userProvider.getOngoingGamesHostPlayerAtIndex(game);

    bool isOffline = userProvider.getUserIsOffline();

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ClipRRect(
        borderRadius: AppConstants.appBorderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppConstants.appBorderRadius,
          ),
          child: AdvanceExpansionTile(
            disabled: isOffline,
            initiallyExpanded: isOffline,
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
            subtitle: GameDateWidget(
                text: isOffline
                    ? DialogueService.lastPlayedAtText.tr + AppProvider.parseDateFromNow(game.lastUpdatedAt)
                    : DialogueService.createdAtText.tr + AppProvider.parseDateFromNow(game.createdAt)),
            //  trailing: GameHasStarteWidget(hasGameStarted: game.hasStarted),
            trailing: CustomElevatedButton(
              onPressed: () {
                gameProvider.showRejoinGameDialog(game, userProvider.getUser(), context);
              },
              text: DialogueService.rejoinGameDialogYesText.tr,
            ),
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
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomOutlinedButton(
                      onPressed: () {
                        gameProvider.showLeaveOrDeleteGameDialog(
                          game,
                          userProvider.getUser(),
                          context,
                        );
                      },
                      text: host.id == userProvider.getUserID() ? DialogueService.deleteGameDialogYesText.tr : DialogueService.leaveGameDialogYesText.tr,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
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
