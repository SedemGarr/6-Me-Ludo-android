import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/screens/home/home.dart';
import 'package:six_me_ludo_android/screens/home/widgets/bottom_navbar.dart';
import 'package:six_me_ludo_android/screens/new_game/new_game.dart';
import 'package:six_me_ludo_android/screens/profile/profile.dart';

import '../../utils/utils.dart';

class HomePageViewWrapper extends StatelessWidget {
  const HomePageViewWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    NavProvider navProvider = context.watch<NavProvider>();

    return WillPopScope(
      onWillPop: () async {
        Utils.showExitDialog(context);
        return false;
      },
      child: Scaffold(
        body: PageView(
          controller: navProvider.pageController,
          onPageChanged: (index) => navProvider.setBottomNavBarIndex(index, false),
          children: const [
            ProfileScreen(),
            HomeScreen(),
            NewGameScreen(),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
      ),
    );
  }
}
