import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/providers/sound_provider.dart';
import 'package:six_me_ludo_android/providers/user_provider.dart';
import 'package:six_me_ludo_android/screens/game/offline_game_screen.dart';
import 'package:six_me_ludo_android/screens/game/online_game_screen.dart';

class GameScreenWrapper extends StatefulWidget {
  static String routeName = '/GameScreenWrapper';

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
    navProvider.initialiseGameScreenTabController(
      this,
      gameProvider.getGameTabControllerLength(userProvider.getUserIsOffline()),
      gameProvider.currentGame!.hasStarted || gameProvider.currentGame!.isOffline ? 1 : 0,
    );
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

    return WillPopScope(
      onWillPop: () async {
        navProvider.handleGameScreenBackPress(gameProvider);
        soundProvider.endGameLoopSound();
        return false;
      },
      child: userProvider.getUserIsOffline()
          ? OfflineGameScreen(
              gameProvider: gameProvider,
              userProvider: userProvider,
              navProvider: navProvider,
              soundProvider: soundProvider,
            )
          : OnlineGameScreen(
              gameProvider: gameProvider,
              userProvider: userProvider,
              navProvider: navProvider,
              soundProvider: soundProvider,
            ),
    );
  }
}
