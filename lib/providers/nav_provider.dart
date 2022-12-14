import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';

import '../services/navigation_service.dart';

class NavProvider with ChangeNotifier {
  late TabController newGameTabController;
  late TabController gameScreenTabController;

  void initialiseNewGameScreenTabController(TickerProvider vsync, int length) {
    newGameTabController = TabController(initialIndex: 0, length: length, vsync: vsync);
  }

  void initialiseGameScreenTabController(TickerProvider vsync, int length, int intitialIndex) {
    gameScreenTabController = TabController(initialIndex: intitialIndex, length: length, vsync: vsync);
  }

  void handleHomeWrapperBackPress(BuildContext context) {
    AppProvider.showExitDialog(context);
  }

  void handleGameScreenBackPress(GameProvider gameProvider) {
    if (gameScreenTabController.index != 1) {
      gameScreenTabController.animateTo(1);
    } else {
      gameProvider.setGamePresence(false);
      NavigationService.goToHomeScreen();
    }
  }

  int getGameScreenTabControllerIndex() {
    return gameScreenTabController.index;
  }

  bool isChatScreenActive() {
    return getGameScreenTabControllerIndex() == 2;
  }
}
