import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:six_me_ludo_android/providers/app_provider.dart';
import 'package:six_me_ludo_android/providers/nav_provider.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/host_game.dart';
import 'package:six_me_ludo_android/screens/new_game/widgets/join_game.dart';
import 'package:six_me_ludo_android/services/navigation_service.dart';
import 'package:six_me_ludo_android/services/translations/dialogue_service.dart';
import 'package:six_me_ludo_android/widgets/back_button_widget.dart';

import '../../constants/app_constants.dart';
import '../../utils/utils.dart';
import '../../widgets/app_bar_title_widget.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/loading_screen.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    NavProvider navProvider = context.read<NavProvider>();
    navProvider.initialiseNewGameScreenTabController(this, 2);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = context.watch<AppProvider>();
    NavProvider navProvider = context.watch<NavProvider>();

    return appProvider.isLoading
        ? const LoadingScreen()
        : GestureDetector(
            onTap: () {
              Utils.dismissKeyboard();
            },
            child: Scaffold(
              appBar: CustomAppBarWidget(
                leading: BackButtonWidget(
                  onPressed: () {
                    NavigationService.genericGoBack();
                  },
                ),
                title: AppBarTitleWidget(text: DialogueService.newGameAppBarTitleText.tr),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(AppConstants.customAppbarWithTabbarHeight),
                  child: TabBar(
                    controller: navProvider.newGameTabController,
                    tabs: [
                      Tab(
                        text: DialogueService.hostGameFABText.tr,
                      ),
                      Tab(
                        text: DialogueService.joinGameFABText.tr,
                      ),
                    ],
                  ),
                ),
                size: AppConstants.customAppbarWithTabbarHeight,
              ),
              body: TabBarView(
                controller: navProvider.newGameTabController,
                children: const [HostNewGameView(), JoinOngoingGameView()],
              ),
            ),
          );
  }
}
