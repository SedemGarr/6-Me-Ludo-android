import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/models/user.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/board.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/end_game_screen/end_game_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/widgets/game_settings_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/chat.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/players.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/pass_button_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/back_button_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_appbar.dart';
import 'package:six_me_ludo_android/widgets/loading_screen.dart';

import '../../models/thread.dart';

class GameScreenWrapper extends StatefulWidget {
  static String routeName = '/GameScreen';

  const GameScreenWrapper({super.key});

  @override
  State<GameScreenWrapper> createState() => _GameScreenWrapperState();
}

class _GameScreenWrapperState extends State<GameScreenWrapper> with SingleTickerProviderStateMixin {
  late GameProvider gameProvider;
  late NavProvider navProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    gameProvider = context.read<GameProvider>();
    userProvider = context.read<UserProvider>();
    navProvider = context.read<NavProvider>();
    gameProvider.initialiseBoard();
    gameProvider.showGameIdSnackbar(userProvider.getUserID());
    userProvider.handleWakelockLogic(true);
    navProvider.initialiseGameScreenTabController(this, gameProvider.getGameTabControllerLength());
  }

  @override
  void dispose() {
    userProvider.handleWakelockLogic(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    NavProvider navProvider = context.watch<NavProvider>();
    SoundProvider soundProvider = context.watch<SoundProvider>();

    Users user = userProvider.getUser();
    Game game = gameProvider.currentGame!;
    bool isHost = user.id == game.hostId;

    return WillPopScope(
      onWillPop: () async {
        navProvider.handleGameScreenBackPress(gameProvider);
        return false;
      },
      child: StreamBuilder<Game>(
          stream: gameProvider.currentGameStream,
          initialData: gameProvider.currentGame,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.hasData) {
              gameProvider.syncGameData(context, snapshot.data!, userProvider.getUser());

              return StreamBuilder<Thread>(
                  stream: gameProvider.currentThreadStream,
                  initialData: gameProvider.currentThread,
                  builder: (context, snapshot) {
                    gameProvider.syncThreadData(context, snapshot.data!, userProvider.getUser());

                    return GestureDetector(
                      onTap: () {
                        Utils.dismissKeyboard();
                      },
                      child: Scaffold(
                        appBar: CustomAppBarWidget(
                          backgroundColor: gameProvider.playerSelectedColor,
                          leading: BackButtonWidget(
                              color: Utils.getContrastingColor(gameProvider.playerColor),
                              onPressed: () {
                                navProvider.handleGameScreenBackPress(gameProvider);
                              }),
                          title: GameSettingsWidget(gameProvider: gameProvider),
                          actions: [
                            if (gameProvider.isPlayerTurn() && !game.die.isRolling && game.die.rolledValue != 0 && game.canPass)
                              PassButtonWidget(
                                gameProvider: gameProvider,
                                userProvider: userProvider,
                              ),
                            PopupMenuButton(
                              icon: Icon(
                                AppIcons.menuIcon,
                                color: Utils.getContrastingColor(gameProvider.playerColor),
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
                                        style: TextStyles.popupMenuStyle(Theme.of(context).colorScheme.onSurface),
                                      ),
                                    ),
                                  if (isHost)
                                    PopupMenuItem(
                                      value: 1,
                                      child: Text(
                                        !game.hasStarted && gameProvider.isPlayerHost(userProvider.getUserID()) && game.players.length > 1
                                            ? DialogueService.startSessionPopupText.tr
                                            : DialogueService.stopSessionPopupText.tr,
                                        style: TextStyles.popupMenuStyle(Theme.of(context).colorScheme.onSurface),
                                      ),
                                    ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: Text(
                                      isHost ? DialogueService.endGamePopupText.tr : DialogueService.leaveGameTooltipText.tr,
                                      style: TextStyles.popupMenuStyle(Theme.of(context).colorScheme.onSurface),
                                    ),
                                  ),
                                  if (gameProvider.isPlayerHost(userProvider.getUserID()))
                                    PopupMenuItem(
                                      value: 3,
                                      child: Text(
                                        DialogueService.copyGameIDPopupText.tr,
                                        style: TextStyles.popupMenuStyle(Theme.of(context).colorScheme.onSurface),
                                      ),
                                    ),
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
                              Tab(
                                text: DialogueService.chatTabText.tr + gameProvider.getGameChatUnreadCountAsString(userProvider.getUserID()),
                              ),
                            ],
                            unselectedLabelColor: Utils.getContrastingColor(gameProvider.playerColor),
                            labelColor: Utils.getContrastingColor(gameProvider.playerColor),
                            indicatorColor: Utils.getContrastingColor(gameProvider.playerColor),
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
                          ChatWidget(
                            gameProvider: gameProvider,
                            soundProvider: soundProvider,
                            userProvider: userProvider,
                          )
                        ]),
                      ),
                    );
                  });
            } else {
              gameProvider.handleSuddenGameDeletion();
              return const LoadingScreen();
            }
          }),
    );
  }
}
