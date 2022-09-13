import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/constants/app_constants.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/host.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/join.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';

import '../../widgets/app_bar_title_widget.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/loading_screen.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppProvider appProvider = context.watch<AppProvider>();

    return appProvider.isLoading
        ? const LoadingScreen()
        : DefaultTabController(
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
                size: AppConstants.customAppbarWithTabbarHeight,
              ),
              body: const TabBarView(children: [
                HostGameView(),
                JoinGameView(),
              ]),
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
