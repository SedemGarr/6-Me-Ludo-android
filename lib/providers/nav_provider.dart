import 'package:flutter/material.dart';
import 'package:six_me_ludo_android/providers/game_provider.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../constants/app_constants.dart';
import '../services/navigation_service.dart';

class NavProvider with ChangeNotifier {
  int _bottomNavBarIndex = 1;
  //
  PageController pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );

  late TabController gameScreenTabController;

  Future<void> setBottomNavBarIndex(int index, bool shouldSync) async {
    _bottomNavBarIndex = index;
    notifyListeners();

    if (shouldSync) {
      await pageController.animateToPage(index, duration: AppConstants.animationDuration, curve: AppConstants.animationCurve);
    }
  }

  Future<void> setBottomNavBarIndexInInit(int index) async {
    _bottomNavBarIndex = index;

    if (pageController.hasClients) {
      await pageController.animateToPage(index, duration: AppConstants.animationDuration, curve: AppConstants.animationCurve);
    }
  }

  void initialiseGameScreenTabController(TickerProvider vsync) {
    gameScreenTabController = TabController(initialIndex: 1, length: 3, vsync: vsync);
  }

  void handleHomeWrapperBackPress(BuildContext context) {
    if (_bottomNavBarIndex != 1) {
      setBottomNavBarIndex(1, true);
    } else {
      Utils.showExitDialog(context);
    }
  }

  void handleGameScreenBackPress(GameProvider gameProvider) {
    if (gameScreenTabController.index != 1) {
      gameScreenTabController.animateTo(1);
    } else {
      gameProvider.togglePresence();
      NavigationService.genericGoBack();
    }
  }

  int getBottomNavBarIndex() {
    return _bottomNavBarIndex;
  }
}
