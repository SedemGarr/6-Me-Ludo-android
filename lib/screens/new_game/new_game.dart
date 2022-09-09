import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_me_ludo_android/constants/textstyle_constants.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/host.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/join.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/back_button_widget.dart';

import '../../widgets/custom_appbar.dart';

class NewGameScreen extends StatelessWidget {
  const NewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBarWidget(
          centerTitle: true,
          leading: const BackButtonWidget(onPressed: NavigationService.genericGoBack),
          title: Text(
            DialogueService.newGameAppBarTitleText.tr,
            style: TextStyles.appBarTitleStyle(Get.isDarkMode ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          bottom: TabBar(tabs: [
            Tab(
              text: DialogueService.startGameButtonText.tr,
            ),
            Tab(
              text: DialogueService.joinGameButtonText.tr,
            ),
          ]),
        ),
        body: const TabBarView(children: [HostGameView(), JoinGameView()]),
      ),
    );
  }
}
