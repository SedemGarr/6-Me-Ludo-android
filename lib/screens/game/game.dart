import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/board.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/chat.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/players.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/copy_button_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/end_button_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/restart_button_widget.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/widgets/start_button_widget.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/back_button_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_appbar.dart';
import 'package:six_me_ludo_android/widgets/loading_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late GameProvider gameProvider;
  late NavProvider navProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    gameProvider = context.read<GameProvider>();
    userProvider = context.read<UserProvider>();
    gameProvider.initialiseBoard();
    gameProvider.showGameIdSnackbar(userProvider.getUserID());
    navProvider = context.read<NavProvider>();
    navProvider.initialiseGameScreenTabController(this);
  }

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();
    UserProvider userProvider = context.watch<UserProvider>();
    NavProvider navProvider = context.watch<NavProvider>();
    SoundProvider soundProvider = context.watch<SoundProvider>();

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
              gameProvider.syncGameData(context, snapshot.data!, userProvider.getUserID());

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
                    actions: [
                      RestartButtonWidget(
                        gameProvider: gameProvider,
                        userProvider: userProvider,
                      ),
                      StartButtonWidget(
                        gameProvider: gameProvider,
                        userProvider: userProvider,
                      ),
                      EndGameButtonWidget(
                        gameProvider: gameProvider,
                        userProvider: userProvider,
                      ),
                      CopyGameIDButtonWidget(
                        gameProvider: gameProvider,
                        userProvider: userProvider,
                      ),
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
                    BoardWidget(
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
            } else {
              gameProvider.handleSuddenGameDeletion();
              return const LoadingScreen();
            }
          }),
    );
  }
}
