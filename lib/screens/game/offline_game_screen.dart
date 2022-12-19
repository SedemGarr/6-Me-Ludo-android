import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/board.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/end_game_screen/end_game_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/players.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/pass_button_widget.dart';
import 'package:six_me_ludo_android/widgets/loading_screen.dart';

import '../../constants/app_constants.dart';
import '../../constants/icon_constants.dart';
import '../../constants/textstyle_constants.dart';
import '../../models/user.dart';
import '../../providers/app_provider.dart';
import '../../providers/game_provider.dart';
import '../../providers/nav_provider.dart';
import '../../providers/sound_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/translations/dialogue_service.dart';
import '../../widgets/back_button_widget.dart';
import '../../widgets/custom_appbar.dart';

class OfflineGameScreen extends StatelessWidget {
  final GameProvider gameProvider;
  final UserProvider userProvider;
  final NavProvider navProvider;
  final SoundProvider soundProvider;

  const OfflineGameScreen({super.key, required this.gameProvider, required this.userProvider, required this.navProvider, required this.soundProvider});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();

    try {
      gameProvider.syncGameData(context, gameProvider.currentGame!, userProvider.getUser());

      Users user = userProvider.getUser();
      Game game = gameProvider.currentGame!;
      bool isHost = user.id == game.hostId;

      // bool shouldShowShareAndCopyPopups = gameProvider.isPlayerHost(userProvider.getUserID()) && !game.isOffline;
      // bool canEditGameSettings = (!game.hasStarted && isHost) || (!game.hasStarted && game.hasSessionEnded && isHost);
      bool canSkip = gameProvider.isPlayerTurn() && !game.die.isRolling && game.die.rolledValue != 0 && game.canPass;

      return GestureDetector(
        onTap: () {
          AppProvider.dismissKeyboard();
        },
        child: Scaffold(
          appBar: CustomAppBarWidget(
            centerTitle: true,
            backgroundColor: gameProvider.playerSelectedColor,
            leading: BackButtonWidget(
                color: ThemeProvider.getContrastingColor(gameProvider.playerColor),
                onPressed: () {
                  navProvider.handleGameScreenBackPress(gameProvider);
                }),
            title: game.hasSessionEnded
                ? Text(
                    DialogueService.gameSessionEndedText.tr,
                    style: TextStyles.listTitleStyle(ThemeProvider.getContrastingColor(gameProvider.playerColor)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            actions: [
              if (canSkip)
                PassButtonWidget(
                  gameProvider: gameProvider,
                  userProvider: userProvider,
                ),
              PopupMenuButton(
                icon: Icon(
                  AppIcons.menuIcon,
                  color: ThemeProvider.getContrastingColor(gameProvider.playerColor),
                ),
                onSelected: (value) {
                  gameProvider.handleGamePopupSelection(value, userProvider.getUser(), context);
                },
                itemBuilder: (context) {
                  return [
                    if (game.hasStarted && gameProvider.isPlayerHost(userProvider.getUserID()))
                      PopupMenuItem(
                        value: 0,
                        child: Text(
                          DialogueService.restartGamePopupText.tr,
                          style: TextStyles.popupMenuStyle(Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                    if (isHost && !game.hasSessionEnded)
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          !game.hasStarted && gameProvider.isPlayerHost(userProvider.getUserID()) && game.players.length > 1
                              ? DialogueService.startSessionPopupText.tr
                              : DialogueService.stopSessionPopupText.tr,
                          style: TextStyles.popupMenuStyle(Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        isHost ? DialogueService.endGamePopupText.tr : DialogueService.leaveGameTooltipText.tr,
                        style: TextStyles.popupMenuStyle(Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                    // if (shouldShowShareAndCopyPopups)
                    //   PopupMenuItem(
                    //     value: 3,
                    //     child: Text(
                    //       DialogueService.copyGameIDPopupText.tr,
                    //       style: TextStyles.popupMenuStyle(Theme.of(context).colorScheme.onBackground),
                    //     ),
                    //   ),
                    // if (shouldShowShareAndCopyPopups)
                    //   PopupMenuItem(
                    //     value: 4,
                    //     child: Text(
                    //       DialogueService.shareGameIDPopupText.tr,
                    //       style: TextStyles.popupMenuStyle(Theme.of(context).colorScheme.onBackground),
                    //     ),
                    //   ),
                    // PopupMenuItem(
                    //   value: 5,
                    //   child: Text(
                    //     canEditGameSettings ? DialogueService.changeGameSettingsPopupText.tr : DialogueService.viewGameSettingsPopupText.tr,
                    //     style: TextStyles.popupMenuStyle(Theme.of(context).colorScheme.onBackground),
                    //   ),
                    // ),
                  ];
                },
              )
            ],
            bottom: TabBar(
              controller: navProvider.gameScreenTabController,
              tabs: [
                Tab(
                  text: DialogueService.playerTabText.tr,
                ),
                Tab(
                  text: DialogueService.boardTabText.tr,
                ),
                // Tab(
                //   text: DialogueService.chatTabText.tr + gameProvider.getGameChatUnreadCountAsString(userProvider.getUserID()),
                // ),
              ],
              unselectedLabelColor: ThemeProvider.getContrastingColor(gameProvider.playerColor),
              labelColor: ThemeProvider.getContrastingColor(gameProvider.playerColor),
              indicatorColor: ThemeProvider.getContrastingColor(gameProvider.playerColor),
            ),
            size: AppConstants.customAppbarWithTabbarHeight,
          ),
          body: TabBarView(controller: navProvider.gameScreenTabController, children: [
            PlayersWidget(
              gameProvider: gameProvider,
            ),
            if (!game.hasSessionEnded)
              BoardWidget(
                gameProvider: gameProvider,
                userProvider: userProvider,
              )
            else
              EndGameWidget(
                gameProvider: gameProvider,
                userProvider: userProvider,
              ),
            // ChatWidget(
            //   gameProvider: gameProvider,
            //   soundProvider: soundProvider,
            //   userProvider: userProvider,
            // )
          ]),
        ),
      );
    } catch (e) {
      gameProvider.handleSuddenGameDeletion();
      return const LoadingScreen();
    }
  }
}
