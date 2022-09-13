import 'package:flutter/cupertino.dart';
import 'package:six_me_ludo_android/utils/utils.dart';

import '../constants/app_constants.dart';

class NavProvider with ChangeNotifier {
  int _bottomNavBarIndex = 1;
  PageController pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );

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

  void handleHomeWrapperBackPress(BuildContext context) {
    if (_bottomNavBarIndex != 1) {
      setBottomNavBarIndex(1, true);
    } else {
      Utils.showExitDialog(context);
    }
  }

  int getBottomNavBarIndex() {
    return _bottomNavBarIndex;
  }
}
