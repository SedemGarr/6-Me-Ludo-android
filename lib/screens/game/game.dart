import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/constants/icon_constants.dart';
import 'package:six_me_ludo_android/constants/player_constants.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/board.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/chat.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/players.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/back_button_widget.dart';
import 'package:six_me_ludo_android/widgets/custom_appbar.dart';
import 'package:six_me_ludo_android/widgets/custom_fab.dart';
import 'package:six_me_ludo_android/widgets/loading_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late GameProvider gameProvider;
  late NavProvider navProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    gameProvider = context.read<GameProvider>();
    navProvider = context.read<NavProvider>();
    gameProvider.initialiseBoard(context);
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
        navProvider.handleGameScreenBackPress();
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
                    leading: BackButtonWidget(onPressed: () {
                      NavigationService.genericGoBack();
                    }),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(AppIcons.aIPersonalityTypeIcon),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(AppIcons.aIPersonalityTypeIcon),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(AppIcons.aIPersonalityTypeIcon),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(AppIcons.aIPersonalityTypeIcon),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(AppIcons.aIPersonalityTypeIcon),
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
                    ),
                    ChatWidget(
                      gameProvider: gameProvider,
                      soundProvider: soundProvider,
                      userProvider: userProvider,
                    )
                  ]),
                  floatingActionButton: CustomFABWidget(
                    color: PlayerConstants.swatchList[gameProvider.currentGame.playerTurn].playerSelectedColor,
                    onPressed: () {},
                    widget: Icon(AppIcons.aIPersonalityTypeIcon),
                  ),
                ),
              );
            } else {
              Utils.showToast(DialogueService.gameDeletedText.tr);
              return const LoadingScreen();
            }
          }),
    );
  }
}
