import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/models/game.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/screens/game/tabs/board/board.dart';
import 'package:six_me_ludo_android/screens/game/tabs/chat/chat.dart';
import 'package:six_me_ludo_android/screens/game/tabs/players/players.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/utils/utils.dart';
import 'package:six_me_ludo_android/widgets/custom_appbar.dart';
import 'package:six_me_ludo_android/widgets/loading_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late GameProvider gameProvider;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(initialIndex: 1, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = context.watch<GameProvider>();
    gameProvider.initialiseBoard(context);

    return StreamBuilder<Game>(
        stream: gameProvider.currentGameStream,
        initialData: gameProvider.currentGame,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasData) {
            gameProvider.syncGameData(snapshot.data!);

            return Scaffold(
              appBar: CustomAppBarWidget(
                bottom: TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(
                      text: DialogueService.playerTabText.tr,
                    ),
                    Tab(
                      text: DialogueService.boardTabText.tr,
                    ),
                    Tab(
                      text: DialogueService.chatTabText.tr,
                    ),
                  ],
                ),
                size: AppConstants.customAppbarWithTabbarHeight,
              ),
              body: TabBarView(controller: tabController, children: const [PlayersWidget(), BoardWidget(), ChatWidget()]),
            );
          } else {
            Utils.showToast(DialogueService.gameDeletedText.tr);
            return const LoadingScreen();
          }
        });
  }
}
