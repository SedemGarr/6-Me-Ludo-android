import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/screens/home/home.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../constants/app_constants.dart';
import '../services/navigation_service.dart';

class NavProvider with ChangeNotifier {
  int _bottomNavBarIndex = HomeScreen.routeIndex;
  //
  PageController pageController = PageController(
    initialPage: HomeScreen.routeIndex,
    keepPage: true,
  );

  late TabController newGameTabController;
  late TabController gameScreenTabController;

  Future<void> setBottomNavBarIndex(int index, bool shouldSync) async {
    _bottomNavBarIndex = index;
    notifyListeners();

    if (shouldSync) {
      pageController.animateToPage(index, duration: AppConstants.animationDuration, curve: AppConstants.animationCurve);
    }
  }

  Future<void> setBottomNavBarIndexInInit(int index) async {
    _bottomNavBarIndex = index;

    if (pageController.hasClients) {
      await pageController.animateToPage(index, duration: AppConstants.animationDuration, curve: AppConstants.animationCurve);
    }
  }

  void initialiseNewGameScreenTabController(TickerProvider vsync, int length) {
    newGameTabController = TabController(initialIndex: 0, length: length, vsync: vsync);
  }

  void initialiseGameScreenTabController(TickerProvider vsync, int length) {
    gameScreenTabController = TabController(initialIndex: 1, length: length, vsync: vsync);
  }

  void handleHomeWrapperBackPress(BuildContext context) {
    if (_bottomNavBarIndex != HomeScreen.routeIndex) {
      setBottomNavBarIndex(HomeScreen.routeIndex, true);
    } else {
      Utils.showExitDialog(context);
    }
  }

  void handleGameScreenBackPress(GameProvider gameProvider) {
    if (gameScreenTabController.index != 1) {
      gameScreenTabController.animateTo(1);
    } else {
      gameProvider.setGamePresence(false);
      NavigationService.goToBackToHomeScreen();
    }
  }

  int getBottomNavBarIndex() {
    return _bottomNavBarIndex;
  }
}
