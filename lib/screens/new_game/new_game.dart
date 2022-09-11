import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/host.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/join.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../widgets/app_bar_title_widget.dart';
import '../../widgets/custom_appbar.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      animationDuration: AppConstants.animationDuration,
      child: Scaffold(
        appBar: CustomAppBarWidget(
          centerTitle: true,
          title: AppBarTitleWidget(text: DialogueService.newGameAppBarTitleText.tr),
          bottom: TabBar(
            tabs: [
              Tab(
                text: DialogueService.startGameButtonText.tr,
              ),
              Tab(
                text: DialogueService.joinGameButtonText.tr,
              ),
            ],
          ),
          size: (kToolbarHeight + kTextTabBarHeight),
        ),
        body: const TabBarView(children: [
          HostGameView(),
          JoinGameView(),
        ]),
      ),
    );
  }
}
